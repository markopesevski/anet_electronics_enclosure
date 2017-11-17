// TODO: separar els suports de cada placa entre si i fer que s'agafin amb 4 clips (2 per costat) a la caixa, on hi haura una repisa
// TODO: afegir una repisa a la caixa de panal d'abella perque els clips puguin clipar


include <clip.scad>
include <honeycomb.scad>
include <fan.scad>

$fn=20;
clips = "yes";
honeycomb_casing = "no";

// translate([0,0,0]) import("anet_a8_whole.stl");

// translate([0,245.25,0])
// {
// 	translate([0,5.5,132.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,28.25,120.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,91.75,132.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,113,120.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,5.5,223.75])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,91.75,223.75])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,28.25,246.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// 	translate([0,47,341])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
// }

// translate([-205,300,75]) rotate([0,90,0]) color("black", 0.5) fan_parametric();

translate([-148,382,16]) rotate([90,0,270])
union()
{
	if(honeycomb_casing == "yes")
	{
		translate([35,210,0]) rotate([90,0,0]) linear_extrude(2) honeycomb(100,65,10,2.5);
		translate([0,0,0]) rotate([90,0,0]) linear_extrude(2) honeycomb(135,65,10,2.5);
		translate([0,0,65]) rotate([0,90,0]) linear_extrude(2) honeycomb(65,30,10,2.5);
		translate([135,0,65]) rotate([0,90,0]) linear_extrude(2) honeycomb(65,210,10,2.5);
		translate([0,30,65]) rotate([0,90,-12]) linear_extrude(2) honeycomb(65,185,10,2.5);
		difference()
		{
			translate([0,0,65]) rotate([0,0,0]) linear_extrude(2) honeycomb(135,210,10,2.5);
			translate([-50,40,75]) rotate([0,90,-12]) cube([80,185,50]);
		}
	}

	// translate([-30,265,0]) %import("anet_a8.stl");
	// translate([-150,413,282]) rotate([90,0,270]) #import("anet_a8.stl"); /* for developing holes */
	translate([75,35,-1]) rotate([0,0,90]) union()
	{
		// translate([-25.5,-52,0]) color("SteelBlue", 0.45)import("mega.stl");
		// translate([0,0,18]) color("red", 0.45)import("ramps.stl");
		translate([1.25-25.5,83.75-52,-4]) color("Green") clip(base_depth = 8, base_height = 2,
			board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "both");
		translate([1.25-25.5,8.85-52,-4]) color("Green") clip(base_depth = 8, base_height = 2,
			board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "right");
		translate([15,-40,-4]) color("green") cube([10,75,2]);
		translate([-20,-40,-4]) color("green") cube([10,75,2]);
	}
	translate([47,138,-5])
	{
		// import("big_mosfet.stl");
		color("green") translate([4,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
			board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "both");
		color("green") translate([84,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
			board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "both");

		// color("DarkSlateGray", 0.9) difference()
		// {
		// 	translate([-4,-4,7]) cube([88,67,28]);
		// 	translate([0,0,7]) cylinder(h=100, d=4, center=true, $fn=20);
		// 	translate([80,0,7]) cylinder(h=100, d=4, center=true, $fn=20);
		// 	translate([0,59,7]) cylinder(h=100, d=4, center=true, $fn=20);
		// 	translate([80,59,7]) cylinder(h=100, d=4, center=true, $fn=20);
		// }
		translate([0,0,0]) color("green") cube([80,10,2]);
		translate([0,50,0]) color("green") cube([80,10,2]);
	}

	translate([115,130,0]) rotate([0,0,180])
	{
		// color("LightGreen", 0.9) import("raspberry_pi.stl");
		translate([58+3--3.5,49+1.5-49,-5])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
			board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "both");
		translate([3--3.5,49+1.5-49,-5])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
			board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 5,
			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
			clip_wall_depth = 1,
			only_hole = "both");
		translate([2.5,5,-5]) color("green") cube([60,10,2]);
		translate([2.5,45,-5]) color("green") cube([60,10,2]);
	}

	translate([20,170,65]) rotate([180,0,270])
	{
		// color("DarkSlateGray", 0.9) import("small_mosfet.stl");
		// translate([--3,0-48.75,-5--5]) color("Green") clip(base_depth = 8, base_height = 2,
		// 	board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
		// 	mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
		// 	clip_wall_depth = 1,
		// 	only_hole = "both");
		// translate([--3,-42-48.75,-5--5]) color("Green") clip(base_depth = 8, base_height = 2,
		// 	board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 5,
		// 	mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
		// 	clip_wall_depth = 1,
		// 	only_hole = "both");
	}
	translate([70,52.5,-5]) color("green") cube([10,30,2]);
	translate([70,117.5,-5]) color("green") cube([10,30,2]);

	translate([125,180,-5]) color("green")
	{
		cube([7,10,2]);
		if(clips=="yes")
		{
			translate([7,0,0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([125,145,-5]) color("green")
	{
		cube([7,10,2]);
		if(clips=="yes")
		{
			translate([7,0,0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([37,180,-5]) color("green")
	{
		cube([10,10,2]);
		if(clips=="yes")
		{
			rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([29.5,145,-5]) color("green")
	{
		cube([17.5,10,2]);
		if(clips=="yes")
		{
			rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([22,110,-5]) color("green")
	{
		cube([30,10,2]);
		if(clips=="yes")
		{
			rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([15.5,80,-5]) color("green")
	{
		cube([35,10,2]);
		if(clips=="yes")
		{
			rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
	translate([6,35,-5]) color("green")
	{
		cube([30,10,2]);
		if(clips=="yes")
		{
			rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
		}
	}
}


