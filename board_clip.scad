include <fan.scad>
include <clip.scad>

$fn=20;
//translate([0,0,0])import("big_mosfet_clip.stl"); /* original */

// translate([200,200,0]) %import("anet_a8_whole.stl");
// translate([50,613,282]) rotate([90,0,270]) #import("anet_a8.stl");

// translate([150,160,0]) rotate([0,0,270]) #import("anet_a8.stl");


// translate([0,0,60]) %fan_parametric();

// %import("big_mosfet.stl");
// {
// 	translate([10,-1,0])rotate([0,0,90])#clip(base_depth = 8, base_height = 2,
// 		board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 		mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 		clip_wall_depth = 1,
// 		only_hole = "both");
// 	translate([90,1,0])rotate([0,0,90])#clip(base_depth = 8, base_height = 2,
// 		board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 		mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 		clip_wall_depth = 1,
// 		only_hole = "both");
// }

// translate([0,0,0]) %import("mega.stl");
// translate([25.5,52,18]) %import("ramps.stl");
// translate([1.25,83.75,-4])rotate([0,0,0])#clip(base_depth = 8, base_height = 2,
// 	board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 	clip_wall_depth = 1,
// 	only_hole = "both");
// translate([1.25,8.85,-4])rotate([0,0,0])#clip(base_depth = 8, base_height = 2,
// 	board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 	clip_wall_depth = 1,
// 	only_hole = "right");


// translate([0,0,0])%import("small_mosfet.stl");
// translate([--3,0-48.75,-5--5])#clip(base_depth = 8, base_height = 2,
// 	board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 	clip_wall_depth = 1,
// 	only_hole = "both");
// translate([--3,-42-48.75,-5--5])#clip(base_depth = 8, base_height = 2,
// 	board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
// 	clip_wall_depth = 1,
// 	only_hole = "both");


translate([0,0,0])%import("raspberry_pi.stl");
translate([58+3--3.5,49+1.5-49,-5])rotate([0,0,90])#clip(base_depth = 6, base_height = 2,
	board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 5,
	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
	clip_wall_depth = 1,
	only_hole = "both");
translate([3--3.5,49+1.5-49,-5])rotate([0,0,90])#clip(base_depth = 6, base_height = 2,
	board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 5,
	mounting_holes_diameter = 3, mounting_holes_spacing_from_ends = 20,
	clip_wall_depth = 1,
	only_hole = "both");
