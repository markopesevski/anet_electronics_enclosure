// TODO: separar els suports de cada placa entre si i fer que s'agafin amb 4 clips (2 per costat) a la caixa, on hi haura una repisa
// TODO: afegir una repisa a la caixa de panal d'abella perque els clips puguin clipar


include <clip.scad>
include <honeycomb.scad>
include <fan.scad>
include <ruler.scad>

$fn=20;
clips = "no";
clips_on_honeycomb = "yes";
honeycomb_casing = "yes";
pcbs = "no";
fan = "yes";
small_mosfet = "yes";
anet = "no";

if(anet == "yes")
{
	%import("anet_a8_whole.stl");
}

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

// if(fan == "yes")
// {
// 	translate([-212.5,300,75]) rotate([0,90,0])
// 	{
// 		color("grey", 0.5) fan_parametric(housing_size=80, housing_height=15, housing_mount_tab_thickness_ratio=0.23333, fan_blade_count=9, fan_blade_direction=-1, fan_blade_twist_ratio=0.58, fan_blade_thickness=1.5, fan_blade_edge_gap=0.75, hub_diameter_to_housing_ratio=0.525, mount_hole_diameter=3.4);
// 		translate([-41,29.375,-14.5]) color("red") clip(base_depth = 8, base_height = 2,
// 			board_width = 80, board_height = 3.6, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
// 			clip_wall_depth = 1,
// 			only_hole = "both");
// 		translate([-41,29.375-66.75,-14.5]) color("red") clip(base_depth = 8, base_height = 2,
// 			board_width = 80, board_height = 3.6, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 5,
// 			mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
// 			clip_wall_depth = 1,
// 			only_hole = "both");
// 	}
// }

translate([-148,382,16]) rotate([90,0,270])
union()
{
	if(fan == "yes")
	{
		translate([80,60,82.5]) rotate([0,180,90])
		{
			if(pcbs == "yes")
			{
				color("grey", 0.5) fan_parametric(housing_size=80, housing_height=15, housing_mount_tab_thickness_ratio=0.23333, fan_blade_count=9, fan_blade_direction=-1, fan_blade_twist_ratio=0.58, fan_blade_thickness=1.5, fan_blade_edge_gap=0.75, hub_diameter_to_housing_ratio=0.525, mount_hole_diameter=3.4);
			}
			if(clips_on_honeycomb == "yes")
			{
				translate([-41,29.375,-9.5]) color("red") clip(base_depth = 8, base_height = 2,
					board_width = 80, board_height = 3.6, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 0,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
				translate([-41,29.375-66.75,-9.5]) color("red") clip(base_depth = 8, base_height = 2,
					board_width = 80, board_height = 3.6, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 0,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
			}
		}
	}

	if(honeycomb_casing == "yes")
	{
		difference()
		{
			union()
			{
				translate([35,210,-5]) rotate([90,0,0]) linear_extrude(2) honeycomb(100,95,8,2);
				translate([0,0,-5]) rotate([90,0,0]) linear_extrude(2) honeycomb(135,95,8,2);
				translate([0,0,60+30]) rotate([0,90,0]) linear_extrude(2) honeycomb(95,30,8,2);
				translate([135,0,60+30]) rotate([0,90,0]) linear_extrude(2) honeycomb(95,210,8,2);
				translate([0,30,60+30]) rotate([0,90,-12]) linear_extrude(2) honeycomb(95,185,8,2);
				translate([0,0,60+30]) rotate([0,0,0]) linear_extrude(2) honeycomb(135,210,8,2);
				translate([35,207,89]) cube([100,3,3]);
				translate([35,207,-6]) cube([100,3,3]);
				translate([0,1,89]) rotate([90,0,0]) cube([137,3,3]);
				translate([0,45,89]) rotate([0,0,-90]) cube([45,3,3]);
				translate([137,0,89]) rotate([0,0,90]) cube([210,3,3]);
				translate([2,30,89]) rotate([0,0,90-12]) cube([185,3,3]);
				translate([2,30,-6]) rotate([0,0,90-12]) cube([185,3,3]); /**/
				translate([3,30,10]) rotate([0,0,90-12]) cube([185,3,3]); /* inside flange for PCBs */
				translate([0,28.5,89]) rotate([0,90,0]) cube([90,3,3]);
				translate([0,-2,89]) rotate([0,90,0]) cube([90,3,3]);
				translate([37.25,207,90]) rotate([0,90,0]) cube([90,3,3]);
				translate([36.75,207,90]) rotate([0,90,-12]) cube([90,3,3]);
				translate([134,207,89]) rotate([0,90,0]) cube([90,3,3]);
				translate([134,-2,89]) rotate([0,90,0]) cube([90,3,3]);
				translate([137,0,-6]) rotate([0,0,90]) cube([210,3,3]); /**/
				translate([137,0,10]) rotate([0,0,90]) cube([210,3,3]); /* inside flange for PCBs */
				translate([3,-2,-6]) rotate([0,0,90]) cube([45,3,3]); /**/
				translate([3,-2,10]) rotate([0,0,90]) cube([45,3,3]); /* inside flange for PCBs */
				translate([0,-2,-6]) rotate([0,0,0]) cube([135,3,3]);
			}
			translate([-1,30,-10]) rotate([0,0,-12]) mirror() cube([100,200,120]);
			translate([0,-2,-10]) rotate([0,0,0]) mirror() cube([100,100,120]);
			translate([145,210,-10]) rotate([0,0,0]) mirror() cube([150,100,120]);
		}
	}

	// translate([-30,265,0]) %import("anet_a8.stl");
	// translate([-150,413,282]) rotate([90,0,270]) import("anet_a8.stl"); /* for developing holes */
	translate([75,35,5]) rotate([0,0,90]) union()
	{
		// translate([0,0,28])rotate([90,0,0])ruler(40);
		if(pcbs == "yes")
		{
			translate([-25.5,-52,1.75]) color("SteelBlue", 0.45)import("mega.stl");
			translate([0,0,20]) color("red", 0.45)import("ramps.stl");
		}
		if(clips == "yes")
		{
			translate([1.25-25.5,83.75-52,0]) color("Green") clip(base_depth = 8, base_height = 2,
				board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");
			translate([1.25-25.5,8.85-52,0]) color("Green") clip(base_depth = 8, base_height = 2,
				board_width = 53.3, board_height = 1.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "right");

			rotate([0,0,-90]) translate([-75,-35,-5]) color("green")
			{
				translate([5,15,5]) cube([35,10,2]);
				translate([5,15,5]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([115,15,5]) cube([17,10,2]);
				translate([115+17,15+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([9,50,5]) cube([30,10,2]);
				translate([9,50,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([115,50,5]) cube([17,10,2]);
				translate([115+17,50+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
			}

			translate([15,-40,0]) color("green") cube([10,75,2]);
			translate([-20,-40,0]) color("green") cube([10,75,2]);
		}
	}
	translate([47,138,5])
	{
		if(pcbs == "yes")
		{
			color("DarkSlateGray", 0.9) difference()
			{
				translate([-4,-4,5]) cube([88,67,28]);
				translate([0,0,5]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([80,0,5]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([0,59,5]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([80,59,5]) cylinder(h=100, d=4, center=true, $fn=20);
			}
		}
		if(clips == "yes")
		{
			color("green") translate([4,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
				board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");
			color("green") translate([84,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
				board_width = 67, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");

			translate([-47,-138,-5]) color("green")
			{
				translate([125,180,5]) cube([7,10,2]);
				translate([125+7,180+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([125,145,5]) cube([7,10,2]);
				translate([125+7,145+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([37,180,5]) cube([10,10,2]);
				translate([37,180,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([29.5,145,5]) cube([17.5,10,2]);
				translate([29.5,145,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
			}

			translate([0,0,0]) color("green") cube([80,10,2]);
			translate([0,50,0]) color("green") cube([80,10,2]);
		}
	}

	translate([115,130,5]) rotate([0,0,180])
	{
		if(pcbs == "yes")
		{
			color("LightGreen", 0.9) translate([0,0,3]) import("raspberry_pi.stl");
		}
		if(clips == "yes")
		{
			translate([58+3--3.5,49+1.5-49,0])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
				board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");
			translate([3--3.5,49+1.5-49,0])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
				board_width = 56, board_height = 1.5, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 3,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");

			rotate([0,0,-180]) translate([-115,-130,-5]) color("green")
			{
				translate([22,110,5]) cube([30,10,2]);
				translate([22,110,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([15.5,80,5]) cube([35,10,2]);
				translate([15.5,80,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([110,80,5]) cube([22,10,2]);
				translate([110+22,80+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([110,110,5]) cube([22,10,2]);
				translate([110+22,110+0,5+0]) rotate([0,0,0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
			}

			translate([2.5,5,0]) color("green") cube([60,10,2]);
			translate([2.5,45,0]) color("green") cube([60,10,2]);
		}
	}

	if(small_mosfet == "yes")
	{
		translate([20,205,96]) rotate([180,0,270])
		{
			if(pcbs == "yes")
			{
				color("DarkSlateGray", 0.9) import("small_mosfet.stl");
			}

			if(clips_on_honeycomb == "yes")
			{
				translate([--3,0-48.75,-5--5+4]) color("Green") clip(base_depth = 8, base_height = 2,
					board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
				translate([--3,-42-48.75,-5--5+4]) color("Green") clip(base_depth = 8, base_height = 2,
					board_width = 60, board_height = 1.5, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
			}
		}
	}
}
