module main
import os
import math
import gfx
import rand 
import gg 

const (
    scene_filenames = [
        'Final_ball',
        'Final_cube'
        'Final_sub',
        'Final_uni',
        'Final_inter'
        'Final_capsule',
        'Final_smooth_uni',
        'Final_displace',
        'Final_rep', 
        'Final_test',
        'Final_test2',
        'Final_creative_artifact',
    ]
)

type Point     = gfx.Point
type Vector    = gfx.Vector
type Direction = gfx.Direction
type Normal    = gfx.Normal
type Ray       = gfx.Ray
type Color     = gfx.Color
type Image     = gfx.Image

type Intersection = gfx.Intersection
type Surface      = gfx.Surface
type Scene        = gfx.Scene

const (
    max_march_steps = 225
    min_dist = 0.0
    max_dist = 100.0
    epsilon = 0.01
    width = 400
    height = 400
)

fn op_subtraction (d1 f64, d2 f64) f64 {
    return math.max(-d1, d2)
}

fn op_union (d1 f64, d2 f64) f64 {
    return math.min(d1, d2)
}

fn op_intersection (d1 f64, d2 f64) f64 {
    return math.max(d1, d2)
}

fn mix(a f64, b f64, t f64) f64 {
    return a * (1.0 - t) + b * t
}


fn op_smooth_uni (d1 f64, d2 f64, k f64) (f64, f64) {
    mut h := math.clamp(0.5 + 0.5 * (d2 - d1) / k, 0.0, 1.0)
    dist := mix(d2, d1, h) - k * h * (1.0 - h)
    return dist, h
}


fn displacement(sample_point Point) f64 {
    return 0.1 * math.sin(sample_point.x * 20.0) * math.sin(sample_point.y * 20.0) * math.sin(sample_point.z * 20.0)
}

fn displacement2(sample_point Point) f64 {
    return math.sin(sample_point.x * 20.0) * math.sin(sample_point.y * 20.0) * math.sin(sample_point.z * 20.0)
}


fn op_repetition(sample_point Point, s f64, l Point, surface Surface) (f64, Surface) {
    clamp_x := math.clamp(math.round(sample_point.x / s), -l.x, l.x)
    clamp_y := math.clamp(math.round(sample_point.y / s), -l.y, l.y)
    clamp_z := math.clamp(math.round(sample_point.z / s), -l.z, l.z)

    qx := sample_point.x - s * clamp_x
    qy := sample_point.y - s * clamp_y
    qz := sample_point.z - s * clamp_z
    
    q := Point{qx, qy, qz} 

    dist, rep_surface := objects_sdf(q, surface)
    return dist, rep_surface
}



fn objects_sdf (sample_point Point, surface Surface) (f64, Surface) {
    match surface.shape {
        .sphere {
            return surface.frame.o.distance_to(sample_point) - surface.radius, surface
        }
        .box {
            p_vector := (surface.frame.w2l_point(sample_point)).as_vector()
            abs_p_vector := Vector {
                math.abs(p_vector.x),
                math.abs(p_vector.y),
                math.abs(p_vector.z)
            }
            b := Vector {
                x: surface.length,
                y: surface.width,
                z: surface.height
            }
            q := (abs_p_vector).sub(b)
            out_dist := Vector {
                math.max(q.x, 0),
                math.max(q.y, 0),
                math.max(q.z, 0)
            }.length()

             in_dist := math.min(math.max(q.x, math.max(q.y, q.z)), 0)
        //     //return math.max(q, 0.0) + math.min(math.max(q.x, math.max(q.y, q.z)), 0).magnitude()
            //box_sdf := out_dist + in_dist
            return out_dist + in_dist, surface
        }

        .capsule {
            mut p_y := surface.frame.w2l_point(sample_point).as_vector()
            p_y = Vector{p_y.x, p_y.y - math.clamp(p_y.y, 0.0, surface.height), p_y.z}
            return p_y.length() - surface.radius, surface
        }

        .torus {
            p := surface.frame.w2l_point(sample_point).as_vector()
            q := Vector{
                x: Vector{p.x, 0.0, p.z}.length() - surface.radius,
                y: p.y,
                z: 0.0,
            }
            return q.length() - surface.minor_radius, surface
        }


        .sub_op {
            if surface.children.len >= 2 {
                d1, s1 := objects_sdf(sample_point, surface.children[1])
                d2, s2 := objects_sdf(sample_point, surface.children[0])
                dist := op_subtraction(d1, d2)
                if dist == d1 {
                    return dist, s1
                } else {
                    return dist, s2
                }
            }
        }
        .uni_op {
            if surface.children.len >= 2 {
                d1, s1 := objects_sdf(sample_point, surface.children[0])
                d2, s2 := objects_sdf(sample_point, surface.children[1])
                dist := op_union(d1, d2)
                if dist == d1 {
                    return dist, s1
                } else {
                    return dist, s2
                }
            }
        }
        .inter_op {
            if surface.children.len >= 2 {
                d1, s1 := objects_sdf(sample_point, surface.children[1])
                d2, s2 := objects_sdf(sample_point, surface.children[0])
                dist := op_intersection(d1, d2)
                if dist == d1 {
                    return dist, s1
                } else {
                    return dist, s2
                }
            }
        }
        .smooth_uni {
            if surface.children.len >= 2 {
                d1, s1 := objects_sdf(sample_point, surface.children[1])
                d2, s2 := objects_sdf(sample_point, surface.children[0])
                dist, h := op_smooth_uni(d1, d2, surface.k)
    
                // Blend materials
                blended_material := gfx.Material {
                    kd: s1.material.kd.scale(1.0 - h).add(s2.material.kd.scale(h)),
                    ks: s1.material.ks.scale(1.0 - h).add(s2.material.ks.scale(h)),
                    kr: s1.material.kr.scale(1.0 - h).add(s2.material.kr.scale(h)),
                    n: s1.material.n * (1.0 - h) + s2.material.n * h
                }
        
                blended_surface := Surface {
                    shape: surface.shape,
                    frame: surface.frame,
                    material: blended_material,
                }
                return dist, blended_surface
            }
        }
        .displace_op {
            if surface.children.len >= 1 {
                d1, surface1 := objects_sdf(sample_point, surface.children[0])
                d2 := displacement(sample_point)
                dist := d1 + d2
                return dist, surface
            }
        }
        .displace2 {
            if surface.children.len >= 1 {
                d1, surface1 := objects_sdf(sample_point, surface.children[0])
                d2 := displacement2(sample_point)
                dist := d1 + d2
                return dist, surface
            }
        }
        .limited_op {
            if surface.children.len >= 1 {
                return op_repetition(sample_point, surface.s, surface.l, surface.children[0])
            }
        }
        else {}
    } 
    return max_dist, surface
}


// Render the scene with the objects inside it
fn scene_sdf(sample_point Point, scene Scene) Intersection {
	mut closest_dist := max_dist
    mut closest_inter := gfx.no_intersection

	for surface in scene.surfaces {
		dist, closest_surface := objects_sdf(sample_point, surface)
		if dist < closest_dist {
			closest_dist = dist
            normal := surface.frame.o.direction_to(sample_point) 
		    closest_inter = gfx.Intersection {
			    frame : gfx.frame_oz(sample_point, normal)
			    surface : closest_surface
			    distance: closest_dist
		    }
		}
	}
	return closest_inter
}

fn raymarch(ray Ray, scene Scene) Intersection {
	mut depth := min_dist 
	for _ in 0 .. max_march_steps {
		intersection := scene_sdf(ray.e.add(ray.d.scale(depth)), scene)
		if intersection.miss() {
			return gfx.no_intersection
		}
		dist := intersection.distance  //scene_sdf(eye.add(direction.scale(depth)), scene)
		if dist < epsilon {
			return intersection
		}
		depth = depth + dist
		if depth >= max_dist {
			return gfx.no_intersection 
		}
	}	
	return gfx.no_intersection 
}


fn ray_direction(scene Scene, x int, y int) Direction {
    u := f64(x) / scene.camera.sensor.resolution.width
    v := 1 - f64(y) / scene.camera.sensor.resolution.height
    
    // Calculate the point on the sensor plane
    q := scene.camera.frame.o.add(
        scene.camera.frame.x.scale((u - 0.5) * scene.camera.sensor.size.width)
    ).add(
        scene.camera.frame.y.scale((v - 0.5) * scene.camera.sensor.size.height)
    ).sub(
        scene.camera.frame.z.scale(scene.camera.sensor.distance)
    )
    
    // Calculate the ray direction from the camera origin to the point q
    ray_dir := scene.camera.frame.o.direction_to(q)
    
    return ray_dir
}




fn light_irradiance (scene Scene, ray Ray) Color {
	mut accum := gfx.black

	inter := raymarch(ray, scene)
	if inter.miss() { // if not hit, returns scene's background intesity
        return scene.background_color
    }

	ambient := inter.surface.material.kd.mult(scene.ambient_color)
    accum = accum.add(ambient)

    for light in scene.lights {
        s_p := light.frame.o.distance_squared_to(inter.frame.o)
        light_response := light.kl.scale(1 / s_p)
        light_direction := inter.frame.o.direction_to(light.frame.o) // compute light direction
        shadow_ray := gfx.Ray {
            e : inter.frame.o
            d : light_direction
            t_min : ray.t_min
            t_max : inter.frame.o.distance_to(light.frame.o)
        }
        // light visibiity 
        shadow_inter := raymarch(shadow_ray, scene)
        l := inter.frame.o.direction_to(light.frame.o) // l as direction
        v := inter.frame.o.direction_to(ray.e) // v as direction
        //h := l.add(v).normalize() // halfway vector
        h := (l.as_vector() + v.as_vector()).as_direction()
        // material response
        brdf := (inter.surface.material.ks.scale(math.pow(math.max(0.0, inter.frame.z.dot(h)), inter.surface.material.n)))

        accum = accum + light_response.mult(inter.surface.material.kd.add(brdf)).scale(math.abs(inter.frame.z.dot(l))) //* occluded)

    if  inter.surface.material.kr.lightness() > 0 {
        reflect_direction := ray.d.negate().reflect(inter.frame.z)
        reflect_ray := gfx.Ray {
            e : inter.frame.o
            d : reflect_direction
            t_min : ray.t_min //f64(10e-5)
            t_max : ray.t_max // f64(math.inf(1))
        }
        reflect_color := light_irradiance(scene, reflect_ray)
        accum = accum + reflect_color.mult(inter.surface.material.kr)


    }
    //return accum

    }
    return accum
}


fn main_image(mut image Image, scene Scene) {
    eye := scene.camera.frame.o

    for y in 0 .. image.size.height {
        for x in 0 .. image.size.width {
            // Compute u and v for the current pixel
            u := f64(x) / scene.camera.sensor.resolution.width
            v := 1 - f64(y) / scene.camera.sensor.resolution.height

            // Compute the direction for the current pixel using the camera's frame
            q := scene.camera.frame.o
                .add(scene.camera.frame.x.scale((u - 0.5) * scene.camera.sensor.size.width))
                .add(scene.camera.frame.y.scale((v - 0.5) * scene.camera.sensor.size.height))
                .sub(scene.camera.frame.z.scale(scene.camera.sensor.distance))

            ray_dir := scene.camera.frame.o.direction_to(q)
            //direction := (eye.sub(q)).direction() // Normalize the direction vector // ray_direction(scene, size, pixel_coords).as_direction()

            ray := Ray{
                e: eye,
                d: ray_dir,
                t_min: min_dist,
                t_max: max_dist,
            }

            mut pixel_color := scene.background_color // Default to the background color

            inter := raymarch(ray, scene)
            if inter.hit() {
                pixel_color = light_irradiance(scene, ray)
            }

            image.set_xy(x, y, pixel_color)
        }
    }
}







fn main() {
    // Make sure images folder exists, because this is where all generated images will be saved
    os.mkdir_all('output') or { panic(err) }

    for filename in scene_filenames {
        println('Rendering ${filename}...')
        scene := gfx.scene_from_file('scenes/${filename}.json')!
        mut image := Image {
            size: gfx.Size2i{width, height}
            data: [][]gfx.Color{len: height, init: []gfx.Color{len: width, init: Color{0.0, 0.0, 0.0}}}
        }
        main_image(mut image, scene)
        image.save_png('output/${filename}.png') //or { panic(err) }
    }

    println('Done!')
}
