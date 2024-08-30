**Final Project - Jada Jones**



Purpose
========

__Purpose/Goal:__
We had many options for the final project in CS77. We could have worked with a partner or group, or by ourselves. We also 
had the option to implement more aspects to previous assignments, like the rasterization or the raytrace project. Although I enjoyed 
both of those assignments thoroughly I decided to implement my own renderer and create a raymarching renderer. 




Submission
-----------
Each feature of the project is given its own section in the form of a demo. This will show the specific code that created the demo, as well 
as the json file and a picture demonstrating the feature. At the bottom there will be a section of the full code. Each feature will have a short 
reflection with detailing, how the feature was created, and changes I had to make to scene files or other files in order to get the feature to be 
implemented correctly. 


Author
=============

<!-- Note: wrapping table in div.noheader will hide the table's header -->
<!-- Note: wrapping table in div.firstcol will style the first column different from other columns -->
<div class="noheader firstcol">
                  |             
------------------|-------------
name              | Jada Jones
computer + OS     | My MacBook Pro
time to complete  | 10 Hours
Final Comments    | Bottom of Page
</div>


Link to resource I used: https://iquilezles.org/articles/raymarchingdf/ 


What is Ray Marching
=================
Ray marching is rendering technique that iteratively traversing rays to render scenes with signed distance functions. It uses these SDFs to determine a maximum safe step-size. It sees how far it can go without touching an object. This allows you to do cool things with the geometry that is in the scenes. Subtract objects from one another, unify them through union, and even get the intersection of two objects that are touching. There are so many signed distance functions for different shapes, allowing you to create cool scenes and cretae weird geometry. 



Project Features
================


Subtraction
--------------------------------
__Reflection:__ For the subtraction feature using the website that Inigo Quilez has helped alot. The implementation 
was pretty straight forward and allowed for me to easily create a function. To actually get the objects to be subtracted from 
one another, I created an object in the scene.v file that was called sub_op. I did this for all of the objects in the objects_sdf 
function. This enabled me to just call the op_subtraction function inside of the objects_sdf function. What you will see in majority 
of the functions and the objects, is that there is an extra surface. This is because it would not allow me to get the surface color of each 
object, if there were more than one in a scene, in the scene. It would just pick the larger objects color. Have it return the distance and 
the surface, allowed me to work around that. 

![Final_sub](https://github.com/user-attachments/assets/a5757084-38f4-429f-ab68-0d4c0f875b4f)

Intersection
--------------------------------
__Reflection:__For intersection, this implementation was also pretty easy and straightforward. It was like once 
you got one implementation down, just changing one thing about another allowed it to all come together. This takes the max
of d1 and d2. When I think about this, I think about a venn diagram, specifically the middel part of the venn diagram, where 
the two circles intersect. I again, went into scene.v and created a inter_op object. 


![A picture showing the intersection feature!](output/Final_inter.png)


Union
--------------------------------
__Reflection:__For the union implementation, it was easy to implement, but was confusing in the sense, that
you could just place an object on top of another without having to do the function for the implementation. 
However, when it came to the smoothing of the union I saw the benefit greatly. This implementation was good
but I felt the subtraction and intersection implementations were cooler. 

![A picture showing the union feature!](output/Final_uni.png)


Displacement
--------------------------------
__Reflection:__The displacement implementation was pretty cool in the sense that you could essentually have 
any type of displacement. Using sin and cosine, as well as different values, would give you different types of displacement. 
I tried out multiple variations and will use some of them in the creative artifact. One thing I noticed is that if i get rid of 
the 0.1 at the beginning of the return in the function for displacement, then it gives a weird design. I will use that variation for the final creative artifact.


Code for Displacement: 

![A picture showing the displacement feature!](output/Final_displace.png)


Smoothing Union
--------------------------------
__Reflection:__This I think is my favorite implementation. It was confusing trying to understand the different values, for what
k, and h are, but after that I was able to fully understand it. At first, it was giving me weird outputs, like big blobs. 
But then I realized that I needed to add the k value to a feature of a surface. I changed that in the scene.v file so that way
in json files I could change the k value and it would not be hard coded. Once I did get it, I realized that the colors again
were not blending. I talked to Professor Denning and he mentioned that we did color blends in a previous assignment. I used that 
to help me make the blend material for the function. Once I finally got it to work, it was so cool to see. I think this was the 
best implementation by far because of how cool the color blend looks. I then made a new durface with the blended material, and called
that in with the distance so that it would take that color rather than two seperate colors of the objects. 

Code for Smoothing Union: 

![A picture showing the smooth union feature!](output/Final_smooth_uni.png)


Limited Repetition
--------------------------------
__Reflection:__For limited repetition, I ran into some errors regarding the L. In the example on the website, they 
have l being a vector, I was running into a lot of errors with that as you cannot negate certain things, or use a '-'. 
I changed it to a point and added it to the scene.v as an attribute under the surfaces. This allows for anyone in a json 
file to change how many repetitions there are. I was originally going to do infinite repetitions, but I thought that this 
would one taje forever to run, and take up alot of space on my laptop. And for what I am doing the limited repetition 
works perfectly. Also with this you can add multuiple operations under it. I have also added subtraction operations with a box
and a sphere under it and had that as limited repetition as well. 

Code for Limited Repetition: 

![A picture showing the limited repetition feature!](output/Final_rep.png)


Creative Artifact
======================
I was very unsure what to do for my creativr artifact, so I implemented majority of every feature in the artifact. 
It reminds me of like an amusement park, but can also be called abstract. I have the sub operation, the smooth union operation, the displacement operation, as well as just the regular union. I was going to add limited repetition but was unable to implement it in a way that I liked. However, other outputs in the project, showcase cool things I did with limited repetition. 


![A picture showing the creative artifact!](output/Final_creative_artifact.png)




Other Cool Things I Created!!
--------------------------------

![Extra Feature!](output/Final_test.png)

![Extra Feature!](output/Final_uni2.png)




Project Reflection
======================
Throughout this final project, I had the opportunity to delve deeply into the world of computer graphics, specifically focusing on ray marching. My goal was to create a custom ray marching renderer that could handle various operations such as subtraction, intersection, and union of objects, as well as implement displacement techniques. Reflecting on this journey, I can confidently say that this project was both challenging and rewarding. I knew my implementations were correct based off of feedback from Professor Denning and being able to see Inigo Quilez results. 

Learning Experience:
The decision to build a ray marching renderer from scratch was driven by my desire to explore a different approach to rendering than what we had previously covered in class, like rasterization and ray tracing. Ray marching intrigued me because of its flexibility in creating complex geometries and its ability to handle signed distance functions (SDFs) efficiently. I started with a solid understanding of ray tracing but quickly realized that ray marching required a different mindset, particularly in how objects and scenes are constructed and rendered.

Challenges:
One of the main challenges I encountered was ensuring that each operation (subtraction, intersection, union) worked seamlessly within the overall rendering pipeline. Although the mathematical concepts behind these operations are relatively straightforward, implementing them in a way that integrates well with the scene structure required careful consideration. The need to return both distance and surface information to correctly render objects with multiple surfaces was a particularly tricky aspect, as it involved modifying how the renderer interpreted the scene file.

Another challenge was in managing the complexity of the displacement feature. Displacement allows for intricate surface details, but it also introduces the risk of creating artifacts or unexpected results if not handled properly. Fine-tuning the displacement functions to achieve visually appealing results while maintaining performance was a delicate balancing act.

Reflection on Features:

Subtraction: This feature allowed me to create complex shapes by subtracting one object from another. Implementing this was a learning curve, especially in understanding how to correctly handle surface colors and ensuring that the larger object’s surface didn’t dominate the final result. The outcome was satisfying as it enabled me to create more intricate scenes.

Intersection: The intersection operation was conceptually simple but required careful implementation to ensure that only the intersecting parts of the objects were rendered. This feature reminded me of the importance of precision in mathematical operations, especially when dealing with floating-point values in a 3D space.

Union: Union was perhaps the most straightforward of the operations, but its true potential was revealed when combined with the smoothing operations. This feature allowed me to blend objects in a way that wasn’t possible with simple stacking, providing a more cohesive and organic look to the scenes.

Displacement: Displacement was by far the most visually impactful feature I implemented. It allowed for a great deal of creativity, and I enjoyed experimenting with different functions to see how they affected the surface of the objects. The flexibility of this feature was both a blessing and a curse, as it was easy to create something that looked interesting, but difficult to avoid performance issues or rendering artifacts.

Creative Artifact:
The final creative artifact, where I combined all these features, was the culmination of my work. It demonstrated the full potential of the ray marching renderer and allowed me to express the artistic side of computer graphics. By tweaking the displacement and combining various operations, I was able to create a scene that was both technically complex and aesthetically pleasing.

Overall, I thoroughly enjoyed this project and would love to keep working in it. I will for sure be creating more scenes using this ray marching project, and hopefully be able to animate it as well. 








<!--   Feel free to modify the following to fit a theme of your choosing   -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet"> <!-- a sans-serif font -->
<style>  /* A TAYLOR-INSPIRED THEME */
    body {font-family:'Open Sans',sans-serif;}
    .md a:link, .md a:visited {color:hsl(252, 88%, 34%); font-family:'Open Sans',sans-serif;}
    .md table.table th {background-color:hsl(252, 25%, 65%);}
    .md .noheader th {display:none;}
    .md .firstcol td:first-child {white-space:pre;color:white;vertical-align:top;font-weight:bold;border-color:black;background:hwb(182 32% 47%);}
    .md .firstcol tr:nth-child(even) td:first-child {background:hsl(333, 23%, 44%);}
</style>


<!-- ****************************** -->
<!--    Leave the content below     -->
<!-- ****************************** -->

<!-- The script and style below are added for clarity and to workaround a bug -->
<script>
    // this is a hack to workaround a bug in Markdeep+Mathjax, where
    // `$`` is automatically converted to `\(`` and `\)`` too soon.
    // the following code will replace the innerHTML of all elements
    // with class "dollar" with a dollar sign.
    setTimeout(function() {
        var dollars = document.getElementsByClassName('dollar');
        for(var i = 0; i < dollars.length; i++) {
            dollars[i].innerHTML = '&#' + '36;'; // split to prevent conversion to $
        }
    }, 1000);
</script>
<style>
    /* adding some styling to <code> tags (but not <pre><code> coding blocks!) */
    :not(pre) > code {
        background-color: rgba(0,0,0,0.05);
        outline: 1px solid rgba(0,0,0,0.15);
        margin-left: 0.25em;
        margin-right: 0.25em;
    }
    /* fixes table of contents of medium-length document from looking weird if admonitions are behind */
    .md div.mediumTOC { background: white; }
    .md div.admonition { position: initial !important; }
</style>

<!--   Leave the following Markdeep formatting code, as this will format your text above to look nice in a wed browser   -->

<script src="https://casual-effects.com/markdeep/latest/markdeep.min.js"></script><!-- Markdeep: --><style class="fallback">body{visibility:hidden;white-space:pre;font-family:monospace}</style><script src="markdeep.min.js"></script><script src="https://casual-effects.com/markdeep/latest/markdeep.min.js?"></script><script>window.alreadyProcessedMarkdeep||(document.body.style.visibility="visible")</script>
