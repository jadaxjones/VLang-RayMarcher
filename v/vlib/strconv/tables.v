module strconv

const pow5_num_bits_32 = 61
const pow5_inv_num_bits_32 = 59
const pow5_num_bits_64 = 121
const pow5_inv_num_bits_64 = 122

const powers_of_10 = [
	u64(1e0),
	u64(1e1),
	u64(1e2),
	u64(1e3),
	u64(1e4),
	u64(1e5),
	u64(1e6),
	u64(1e7),
	u64(1e8),
	u64(1e9),
	u64(1e10),
	u64(1e11),
	u64(1e12),
	u64(1e13),
	u64(1e14),
	u64(1e15),
	u64(1e16),
	u64(1e17),
	// We only need to find the length of at most 17 digit numbers.
]!

const pow5_split_32 = [
	u64(1152921504606846976),
	u64(1441151880758558720),
	u64(1801439850948198400),
	u64(2251799813685248000),
	u64(1407374883553280000),
	u64(1759218604441600000),
	u64(2199023255552000000),
	u64(1374389534720000000),
	u64(1717986918400000000),
	u64(2147483648000000000),
	u64(1342177280000000000),
	u64(1677721600000000000),
	u64(2097152000000000000),
	u64(1310720000000000000),
	u64(1638400000000000000),
	u64(2048000000000000000),
	u64(1280000000000000000),
	u64(1600000000000000000),
	u64(2000000000000000000),
	u64(1250000000000000000),
	u64(1562500000000000000),
	u64(1953125000000000000),
	u64(1220703125000000000),
	u64(1525878906250000000),
	u64(1907348632812500000),
	u64(1192092895507812500),
	u64(1490116119384765625),
	u64(1862645149230957031),
	u64(1164153218269348144),
	u64(1455191522836685180),
	u64(1818989403545856475),
	u64(2273736754432320594),
	u64(1421085471520200371),
	u64(1776356839400250464),
	u64(2220446049250313080),
	u64(1387778780781445675),
	u64(1734723475976807094),
	u64(2168404344971008868),
	u64(1355252715606880542),
	u64(1694065894508600678),
	u64(2117582368135750847),
	u64(1323488980084844279),
	u64(1654361225106055349),
	u64(2067951531382569187),
	u64(1292469707114105741),
	u64(1615587133892632177),
	u64(2019483917365790221),
]!

const pow5_inv_split_32 = [
	u64(576460752303423489),
	u64(461168601842738791),
	u64(368934881474191033),
	u64(295147905179352826),
	u64(472236648286964522),
	u64(377789318629571618),
	u64(302231454903657294),
	u64(483570327845851670),
	u64(386856262276681336),
	u64(309485009821345069),
	u64(495176015714152110),
	u64(396140812571321688),
	u64(316912650057057351),
	u64(507060240091291761),
	u64(405648192073033409),
	u64(324518553658426727),
	u64(519229685853482763),
	u64(415383748682786211),
	u64(332306998946228969),
	u64(531691198313966350),
	u64(425352958651173080),
	u64(340282366920938464),
	u64(544451787073501542),
	u64(435561429658801234),
	u64(348449143727040987),
	u64(557518629963265579),
	u64(446014903970612463),
	u64(356811923176489971),
	u64(570899077082383953),
	u64(456719261665907162),
	u64(365375409332725730),
]!

const pow5_split_64_x = [
	u64(0x0000000000000000),
	u64(0x0100000000000000),
	u64(0x0000000000000000),
	u64(0x0140000000000000),
	u64(0x0000000000000000),
	u64(0x0190000000000000),
	u64(0x0000000000000000),
	u64(0x01f4000000000000),
	u64(0x0000000000000000),
	u64(0x0138800000000000),
	u64(0x0000000000000000),
	u64(0x0186a00000000000),
	u64(0x0000000000000000),
	u64(0x01e8480000000000),
	u64(0x0000000000000000),
	u64(0x01312d0000000000),
	u64(0x0000000000000000),
	u64(0x017d784000000000),
	u64(0x0000000000000000),
	u64(0x01dcd65000000000),
	u64(0x0000000000000000),
	u64(0x012a05f200000000),
	u64(0x0000000000000000),
	u64(0x0174876e80000000),
	u64(0x0000000000000000),
	u64(0x01d1a94a20000000),
	u64(0x0000000000000000),
	u64(0x012309ce54000000),
	u64(0x0000000000000000),
	u64(0x016bcc41e9000000),
	u64(0x0000000000000000),
	u64(0x01c6bf5263400000),
	u64(0x0000000000000000),
	u64(0x011c37937e080000),
	u64(0x0000000000000000),
	u64(0x016345785d8a0000),
	u64(0x0000000000000000),
	u64(0x01bc16d674ec8000),
	u64(0x0000000000000000),
	u64(0x01158e460913d000),
	u64(0x0000000000000000),
	u64(0x015af1d78b58c400),
	u64(0x0000000000000000),
	u64(0x01b1ae4d6e2ef500),
	u64(0x0000000000000000),
	u64(0x010f0cf064dd5920),
	u64(0x0000000000000000),
	u64(0x0152d02c7e14af68),
	u64(0x0000000000000000),
	u64(0x01a784379d99db42),
	u64(0x4000000000000000),
	u64(0x0108b2a2c2802909),
	u64(0x9000000000000000),
	u64(0x014adf4b7320334b),
	u64(0x7400000000000000),
	u64(0x019d971e4fe8401e),
	u64(0x0880000000000000),
	u64(0x01027e72f1f12813),
	u64(0xcaa0000000000000),
	u64(0x01431e0fae6d7217),
	u64(0xbd48000000000000),
	u64(0x0193e5939a08ce9d),
	u64(0x2c9a000000000000),
	u64(0x01f8def8808b0245),
	u64(0x3be0400000000000),
	u64(0x013b8b5b5056e16b),
	u64(0x0ad8500000000000),
	u64(0x018a6e32246c99c6),
	u64(0x8d8e640000000000),
	u64(0x01ed09bead87c037),
	u64(0xb878fe8000000000),
	u64(0x013426172c74d822),
	u64(0x66973e2000000000),
	u64(0x01812f9cf7920e2b),
	u64(0x403d0da800000000),
	u64(0x01e17b84357691b6),
	u64(0xe826288900000000),
	u64(0x012ced32a16a1b11),
	u64(0x622fb2ab40000000),
	u64(0x0178287f49c4a1d6),
	u64(0xfabb9f5610000000),
	u64(0x01d6329f1c35ca4b),
	u64(0x7cb54395ca000000),
	u64(0x0125dfa371a19e6f),
	u64(0x5be2947b3c800000),
	u64(0x016f578c4e0a060b),
	u64(0x32db399a0ba00000),
	u64(0x01cb2d6f618c878e),
	u64(0xdfc9040047440000),
	u64(0x011efc659cf7d4b8),
	u64(0x17bb450059150000),
	u64(0x0166bb7f0435c9e7),
	u64(0xddaa16406f5a4000),
	u64(0x01c06a5ec5433c60),
	u64(0x8a8a4de845986800),
	u64(0x0118427b3b4a05bc),
	u64(0xad2ce16256fe8200),
	u64(0x015e531a0a1c872b),
	u64(0x987819baecbe2280),
	u64(0x01b5e7e08ca3a8f6),
	u64(0x1f4b1014d3f6d590),
	u64(0x0111b0ec57e6499a),
	u64(0xa71dd41a08f48af4),
	u64(0x01561d276ddfdc00),
	u64(0xd0e549208b31adb1),
	u64(0x01aba4714957d300),
	u64(0x828f4db456ff0c8e),
	u64(0x010b46c6cdd6e3e0),
	u64(0xa33321216cbecfb2),
	u64(0x014e1878814c9cd8),
	u64(0xcbffe969c7ee839e),
	u64(0x01a19e96a19fc40e),
	u64(0x3f7ff1e21cf51243),
	u64(0x0105031e2503da89),
	u64(0x8f5fee5aa43256d4),
	u64(0x014643e5ae44d12b),
	u64(0x7337e9f14d3eec89),
	u64(0x0197d4df19d60576),
	u64(0x1005e46da08ea7ab),
	u64(0x01fdca16e04b86d4),
	u64(0x8a03aec4845928cb),
	u64(0x013e9e4e4c2f3444),
	u64(0xac849a75a56f72fd),
	u64(0x018e45e1df3b0155),
	u64(0x17a5c1130ecb4fbd),
	u64(0x01f1d75a5709c1ab),
	u64(0xeec798abe93f11d6),
	u64(0x013726987666190a),
	u64(0xaa797ed6e38ed64b),
	u64(0x0184f03e93ff9f4d),
	u64(0x1517de8c9c728bde),
	u64(0x01e62c4e38ff8721),
	u64(0xad2eeb17e1c7976b),
	u64(0x012fdbb0e39fb474),
	u64(0xd87aa5ddda397d46),
	u64(0x017bd29d1c87a191),
	u64(0x4e994f5550c7dc97),
	u64(0x01dac74463a989f6),
	u64(0xf11fd195527ce9de),
	u64(0x0128bc8abe49f639),
	u64(0x6d67c5faa71c2456),
	u64(0x0172ebad6ddc73c8),
	u64(0x88c1b77950e32d6c),
	u64(0x01cfa698c95390ba),
	u64(0x957912abd28dfc63),
	u64(0x0121c81f7dd43a74),
	u64(0xbad75756c7317b7c),
	u64(0x016a3a275d494911),
	u64(0x298d2d2c78fdda5b),
	u64(0x01c4c8b1349b9b56),
	u64(0xd9f83c3bcb9ea879),
	u64(0x011afd6ec0e14115),
	u64(0x50764b4abe865297),
	u64(0x0161bcca7119915b),
	u64(0x2493de1d6e27e73d),
	u64(0x01ba2bfd0d5ff5b2),
	u64(0x56dc6ad264d8f086),
	u64(0x01145b7e285bf98f),
	u64(0x2c938586fe0f2ca8),
	u64(0x0159725db272f7f3),
	u64(0xf7b866e8bd92f7d2),
	u64(0x01afcef51f0fb5ef),
	u64(0xfad34051767bdae3),
	u64(0x010de1593369d1b5),
	u64(0x79881065d41ad19c),
	u64(0x015159af80444623),
	u64(0x57ea147f49218603),
	u64(0x01a5b01b605557ac),
	u64(0xb6f24ccf8db4f3c1),
	u64(0x01078e111c3556cb),
	u64(0xa4aee003712230b2),
	u64(0x014971956342ac7e),
	u64(0x4dda98044d6abcdf),
	u64(0x019bcdfabc13579e),
	u64(0xf0a89f02b062b60b),
	u64(0x010160bcb58c16c2),
	u64(0xacd2c6c35c7b638e),
	u64(0x0141b8ebe2ef1c73),
	u64(0x98077874339a3c71),
	u64(0x01922726dbaae390),
	u64(0xbe0956914080cb8e),
	u64(0x01f6b0f092959c74),
	u64(0xf6c5d61ac8507f38),
	u64(0x013a2e965b9d81c8),
	u64(0x34774ba17a649f07),
	u64(0x0188ba3bf284e23b),
	u64(0x01951e89d8fdc6c8),
	u64(0x01eae8caef261aca),
	u64(0x40fd3316279e9c3d),
	u64(0x0132d17ed577d0be),
	u64(0xd13c7fdbb186434c),
	u64(0x017f85de8ad5c4ed),
	u64(0x458b9fd29de7d420),
	u64(0x01df67562d8b3629),
	u64(0xcb7743e3a2b0e494),
	u64(0x012ba095dc7701d9),
	u64(0x3e5514dc8b5d1db9),
	u64(0x017688bb5394c250),
	u64(0x4dea5a13ae346527),
	u64(0x01d42aea2879f2e4),
	u64(0xb0b2784c4ce0bf38),
	u64(0x01249ad2594c37ce),
	u64(0x5cdf165f6018ef06),
	u64(0x016dc186ef9f45c2),
	u64(0xf416dbf7381f2ac8),
	u64(0x01c931e8ab871732),
	u64(0xd88e497a83137abd),
	u64(0x011dbf316b346e7f),
	u64(0xceb1dbd923d8596c),
	u64(0x01652efdc6018a1f),
	u64(0xc25e52cf6cce6fc7),
	u64(0x01be7abd3781eca7),
	u64(0xd97af3c1a40105dc),
	u64(0x01170cb642b133e8),
	u64(0x0fd9b0b20d014754),
	u64(0x015ccfe3d35d80e3),
	u64(0xd3d01cde90419929),
	u64(0x01b403dcc834e11b),
	u64(0x6462120b1a28ffb9),
	u64(0x01108269fd210cb1),
	u64(0xbd7a968de0b33fa8),
	u64(0x0154a3047c694fdd),
	u64(0x2cd93c3158e00f92),
	u64(0x01a9cbc59b83a3d5),
	u64(0x3c07c59ed78c09bb),
	u64(0x010a1f5b81324665),
	u64(0x8b09b7068d6f0c2a),
	u64(0x014ca732617ed7fe),
	u64(0x2dcc24c830cacf34),
	u64(0x019fd0fef9de8dfe),
	u64(0xdc9f96fd1e7ec180),
	u64(0x0103e29f5c2b18be),
	u64(0x93c77cbc661e71e1),
	u64(0x0144db473335deee),
	u64(0x38b95beb7fa60e59),
	u64(0x01961219000356aa),
	u64(0xc6e7b2e65f8f91ef),
	u64(0x01fb969f40042c54),
	u64(0xfc50cfcffbb9bb35),
	u64(0x013d3e2388029bb4),
	u64(0x3b6503c3faa82a03),
	u64(0x018c8dac6a0342a2),
	u64(0xca3e44b4f9523484),
	u64(0x01efb1178484134a),
	u64(0xbe66eaf11bd360d2),
	u64(0x0135ceaeb2d28c0e),
	u64(0x6e00a5ad62c83907),
	u64(0x0183425a5f872f12),
	u64(0x0980cf18bb7a4749),
	u64(0x01e412f0f768fad7),
	u64(0x65f0816f752c6c8d),
	u64(0x012e8bd69aa19cc6),
	u64(0xff6ca1cb527787b1),
	u64(0x017a2ecc414a03f7),
	u64(0xff47ca3e2715699d),
	u64(0x01d8ba7f519c84f5),
	u64(0xbf8cde66d86d6202),
	u64(0x0127748f9301d319),
	u64(0x2f7016008e88ba83),
	u64(0x017151b377c247e0),
	u64(0x3b4c1b80b22ae923),
	u64(0x01cda62055b2d9d8),
	u64(0x250f91306f5ad1b6),
	u64(0x012087d4358fc827),
	u64(0xee53757c8b318623),
	u64(0x0168a9c942f3ba30),
	u64(0x29e852dbadfde7ac),
	u64(0x01c2d43b93b0a8bd),
	u64(0x3a3133c94cbeb0cc),
	u64(0x0119c4a53c4e6976),
	u64(0xc8bd80bb9fee5cff),
	u64(0x016035ce8b6203d3),
	u64(0xbaece0ea87e9f43e),
	u64(0x01b843422e3a84c8),
	u64(0x74d40c9294f238a7),
	u64(0x01132a095ce492fd),
	u64(0xd2090fb73a2ec6d1),
	u64(0x0157f48bb41db7bc),
	u64(0x068b53a508ba7885),
	u64(0x01adf1aea12525ac),
	u64(0x8417144725748b53),
	u64(0x010cb70d24b7378b),
	u64(0x651cd958eed1ae28),
	u64(0x014fe4d06de5056e),
	u64(0xfe640faf2a8619b2),
	u64(0x01a3de04895e46c9),
	u64(0x3efe89cd7a93d00f),
	u64(0x01066ac2d5daec3e),
	u64(0xcebe2c40d938c413),
	u64(0x014805738b51a74d),
	u64(0x426db7510f86f518),
	u64(0x019a06d06e261121),
	u64(0xc9849292a9b4592f),
	u64(0x0100444244d7cab4),
	u64(0xfbe5b73754216f7a),
	u64(0x01405552d60dbd61),
	u64(0x7adf25052929cb59),
	u64(0x01906aa78b912cba),
	u64(0x1996ee4673743e2f),
	u64(0x01f485516e7577e9),
	u64(0xaffe54ec0828a6dd),
	u64(0x0138d352e5096af1),
	u64(0x1bfdea270a32d095),
	u64(0x018708279e4bc5ae),
	u64(0xa2fd64b0ccbf84ba),
	u64(0x01e8ca3185deb719),
	u64(0x05de5eee7ff7b2f4),
	u64(0x01317e5ef3ab3270),
	u64(0x0755f6aa1ff59fb1),
	u64(0x017dddf6b095ff0c),
	u64(0x092b7454a7f3079e),
	u64(0x01dd55745cbb7ecf),
	u64(0x65bb28b4e8f7e4c3),
	u64(0x012a5568b9f52f41),
	u64(0xbf29f2e22335ddf3),
	u64(0x0174eac2e8727b11),
	u64(0x2ef46f9aac035570),
	u64(0x01d22573a28f19d6),
	u64(0xdd58c5c0ab821566),
	u64(0x0123576845997025),
	u64(0x54aef730d6629ac0),
	u64(0x016c2d4256ffcc2f),
	u64(0x29dab4fd0bfb4170),
	u64(0x01c73892ecbfbf3b),
	u64(0xfa28b11e277d08e6),
	u64(0x011c835bd3f7d784),
	u64(0x38b2dd65b15c4b1f),
	u64(0x0163a432c8f5cd66),
	u64(0xc6df94bf1db35de7),
	u64(0x01bc8d3f7b3340bf),
	u64(0xdc4bbcf772901ab0),
	u64(0x0115d847ad000877),
	u64(0xd35eac354f34215c),
	u64(0x015b4e5998400a95),
	u64(0x48365742a30129b4),
	u64(0x01b221effe500d3b),
	u64(0x0d21f689a5e0ba10),
	u64(0x010f5535fef20845),
	u64(0x506a742c0f58e894),
	u64(0x01532a837eae8a56),
	u64(0xe4851137132f22b9),
	u64(0x01a7f5245e5a2ceb),
	u64(0x6ed32ac26bfd75b4),
	u64(0x0108f936baf85c13),
	u64(0x4a87f57306fcd321),
	u64(0x014b378469b67318),
	u64(0x5d29f2cfc8bc07e9),
	u64(0x019e056584240fde),
	u64(0xfa3a37c1dd7584f1),
	u64(0x0102c35f729689ea),
	u64(0xb8c8c5b254d2e62e),
	u64(0x014374374f3c2c65),
	u64(0x26faf71eea079fb9),
	u64(0x01945145230b377f),
	u64(0xf0b9b4e6a48987a8),
	u64(0x01f965966bce055e),
	u64(0x5674111026d5f4c9),
	u64(0x013bdf7e0360c35b),
	u64(0x2c111554308b71fb),
	u64(0x018ad75d8438f432),
	u64(0xb7155aa93cae4e7a),
	u64(0x01ed8d34e547313e),
	u64(0x326d58a9c5ecf10c),
	u64(0x013478410f4c7ec7),
	u64(0xff08aed437682d4f),
	u64(0x01819651531f9e78),
	u64(0x3ecada89454238a3),
	u64(0x01e1fbe5a7e78617),
	u64(0x873ec895cb496366),
	u64(0x012d3d6f88f0b3ce),
	u64(0x290e7abb3e1bbc3f),
	u64(0x01788ccb6b2ce0c2),
	u64(0xb352196a0da2ab4f),
	u64(0x01d6affe45f818f2),
	u64(0xb0134fe24885ab11),
	u64(0x01262dfeebbb0f97),
	u64(0x9c1823dadaa715d6),
	u64(0x016fb97ea6a9d37d),
	u64(0x031e2cd19150db4b),
	u64(0x01cba7de5054485d),
	u64(0x21f2dc02fad2890f),
	u64(0x011f48eaf234ad3a),
	u64(0xaa6f9303b9872b53),
	u64(0x01671b25aec1d888),
	u64(0xd50b77c4a7e8f628),
	u64(0x01c0e1ef1a724eaa),
	u64(0xc5272adae8f199d9),
	u64(0x01188d357087712a),
	u64(0x7670f591a32e004f),
	u64(0x015eb082cca94d75),
	u64(0xd40d32f60bf98063),
	u64(0x01b65ca37fd3a0d2),
	u64(0xc4883fd9c77bf03e),
	u64(0x0111f9e62fe44483),
	u64(0xb5aa4fd0395aec4d),
	u64(0x0156785fbbdd55a4),
	u64(0xe314e3c447b1a760),
	u64(0x01ac1677aad4ab0d),
	u64(0xaded0e5aaccf089c),
	u64(0x010b8e0acac4eae8),
	u64(0xd96851f15802cac3),
	u64(0x014e718d7d7625a2),
	u64(0x8fc2666dae037d74),
	u64(0x01a20df0dcd3af0b),
	u64(0x39d980048cc22e68),
	u64(0x010548b68a044d67),
	u64(0x084fe005aff2ba03),
	u64(0x01469ae42c8560c1),
	u64(0x4a63d8071bef6883),
	u64(0x0198419d37a6b8f1),
	u64(0x9cfcce08e2eb42a4),
	u64(0x01fe52048590672d),
	u64(0x821e00c58dd309a7),
	u64(0x013ef342d37a407c),
	u64(0xa2a580f6f147cc10),
	u64(0x018eb0138858d09b),
	u64(0x8b4ee134ad99bf15),
	u64(0x01f25c186a6f04c2),
	u64(0x97114cc0ec80176d),
	u64(0x0137798f428562f9),
	u64(0xfcd59ff127a01d48),
	u64(0x018557f31326bbb7),
	u64(0xfc0b07ed7188249a),
	u64(0x01e6adefd7f06aa5),
	u64(0xbd86e4f466f516e0),
	u64(0x01302cb5e6f642a7),
	u64(0xace89e3180b25c98),
	u64(0x017c37e360b3d351),
	u64(0x1822c5bde0def3be),
	u64(0x01db45dc38e0c826),
	u64(0xcf15bb96ac8b5857),
	u64(0x01290ba9a38c7d17),
	u64(0xc2db2a7c57ae2e6d),
	u64(0x01734e940c6f9c5d),
	u64(0x3391f51b6d99ba08),
	u64(0x01d022390f8b8375),
	u64(0x403b393124801445),
	u64(0x01221563a9b73229),
	u64(0x904a077d6da01956),
	u64(0x016a9abc9424feb3),
	u64(0x745c895cc9081fac),
	u64(0x01c5416bb92e3e60),
	u64(0x48b9d5d9fda513cb),
	u64(0x011b48e353bce6fc),
	u64(0x5ae84b507d0e58be),
	u64(0x01621b1c28ac20bb),
	u64(0x31a25e249c51eeee),
	u64(0x01baa1e332d728ea),
	u64(0x5f057ad6e1b33554),
	u64(0x0114a52dffc67992),
	u64(0xf6c6d98c9a2002aa),
	u64(0x0159ce797fb817f6),
	u64(0xb4788fefc0a80354),
	u64(0x01b04217dfa61df4),
	u64(0xf0cb59f5d8690214),
	u64(0x010e294eebc7d2b8),
	u64(0x2cfe30734e83429a),
	u64(0x0151b3a2a6b9c767),
	u64(0xf83dbc9022241340),
	u64(0x01a6208b50683940),
	u64(0x9b2695da15568c08),
	u64(0x0107d457124123c8),
	u64(0xc1f03b509aac2f0a),
	u64(0x0149c96cd6d16cba),
	u64(0x726c4a24c1573acd),
	u64(0x019c3bc80c85c7e9),
	u64(0xe783ae56f8d684c0),
	u64(0x0101a55d07d39cf1),
	u64(0x616499ecb70c25f0),
	u64(0x01420eb449c8842e),
	u64(0xf9bdc067e4cf2f6c),
	u64(0x019292615c3aa539),
	u64(0x782d3081de02fb47),
	u64(0x01f736f9b3494e88),
	u64(0x4b1c3e512ac1dd0c),
	u64(0x013a825c100dd115),
	u64(0x9de34de57572544f),
	u64(0x018922f31411455a),
	u64(0x455c215ed2cee963),
	u64(0x01eb6bafd91596b1),
	u64(0xcb5994db43c151de),
	u64(0x0133234de7ad7e2e),
	u64(0x7e2ffa1214b1a655),
	u64(0x017fec216198ddba),
	u64(0x1dbbf89699de0feb),
	u64(0x01dfe729b9ff1529),
	u64(0xb2957b5e202ac9f3),
	u64(0x012bf07a143f6d39),
	u64(0x1f3ada35a8357c6f),
	u64(0x0176ec98994f4888),
	u64(0x270990c31242db8b),
	u64(0x01d4a7bebfa31aaa),
	u64(0x5865fa79eb69c937),
	u64(0x0124e8d737c5f0aa),
	u64(0xee7f791866443b85),
	u64(0x016e230d05b76cd4),
	u64(0x2a1f575e7fd54a66),
	u64(0x01c9abd04725480a),
	u64(0x5a53969b0fe54e80),
	u64(0x011e0b622c774d06),
	u64(0xf0e87c41d3dea220),
	u64(0x01658e3ab7952047),
	u64(0xed229b5248d64aa8),
	u64(0x01bef1c9657a6859),
	u64(0x3435a1136d85eea9),
	u64(0x0117571ddf6c8138),
	u64(0x4143095848e76a53),
	u64(0x015d2ce55747a186),
	u64(0xd193cbae5b2144e8),
	u64(0x01b4781ead1989e7),
	u64(0xe2fc5f4cf8f4cb11),
	u64(0x0110cb132c2ff630),
	u64(0x1bbb77203731fdd5),
	u64(0x0154fdd7f73bf3bd),
	u64(0x62aa54e844fe7d4a),
	u64(0x01aa3d4df50af0ac),
	u64(0xbdaa75112b1f0e4e),
	u64(0x010a6650b926d66b),
	u64(0xad15125575e6d1e2),
	u64(0x014cffe4e7708c06),
	u64(0x585a56ead360865b),
	u64(0x01a03fde214caf08),
	u64(0x37387652c41c53f8),
	u64(0x010427ead4cfed65),
	u64(0x850693e7752368f7),
	u64(0x014531e58a03e8be),
	u64(0x264838e1526c4334),
	u64(0x01967e5eec84e2ee),
	u64(0xafda4719a7075402),
	u64(0x01fc1df6a7a61ba9),
	u64(0x0de86c7008649481),
	u64(0x013d92ba28c7d14a),
	u64(0x9162878c0a7db9a1),
	u64(0x018cf768b2f9c59c),
	u64(0xb5bb296f0d1d280a),
	u64(0x01f03542dfb83703),
	u64(0x5194f9e568323906),
	u64(0x01362149cbd32262),
	u64(0xe5fa385ec23ec747),
	u64(0x0183a99c3ec7eafa),
	u64(0x9f78c67672ce7919),
	u64(0x01e494034e79e5b9),
	u64(0x03ab7c0a07c10bb0),
	u64(0x012edc82110c2f94),
	u64(0x04965b0c89b14e9c),
	u64(0x017a93a2954f3b79),
	u64(0x45bbf1cfac1da243),
	u64(0x01d9388b3aa30a57),
	u64(0x8b957721cb92856a),
	u64(0x0127c35704a5e676),
	u64(0x2e7ad4ea3e7726c4),
	u64(0x0171b42cc5cf6014),
	u64(0x3a198a24ce14f075),
	u64(0x01ce2137f7433819),
	u64(0xc44ff65700cd1649),
	u64(0x0120d4c2fa8a030f),
	u64(0xb563f3ecc1005bdb),
	u64(0x016909f3b92c83d3),
	u64(0xa2bcf0e7f14072d2),
	u64(0x01c34c70a777a4c8),
	u64(0x65b61690f6c847c3),
	u64(0x011a0fc668aac6fd),
	u64(0xbf239c35347a59b4),
	u64(0x016093b802d578bc),
	u64(0xeeec83428198f021),
	u64(0x01b8b8a6038ad6eb),
	u64(0x7553d20990ff9615),
	u64(0x01137367c236c653),
	u64(0x52a8c68bf53f7b9a),
	u64(0x01585041b2c477e8),
	u64(0x6752f82ef28f5a81),
	u64(0x01ae64521f7595e2),
	u64(0x8093db1d57999890),
	u64(0x010cfeb353a97dad),
	u64(0xe0b8d1e4ad7ffeb4),
	u64(0x01503e602893dd18),
	u64(0x18e7065dd8dffe62),
	u64(0x01a44df832b8d45f),
	u64(0x6f9063faa78bfefd),
	u64(0x0106b0bb1fb384bb),
	u64(0x4b747cf9516efebc),
	u64(0x01485ce9e7a065ea),
	u64(0xde519c37a5cabe6b),
	u64(0x019a742461887f64),
	u64(0x0af301a2c79eb703),
	u64(0x01008896bcf54f9f),
	u64(0xcdafc20b798664c4),
	u64(0x0140aabc6c32a386),
	u64(0x811bb28e57e7fdf5),
	u64(0x0190d56b873f4c68),
	u64(0xa1629f31ede1fd72),
	u64(0x01f50ac6690f1f82),
	u64(0xa4dda37f34ad3e67),
	u64(0x013926bc01a973b1),
	u64(0x0e150c5f01d88e01),
	u64(0x0187706b0213d09e),
	u64(0x919a4f76c24eb181),
	u64(0x01e94c85c298c4c5),
	u64(0x7b0071aa39712ef1),
	u64(0x0131cfd3999f7afb),
	u64(0x59c08e14c7cd7aad),
	u64(0x017e43c8800759ba),
	u64(0xf030b199f9c0d958),
	u64(0x01ddd4baa0093028),
	u64(0x961e6f003c1887d7),
	u64(0x012aa4f4a405be19),
	u64(0xfba60ac04b1ea9cd),
	u64(0x01754e31cd072d9f),
	u64(0xfa8f8d705de65440),
	u64(0x01d2a1be4048f907),
	u64(0xfc99b8663aaff4a8),
	u64(0x0123a516e82d9ba4),
	u64(0x3bc0267fc95bf1d2),
	u64(0x016c8e5ca239028e),
	u64(0xcab0301fbbb2ee47),
	u64(0x01c7b1f3cac74331),
	u64(0x1eae1e13d54fd4ec),
	u64(0x011ccf385ebc89ff),
	u64(0xe659a598caa3ca27),
	u64(0x01640306766bac7e),
	u64(0x9ff00efefd4cbcb1),
	u64(0x01bd03c81406979e),
	u64(0x23f6095f5e4ff5ef),
	u64(0x0116225d0c841ec3),
	u64(0xecf38bb735e3f36a),
	u64(0x015baaf44fa52673),
	u64(0xe8306ea5035cf045),
	u64(0x01b295b1638e7010),
	u64(0x911e4527221a162b),
	u64(0x010f9d8ede39060a),
	u64(0x3565d670eaa09bb6),
	u64(0x015384f295c7478d),
	u64(0x82bf4c0d2548c2a3),
	u64(0x01a8662f3b391970),
	u64(0x51b78f88374d79a6),
	u64(0x01093fdd8503afe6),
	u64(0xe625736a4520d810),
	u64(0x014b8fd4e6449bdf),
	u64(0xdfaed044d6690e14),
	u64(0x019e73ca1fd5c2d7),
	u64(0xebcd422b0601a8cc),
	u64(0x0103085e53e599c6),
	u64(0xa6c092b5c78212ff),
	u64(0x0143ca75e8df0038),
	u64(0xd070b763396297bf),
	u64(0x0194bd136316c046),
	u64(0x848ce53c07bb3daf),
	u64(0x01f9ec583bdc7058),
	u64(0x52d80f4584d5068d),
	u64(0x013c33b72569c637),
	u64(0x278e1316e60a4831),
	u64(0x018b40a4eec437c5),
]!

const pow5_inv_split_64_x = [
	u64(0x0000000000000001),
	u64(0x0400000000000000),
	u64(0x3333333333333334),
	u64(0x0333333333333333),
	u64(0x28f5c28f5c28f5c3),
	u64(0x028f5c28f5c28f5c),
	u64(0xed916872b020c49c),
	u64(0x020c49ba5e353f7c),
	u64(0xaf4f0d844d013a93),
	u64(0x0346dc5d63886594),
	u64(0x8c3f3e0370cdc876),
	u64(0x029f16b11c6d1e10),
	u64(0xd698fe69270b06c5),
	u64(0x0218def416bdb1a6),
	u64(0xf0f4ca41d811a46e),
	u64(0x035afe535795e90a),
	u64(0xf3f70834acdae9f1),
	u64(0x02af31dc4611873b),
	u64(0x5cc5a02a23e254c1),
	u64(0x0225c17d04dad296),
	u64(0xfad5cd10396a2135),
	u64(0x036f9bfb3af7b756),
	u64(0xfbde3da69454e75e),
	u64(0x02bfaffc2f2c92ab),
	u64(0x2fe4fe1edd10b918),
	u64(0x0232f33025bd4223),
	u64(0x4ca19697c81ac1bf),
	u64(0x0384b84d092ed038),
	u64(0x3d4e1213067bce33),
	u64(0x02d09370d4257360),
	u64(0x643e74dc052fd829),
	u64(0x024075f3dceac2b3),
	u64(0x6d30baf9a1e626a7),
	u64(0x039a5652fb113785),
	u64(0x2426fbfae7eb5220),
	u64(0x02e1dea8c8da92d1),
	u64(0x1cebfcc8b9890e80),
	u64(0x024e4bba3a487574),
	u64(0x94acc7a78f41b0cc),
	u64(0x03b07929f6da5586),
	u64(0xaa23d2ec729af3d7),
	u64(0x02f394219248446b),
	u64(0xbb4fdbf05baf2979),
	u64(0x025c768141d369ef),
	u64(0xc54c931a2c4b758d),
	u64(0x03c7240202ebdcb2),
	u64(0x9dd6dc14f03c5e0b),
	u64(0x0305b66802564a28),
	u64(0x4b1249aa59c9e4d6),
	u64(0x026af8533511d4ed),
	u64(0x44ea0f76f60fd489),
	u64(0x03de5a1ebb4fbb15),
	u64(0x6a54d92bf80caa07),
	u64(0x0318481895d96277),
	u64(0x21dd7a89933d54d2),
	u64(0x0279d346de4781f9),
	u64(0x362f2a75b8622150),
	u64(0x03f61ed7ca0c0328),
	u64(0xf825bb91604e810d),
	u64(0x032b4bdfd4d668ec),
	u64(0xc684960de6a5340b),
	u64(0x0289097fdd7853f0),
	u64(0xd203ab3e521dc33c),
	u64(0x02073accb12d0ff3),
	u64(0xe99f7863b696052c),
	u64(0x033ec47ab514e652),
	u64(0x87b2c6b62bab3757),
	u64(0x02989d2ef743eb75),
	u64(0xd2f56bc4efbc2c45),
	u64(0x0213b0f25f69892a),
	u64(0x1e55793b192d13a2),
	u64(0x0352b4b6ff0f41de),
	u64(0x4b77942f475742e8),
	u64(0x02a8909265a5ce4b),
	u64(0xd5f9435905df68ba),
	u64(0x022073a8515171d5),
	u64(0x565b9ef4d6324129),
	u64(0x03671f73b54f1c89),
	u64(0xdeafb25d78283421),
	u64(0x02b8e5f62aa5b06d),
	u64(0x188c8eb12cecf681),
	u64(0x022d84c4eeeaf38b),
	u64(0x8dadb11b7b14bd9b),
	u64(0x037c07a17e44b8de),
	u64(0x7157c0e2c8dd647c),
	u64(0x02c99fb46503c718),
	u64(0x8ddfcd823a4ab6ca),
	u64(0x023ae629ea696c13),
	u64(0x1632e269f6ddf142),
	u64(0x0391704310a8acec),
	u64(0x44f581ee5f17f435),
	u64(0x02dac035a6ed5723),
	u64(0x372ace584c1329c4),
	u64(0x024899c4858aac1c),
	u64(0xbeaae3c079b842d3),
	u64(0x03a75c6da27779c6),
	u64(0x6555830061603576),
	u64(0x02ec49f14ec5fb05),
	u64(0xb7779c004de6912b),
	u64(0x0256a18dd89e626a),
	u64(0xf258f99a163db512),
	u64(0x03bdcf495a9703dd),
	u64(0x5b7a614811caf741),
	u64(0x02fe3f6de212697e),
	u64(0xaf951aa00e3bf901),
	u64(0x0264ff8b1b41edfe),
	u64(0x7f54f7667d2cc19b),
	u64(0x03d4cc11c5364997),
	u64(0x32aa5f8530f09ae3),
	u64(0x0310a3416a91d479),
	u64(0xf55519375a5a1582),
	u64(0x0273b5cdeedb1060),
	u64(0xbbbb5b8bc3c3559d),
	u64(0x03ec56164af81a34),
	u64(0x2fc916096969114a),
	u64(0x03237811d593482a),
	u64(0x596dab3ababa743c),
	u64(0x0282c674aadc39bb),
	u64(0x478aef622efb9030),
	u64(0x0202385d557cfafc),
	u64(0xd8de4bd04b2c19e6),
	u64(0x0336c0955594c4c6),
	u64(0xad7ea30d08f014b8),
	u64(0x029233aaaadd6a38),
	u64(0x24654f3da0c01093),
	u64(0x020e8fbbbbe454fa),
	u64(0x3a3bb1fc346680eb),
	u64(0x034a7f92c63a2190),
	u64(0x94fc8e635d1ecd89),
	u64(0x02a1ffa89e94e7a6),
	u64(0xaa63a51c4a7f0ad4),
	u64(0x021b32ed4baa52eb),
	u64(0xdd6c3b607731aaed),
	u64(0x035eb7e212aa1e45),
	u64(0x1789c919f8f488bd),
	u64(0x02b22cb4dbbb4b6b),
	u64(0xac6e3a7b2d906d64),
	u64(0x022823c3e2fc3c55),
	u64(0x13e390c515b3e23a),
	u64(0x03736c6c9e606089),
	u64(0xdcb60d6a77c31b62),
	u64(0x02c2bd23b1e6b3a0),
	u64(0x7d5e7121f968e2b5),
	u64(0x0235641c8e52294d),
	u64(0xc8971b698f0e3787),
	u64(0x0388a02db0837548),
	u64(0xa078e2bad8d82c6c),
	u64(0x02d3b357c0692aa0),
	u64(0xe6c71bc8ad79bd24),
	u64(0x0242f5dfcd20eee6),
	u64(0x0ad82c7448c2c839),
	u64(0x039e5632e1ce4b0b),
	u64(0x3be023903a356cfa),
	u64(0x02e511c24e3ea26f),
	u64(0x2fe682d9c82abd95),
	u64(0x0250db01d8321b8c),
	u64(0x4ca4048fa6aac8ee),
	u64(0x03b4919c8d1cf8e0),
	u64(0x3d5003a61eef0725),
	u64(0x02f6dae3a4172d80),
	u64(0x9773361e7f259f51),
	u64(0x025f1582e9ac2466),
	u64(0x8beb89ca6508fee8),
	u64(0x03cb559e42ad070a),
	u64(0x6fefa16eb73a6586),
	u64(0x0309114b688a6c08),
	u64(0xf3261abef8fb846b),
	u64(0x026da76f86d52339),
	u64(0x51d691318e5f3a45),
	u64(0x03e2a57f3e21d1f6),
	u64(0x0e4540f471e5c837),
	u64(0x031bb798fe8174c5),
	u64(0xd8376729f4b7d360),
	u64(0x027c92e0cb9ac3d0),
	u64(0xf38bd84321261eff),
	u64(0x03fa849adf5e061a),
	u64(0x293cad0280eb4bff),
	u64(0x032ed07be5e4d1af),
	u64(0xedca240200bc3ccc),
	u64(0x028bd9fcb7ea4158),
	u64(0xbe3b50019a3030a4),
	u64(0x02097b309321cde0),
	u64(0xc9f88002904d1a9f),
	u64(0x03425eb41e9c7c9a),
	u64(0x3b2d3335403daee6),
	u64(0x029b7ef67ee396e2),
	u64(0x95bdc291003158b8),
	u64(0x0215ff2b98b6124e),
	u64(0x892f9db4cd1bc126),
	u64(0x035665128df01d4a),
	u64(0x07594af70a7c9a85),
	u64(0x02ab840ed7f34aa2),
	u64(0x6c476f2c0863aed1),
	u64(0x0222d00bdff5d54e),
	u64(0x13a57eacda3917b4),
	u64(0x036ae67966562217),
	u64(0x0fb7988a482dac90),
	u64(0x02bbeb9451de81ac),
	u64(0xd95fad3b6cf156da),
	u64(0x022fefa9db1867bc),
	u64(0xf565e1f8ae4ef15c),
	u64(0x037fe5dc91c0a5fa),
	u64(0x911e4e608b725ab0),
	u64(0x02ccb7e3a7cd5195),
	u64(0xda7ea51a0928488d),
	u64(0x023d5fe9530aa7aa),
	u64(0xf7310829a8407415),
	u64(0x039566421e7772aa),
	u64(0x2c2739baed005cde),
	u64(0x02ddeb68185f8eef),
	u64(0xbcec2e2f24004a4b),
	u64(0x024b22b9ad193f25),
	u64(0x94ad16b1d333aa11),
	u64(0x03ab6ac2ae8ecb6f),
	u64(0xaa241227dc2954db),
	u64(0x02ef889bbed8a2bf),
	u64(0x54e9a81fe35443e2),
	u64(0x02593a163246e899),
	u64(0x2175d9cc9eed396a),
	u64(0x03c1f689ea0b0dc2),
	u64(0xe7917b0a18bdc788),
	u64(0x03019207ee6f3e34),
	u64(0xb9412f3b46fe393a),
	u64(0x0267a8065858fe90),
	u64(0xf535185ed7fd285c),
	u64(0x03d90cd6f3c1974d),
	u64(0xc42a79e57997537d),
	u64(0x03140a458fce12a4),
	u64(0x03552e512e12a931),
	u64(0x02766e9e0ca4dbb7),
	u64(0x9eeeb081e3510eb4),
	u64(0x03f0b0fce107c5f1),
	u64(0x4bf226ce4f740bc3),
	u64(0x0326f3fd80d304c1),
	u64(0xa3281f0b72c33c9c),
	u64(0x02858ffe00a8d09a),
	u64(0x1c2018d5f568fd4a),
	u64(0x020473319a20a6e2),
	u64(0xf9ccf48988a7fba9),
	u64(0x033a51e8f69aa49c),
	u64(0xfb0a5d3ad3b99621),
	u64(0x02950e53f87bb6e3),
	u64(0x2f3b7dc8a96144e7),
	u64(0x0210d8432d2fc583),
	u64(0xe52bfc7442353b0c),
	u64(0x034e26d1e1e608d1),
	u64(0xb756639034f76270),
	u64(0x02a4ebdb1b1e6d74),
	u64(0x2c451c735d92b526),
	u64(0x021d897c15b1f12a),
	u64(0x13a1c71efc1deea3),
	u64(0x0362759355e981dd),
	u64(0x761b05b2634b2550),
	u64(0x02b52adc44bace4a),
	u64(0x91af37c1e908eaa6),
	u64(0x022a88b036fbd83b),
	u64(0x82b1f2cfdb417770),
	u64(0x03774119f192f392),
	u64(0xcef4c23fe29ac5f3),
	u64(0x02c5cdae5adbf60e),
	u64(0x3f2a34ffe87bd190),
	u64(0x0237d7beaf165e72),
	u64(0x984387ffda5fb5b2),
	u64(0x038c8c644b56fd83),
	u64(0xe0360666484c915b),
	u64(0x02d6d6b6a2abfe02),
	u64(0x802b3851d3707449),
	u64(0x024578921bbccb35),
	u64(0x99dec082ebe72075),
	u64(0x03a25a835f947855),
	u64(0xae4bcd358985b391),
	u64(0x02e8486919439377),
	u64(0xbea30a913ad15c74),
	u64(0x02536d20e102dc5f),
	u64(0xfdd1aa81f7b560b9),
	u64(0x03b8ae9b019e2d65),
	u64(0x97daeece5fc44d61),
	u64(0x02fa2548ce182451),
	u64(0xdfe258a51969d781),
	u64(0x0261b76d71ace9da),
	u64(0x996a276e8f0fbf34),
	u64(0x03cf8be24f7b0fc4),
	u64(0xe121b9253f3fcc2a),
	u64(0x030c6fe83f95a636),
	u64(0xb41afa8432997022),
	u64(0x02705986994484f8),
	u64(0xecf7f739ea8f19cf),
	u64(0x03e6f5a4286da18d),
	u64(0x23f99294bba5ae40),
	u64(0x031f2ae9b9f14e0b),
	u64(0x4ffadbaa2fb7be99),
	u64(0x027f5587c7f43e6f),
	u64(0x7ff7c5dd1925fdc2),
	u64(0x03feef3fa6539718),
	u64(0xccc637e4141e649b),
	u64(0x033258ffb842df46),
	u64(0xd704f983434b83af),
	u64(0x028ead9960357f6b),
	u64(0x126a6135cf6f9c8c),
	u64(0x020bbe144cf79923),
	u64(0x83dd685618b29414),
	u64(0x0345fced47f28e9e),
	u64(0x9cb12044e08edcdd),
	u64(0x029e63f1065ba54b),
	u64(0x16f419d0b3a57d7d),
	u64(0x02184ff405161dd6),
	u64(0x8b20294dec3bfbfb),
	u64(0x035a19866e89c956),
	u64(0x3c19baa4bcfcc996),
	u64(0x02ae7ad1f207d445),
	u64(0xc9ae2eea30ca3adf),
	u64(0x02252f0e5b39769d),
	u64(0x0f7d17dd1add2afd),
	u64(0x036eb1b091f58a96),
	u64(0x3f97464a7be42264),
	u64(0x02bef48d41913bab),
	u64(0xcc790508631ce850),
	u64(0x02325d3dce0dc955),
	u64(0xe0c1a1a704fb0d4d),
	u64(0x0383c862e3494222),
	u64(0x4d67b4859d95a43e),
	u64(0x02cfd3824f6dce82),
	u64(0x711fc39e17aae9cb),
	u64(0x023fdc683f8b0b9b),
	u64(0xe832d2968c44a945),
	u64(0x039960a6cc11ac2b),
	u64(0xecf575453d03ba9e),
	u64(0x02e11a1f09a7bcef),
	u64(0x572ac4376402fbb1),
	u64(0x024dae7f3aec9726),
	u64(0x58446d256cd192b5),
	u64(0x03af7d985e47583d),
	u64(0x79d0575123dadbc4),
	u64(0x02f2cae04b6c4697),
	u64(0x94a6ac40e97be303),
	u64(0x025bd5803c569edf),
	u64(0x8771139b0f2c9e6c),
	u64(0x03c62266c6f0fe32),
	u64(0x9f8da948d8f07ebd),
	u64(0x0304e85238c0cb5b),
	u64(0xe60aedd3e0c06564),
	u64(0x026a5374fa33d5e2),
	u64(0xa344afb9679a3bd2),
	u64(0x03dd5254c3862304),
	u64(0xe903bfc78614fca8),
	u64(0x031775109c6b4f36),
	u64(0xba6966393810ca20),
	u64(0x02792a73b055d8f8),
	u64(0x2a423d2859b4769a),
	u64(0x03f510b91a22f4c1),
	u64(0xee9b642047c39215),
	u64(0x032a73c7481bf700),
	u64(0xbee2b680396941aa),
	u64(0x02885c9f6ce32c00),
	u64(0xff1bc53361210155),
	u64(0x0206b07f8a4f5666),
	u64(0x31c6085235019bbb),
	u64(0x033de73276e5570b),
	u64(0x27d1a041c4014963),
	u64(0x0297ec285f1ddf3c),
	u64(0xeca7b367d0010782),
	u64(0x021323537f4b18fc),
	u64(0xadd91f0c8001a59d),
	u64(0x0351d21f3211c194),
	u64(0xf17a7f3d3334847e),
	u64(0x02a7db4c280e3476),
	u64(0x279532975c2a0398),
	u64(0x021fe2a3533e905f),
	u64(0xd8eeb75893766c26),
	u64(0x0366376bb8641a31),
	u64(0x7a5892ad42c52352),
	u64(0x02b82c562d1ce1c1),
	u64(0xfb7a0ef102374f75),
	u64(0x022cf044f0e3e7cd),
	u64(0xc59017e8038bb254),
	u64(0x037b1a07e7d30c7c),
	u64(0x37a67986693c8eaa),
	u64(0x02c8e19feca8d6ca),
	u64(0xf951fad1edca0bbb),
	u64(0x023a4e198a20abd4),
	u64(0x28832ae97c76792b),
	u64(0x03907cf5a9cddfbb),
	u64(0x2068ef21305ec756),
	u64(0x02d9fd9154a4b2fc),
	u64(0x19ed8c1a8d189f78),
	u64(0x0247fe0ddd508f30),
	u64(0x5caf4690e1c0ff26),
	u64(0x03a66349621a7eb3),
	u64(0x4a25d20d81673285),
	u64(0x02eb82a11b48655c),
	u64(0x3b5174d79ab8f537),
	u64(0x0256021a7c39eab0),
	u64(0x921bee25c45b21f1),
	u64(0x03bcd02a605caab3),
	u64(0xdb498b5169e2818e),
	u64(0x02fd735519e3bbc2),
	u64(0x15d46f7454b53472),
	u64(0x02645c4414b62fcf),
	u64(0xefba4bed545520b6),
	u64(0x03d3c6d35456b2e4),
	u64(0xf2fb6ff110441a2b),
	u64(0x030fd242a9def583),
	u64(0x8f2f8cc0d9d014ef),
	u64(0x02730e9bbb18c469),
	u64(0xb1e5ae015c80217f),
	u64(0x03eb4a92c4f46d75),
	u64(0xc1848b344a001acc),
	u64(0x0322a20f03f6bdf7),
	u64(0xce03a2903b3348a3),
	u64(0x02821b3f365efe5f),
	u64(0xd802e873628f6d4f),
	u64(0x0201af65c518cb7f),
	u64(0x599e40b89db2487f),
	u64(0x0335e56fa1c14599),
	u64(0xe14b66fa17c1d399),
	u64(0x029184594e3437ad),
	u64(0x81091f2e7967dc7a),
	u64(0x020e037aa4f692f1),
	u64(0x9b41cb7d8f0c93f6),
	u64(0x03499f2aa18a84b5),
	u64(0xaf67d5fe0c0a0ff8),
	u64(0x02a14c221ad536f7),
	u64(0xf2b977fe70080cc7),
	u64(0x021aa34e7bddc592),
	u64(0x1df58cca4cd9ae0b),
	u64(0x035dd2172c9608eb),
	u64(0xe4c470a1d7148b3c),
	u64(0x02b174df56de6d88),
	u64(0x83d05a1b1276d5ca),
	u64(0x022790b2abe5246d),
	u64(0x9fb3c35e83f1560f),
	u64(0x0372811ddfd50715),
	u64(0xb2f635e5365aab3f),
	u64(0x02c200e4b310d277),
	u64(0xf591c4b75eaeef66),
	u64(0x0234cd83c273db92),
	u64(0xef4fa125644b18a3),
	u64(0x0387af39371fc5b7),
	u64(0x8c3fb41de9d5ad4f),
	u64(0x02d2f2942c196af9),
	u64(0x3cffc34b2177bdd9),
	u64(0x02425ba9bce12261),
	u64(0x94cc6bab68bf9628),
	u64(0x039d5f75fb01d09b),
	u64(0x10a38955ed6611b9),
	u64(0x02e44c5e6267da16),
	u64(0xda1c6dde5784dafb),
	u64(0x02503d184eb97b44),
	u64(0xf693e2fd58d49191),
	u64(0x03b394f3b128c53a),
	u64(0xc5431bfde0aa0e0e),
	u64(0x02f610c2f4209dc8),
	u64(0x6a9c1664b3bb3e72),
	u64(0x025e73cf29b3b16d),
	u64(0x10f9bd6dec5eca4f),
	u64(0x03ca52e50f85e8af),
	u64(0xda616457f04bd50c),
	u64(0x03084250d937ed58),
	u64(0xe1e783798d09773d),
	u64(0x026d01da475ff113),
	u64(0x030c058f480f252e),
	u64(0x03e19c9072331b53),
	u64(0x68d66ad906728425),
	u64(0x031ae3a6c1c27c42),
	u64(0x8711ef14052869b7),
	u64(0x027be952349b969b),
	u64(0x0b4fe4ecd50d75f2),
	u64(0x03f97550542c242c),
	u64(0xa2a650bd773df7f5),
	u64(0x032df7737689b689),
	u64(0xb551da312c31932a),
	u64(0x028b2c5c5ed49207),
	u64(0x5ddb14f4235adc22),
	u64(0x0208f049e576db39),
	u64(0x2fc4ee536bc49369),
	u64(0x034180763bf15ec2),
	u64(0xbfd0bea92303a921),
	u64(0x029acd2b63277f01),
	u64(0x9973cbba8269541a),
	u64(0x021570ef8285ff34),
	u64(0x5bec792a6a42202a),
	u64(0x0355817f373ccb87),
	u64(0xe3239421ee9b4cef),
	u64(0x02aacdff5f63d605),
	u64(0xb5b6101b25490a59),
	u64(0x02223e65e5e97804),
	u64(0x22bce691d541aa27),
	u64(0x0369fd6fd64259a1),
	u64(0xb563eba7ddce21b9),
	u64(0x02bb31264501e14d),
	u64(0xf78322ecb171b494),
	u64(0x022f5a850401810a),
	u64(0x259e9e47824f8753),
	u64(0x037ef73b399c01ab),
	u64(0x1e187e9f9b72d2a9),
	u64(0x02cbf8fc2e1667bc),
	u64(0x4b46cbb2e2c24221),
	u64(0x023cc73024deb963),
	u64(0x120adf849e039d01),
	u64(0x039471e6a1645bd2),
	u64(0xdb3be603b19c7d9a),
	u64(0x02dd27ebb4504974),
	u64(0x7c2feb3627b0647c),
	u64(0x024a865629d9d45d),
	u64(0x2d197856a5e7072c),
	u64(0x03aa7089dc8fba2f),
	u64(0x8a7ac6abb7ec05bd),
	u64(0x02eec06e4a0c94f2),
	u64(0xd52f05562cbcd164),
	u64(0x025899f1d4d6dd8e),
	u64(0x21e4d556adfae8a0),
	u64(0x03c0f64fbaf1627e),
	u64(0xe7ea444557fbed4d),
	u64(0x0300c50c958de864),
	u64(0xecbb69d1132ff10a),
	u64(0x0267040a113e5383),
	u64(0xadf8a94e851981aa),
	u64(0x03d8067681fd526c),
	u64(0x8b2d543ed0e13488),
	u64(0x0313385ece6441f0),
	u64(0xd5bddcff0d80f6d3),
	u64(0x0275c6b23eb69b26),
	u64(0x892fc7fe7c018aeb),
	u64(0x03efa45064575ea4),
	u64(0x3a8c9ffec99ad589),
	u64(0x03261d0d1d12b21d),
	u64(0xc8707fff07af113b),
	u64(0x0284e40a7da88e7d),
	u64(0x39f39998d2f2742f),
	u64(0x0203e9a1fe2071fe),
	u64(0x8fec28f484b7204b),
	u64(0x033975cffd00b663),
	u64(0xd989ba5d36f8e6a2),
	u64(0x02945e3ffd9a2b82),
	u64(0x47a161e42bfa521c),
	u64(0x02104b66647b5602),
	u64(0x0c35696d132a1cf9),
	u64(0x034d4570a0c5566a),
	u64(0x09c454574288172d),
	u64(0x02a4378d4d6aab88),
	u64(0xa169dd129ba0128b),
	u64(0x021cf93dd7888939),
	u64(0x0242fb50f9001dab),
	u64(0x03618ec958da7529),
	u64(0x9b68c90d940017bc),
	u64(0x02b4723aad7b90ed),
	u64(0x4920a0d7a999ac96),
	u64(0x0229f4fbbdfc73f1),
	u64(0x750101590f5c4757),
	u64(0x037654c5fcc71fe8),
	u64(0x2a6734473f7d05df),
	u64(0x02c5109e63d27fed),
	u64(0xeeb8f69f65fd9e4c),
	u64(0x0237407eb641fff0),
	u64(0xe45b24323cc8fd46),
	u64(0x038b9a6456cfffe7),
	u64(0xb6af502830a0ca9f),
	u64(0x02d6151d123fffec),
	u64(0xf88c402026e7087f),
	u64(0x0244ddb0db666656),
	u64(0x2746cd003e3e73fe),
	u64(0x03a162b4923d708b),
	u64(0x1f6bd73364fec332),
	u64(0x02e7822a0e978d3c),
	u64(0xe5efdf5c50cbcf5b),
	u64(0x0252ce880bac70fc),
	u64(0x3cb2fefa1adfb22b),
	u64(0x03b7b0d9ac471b2e),
	u64(0x308f3261af195b56),
	u64(0x02f95a47bd05af58),
	u64(0x5a0c284e25ade2ab),
	u64(0x0261150630d15913),
	u64(0x29ad0d49d5e30445),
	u64(0x03ce8809e7b55b52),
	u64(0x548a7107de4f369d),
	u64(0x030ba007ec9115db),
	u64(0xdd3b8d9fe50c2bb1),
	u64(0x026fb3398a0dab15),
	u64(0x952c15cca1ad12b5),
	u64(0x03e5eb8f434911bc),
	u64(0x775677d6e7bda891),
	u64(0x031e560c35d40e30),
	u64(0xc5dec645863153a7),
	u64(0x027eab3cf7dcd826),
]!
