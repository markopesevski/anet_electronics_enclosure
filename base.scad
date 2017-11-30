// TODO: separar els suports de cada placa entre si i fer que s'agafin amb 4 clips (2 per costat) a la caixa, on hi haura una repisa
// TODO: afegir una repisa a la caixa de panal d'abella perque els clips puguin clipar


include <clip.scad>
include <honeycomb.scad>
include <fan.scad>
include <ruler.scad>
include <nema17.scad>

$fn=20;
motor_height = 37.0;
clips = "yes";
clips_on_honeycomb = "yes";
honeycomb_casing = "yes";
honeycombs = "yes";
pcbs = "yes";
fan = "yes";
small_mosfet = "yes";
anet = "no";
motor = "yes";

//
//                      case_top_width
//                        /______/ < case_depth
//                       /       |
//                      /        |
//                     /         |
//                    /          | case_height
//                   /           |
//                  |            |
// case_height_left |            |
//                  |____________|
//                    case_width
//
//
angle = 12;
case_depth = 83;
case_height = 210;
case_height_left = 30;
case_width = 130;
case_top_width = case_width - (sin(angle)*(case_height - case_height_left))/(sin(90-angle));
honeycomb_diameter = 8;
honeycomb_wall = 2;
inset_from_anet_wall = -5;
outline_walls = 3;




fan_housing_size=80;
fan_housing_height=15;
fan_housing_mount_tab_thickness_ratio=0.23333;
fan_blade_count=9;
fan_blade_direction=-1;
fan_blade_twist_ratio=0.58;
fan_blade_thickness=1.5;
fan_blade_edge_gap=0.75;
fan_hub_diameter_to_housing_ratio=0.525;
fan_mount_hole_diameter=3.4;





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

if(motor == "yes")
{
	translate([-238,257,151]) rotate([90,0,0]) %Nema17(motor_height);
}

translate([-149,382,16]) rotate([90,0,270])
union()
{
	if(fan == "yes")
	{
		translate([80, 60, 73.5]) rotate([0,180,90])
		{
			if(pcbs == "yes")
			{
				color("grey", 0.5) fan_parametric(fan_housing_size, fan_housing_height, fan_housing_mount_tab_thickness_ratio, fan_blade_count, fan_blade_direction, fan_blade_twist_ratio, fan_blade_thickness, fan_blade_edge_gap, fan_hub_diameter_to_housing_ratio, fan_mount_hole_diameter);
			}
			if(clips_on_honeycomb == "yes")
			{
				translate([-41,29.375-2,-9.5]) color("red") clip(base_depth = 3, base_height = 2,
					board_width = 80, board_height = 4, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 0,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "none");
				translate([-41,29.375-66.75+7,-9.5]) color("red") clip(base_depth = 3, base_height = 2,
					board_width = 80, board_height = 4, board_holes_inset = 6.75, board_holes_diameter = 3, support_after_hole_pin = 4, board_standoff_from_base = 0,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "none");
			}
		}
	}

	// translate([20,20,-10]) rotate([90,0,0]) ruler(20);

	if(honeycomb_casing == "yes")
	{
		difference()
		{
			union()
			{
				if(honeycombs == "yes")
				{
					translate([case_width - case_top_width,case_height,-outline_walls]) rotate([90,0,0]) linear_extrude(honeycomb_wall) honeycomb(case_top_width,case_depth,honeycomb_diameter,honeycomb_wall); /* top */
					translate([0,-outline_walls+honeycomb_wall,-outline_walls]) rotate([90,0,0]) linear_extrude(honeycomb_wall) honeycomb(case_width,case_depth,honeycomb_diameter,honeycomb_wall); /* bottom */
					// translate([0,0,-outline_walls]) rotate([0,90,0]) mirror() linear_extrude(honeycomb_wall) honeycomb(case_depth,case_height_left,honeycomb_diameter,honeycomb_wall); /* bottom back */
					translate([case_width+outline_walls-honeycomb_wall,0,-outline_walls]) rotate([0,90,0]) mirror() linear_extrude(honeycomb_wall) honeycomb(case_depth,case_height,honeycomb_diameter,honeycomb_wall); /* front */
					// translate([-outline_walls+honeycomb_wall,case_height_left,-outline_walls]) rotate([0,90,-angle]) mirror() linear_extrude(honeycomb_wall) honeycomb(case_depth,case_height - case_height_left+3,honeycomb_diameter,honeycomb_wall); /* top back */
					translate([0,0,case_depth - honeycomb_wall]) linear_extrude(honeycomb_wall) honeycomb(case_width,case_height,honeycomb_diameter,honeycomb_wall); /* outside */
				}

				translate([case_width - case_top_width,case_height-outline_walls,case_depth-outline_walls]) cube([case_top_width,outline_walls,outline_walls]);
				translate([case_width - case_top_width,case_height-outline_walls,inset_from_anet_wall-1]) cube([case_top_width,outline_walls,outline_walls]);
				translate([0,0,case_depth-outline_walls]) rotate([90,0,0]) cube([case_width+outline_walls,outline_walls,outline_walls]);
				translate([0,0,case_depth-outline_walls]) rotate([0,0,-90]) mirror() cube([case_height_left+outline_walls,outline_walls,outline_walls]);

				translate([case_width+outline_walls,0,case_depth-outline_walls]) rotate([0,0,90]) cube([110,outline_walls,outline_walls]); /* 110, to accept motor */
				translate([case_width+outline_walls,107,case_depth-outline_walls]) rotate([0,90,90]) cube([20,outline_walls,outline_walls]); /* 20, to accept motor */
				translate([case_width+outline_walls,107,57]) rotate([0,0,90]) cube([56,outline_walls,outline_walls]); /* 56, to accept motor */
				translate([case_width+outline_walls,160,case_depth-outline_walls]) rotate([0,90,90]) cube([20,outline_walls,outline_walls]); /* 20, to accept motor */
				translate([case_width+outline_walls,160,case_depth-outline_walls]) rotate([0,0,90]) cube([50,outline_walls,outline_walls]); /* 50, to accept motor */
				translate([120,107,case_depth-outline_walls]) cube([13,outline_walls,outline_walls]); /* 13, to accept motor */
				translate([120,107,case_depth-outline_walls]) rotate([0,0,90]) cube([56,outline_walls,outline_walls]); /* 56, to accept motor */
				translate([120,160,case_depth-outline_walls]) cube([13,outline_walls,outline_walls]); /* 13, to accept motor */

				translate([2,case_height_left,case_depth-outline_walls]) rotate([0,0,90-angle]) cube([sqrt(pow(case_height - case_height_left,2)+pow(case_width - case_top_width,2)),outline_walls,outline_walls]);
				translate([2,case_height_left,inset_from_anet_wall-1]) rotate([0,0,90-angle]) cube([sqrt(pow(case_height - case_height_left,2)+pow(case_width - case_top_width,2)),outline_walls,outline_walls]); /**/
				translate([0,case_height_left+honeycomb_wall,case_depth-outline_walls]) rotate([0,90,0]) cube([case_depth+outline_walls,outline_walls,outline_walls]);
				translate([0,-outline_walls,case_depth-outline_walls]) rotate([0,90,0]) cube([case_depth+outline_walls,outline_walls,outline_walls]);
				translate([/*37.25*/ case_width - case_top_width,case_height-outline_walls,case_depth-outline_walls]) mirror() rotate([0,90,0]) cube([case_depth+outline_walls,outline_walls,outline_walls]);
				translate([/*36.75*/ case_width - case_top_width,case_height-outline_walls,case_depth-outline_walls]) mirror() rotate([0,90,angle]) cube([case_depth+outline_walls,outline_walls,outline_walls]);
				translate([case_width,case_height-outline_walls,case_depth-outline_walls]) rotate([0,90,0]) cube([case_depth+outline_walls,outline_walls,outline_walls]);
				translate([case_width,-outline_walls,case_depth-outline_walls]) rotate([0,90,0]) cube([case_depth+outline_walls,outline_walls,outline_walls]);

				translate([case_width+outline_walls,0,inset_from_anet_wall-1]) rotate([0,0,90]) cube([case_height,outline_walls,outline_walls]); /**/
				translate([outline_walls,-outline_walls,inset_from_anet_wall-1]) rotate([0,0,90]) cube([case_width - case_top_width,outline_walls,outline_walls]); /**/
				translate([outline_walls,case_height_left,-(inset_from_anet_wall*2)]) rotate([0,0,90-angle]) cube([sqrt(pow(case_height - case_height_left,2)+pow(case_width - case_top_width,2)),outline_walls,outline_walls]); /* inside flange for PCBs */
				translate([case_width+honeycomb_wall,0,-(inset_from_anet_wall*2)]) rotate([0,0,90]) cube([case_height,outline_walls,outline_walls]); /* inside flange for PCBs */
				translate([outline_walls+1,-1,-(inset_from_anet_wall*2)]) rotate([0,0,90]) cube([case_height_left+outline_walls,outline_walls,outline_walls]); /* inside flange for PCBs */
				translate([0,-outline_walls,inset_from_anet_wall-1]) cube([case_width+outline_walls,outline_walls,outline_walls]);
				translate([case_width,54,47.5]) rotate([0,90,0]) mirror() cylinder(h=2, d=19, center=false, $fn=20); /* hole for cabling */
				translate([96.5 + 8,-outline_walls,(inset_from_anet_wall)]) rotate([0,90,0]) mirror() cube([40,outline_walls,outline_walls]);
				translate([96.5 - 8 - outline_walls,-outline_walls,(inset_from_anet_wall)]) rotate([0,90,0]) mirror() cube([40,outline_walls,outline_walls]);
				translate([96.5 - 8 - outline_walls,-outline_walls,34]) cube([22,outline_walls,outline_walls]);

				translate([115 - outline_walls, -8 + 10/2, 45.75]) rotate([0,90,0]) cube([34.5, outline_walls, outline_walls]);
				translate([115 - outline_walls, -8 + 10/2 + outline_walls, 45.75]) rotate([90,0,0]) cube([21, outline_walls, outline_walls]);
				translate([115 - outline_walls, -8 + 10/2 + outline_walls, 45.75 - 34.5 - outline_walls]) rotate([90,0,0]) cube([21, outline_walls, outline_walls]);

				// translate([133 - outline_walls, 10, 45.75]) rotate([0,90,0]) cube([34.5, outline_walls, outline_walls]);
				translate([136 - outline_walls, -8 + 10/2, 46.75 - 34.5 - outline_walls - 1]) rotate([0,0,90]) cube([16, outline_walls, 40]);

				translate([0,47,22])rotate([0,90,0]) minkowski()
				{
					cube([10,10,10]);
					cylinder(d=14,h=1);
				}
			}
			translate([-1,case_height_left,(inset_from_anet_wall*2)]) rotate([0,0,-angle]) mirror() cube([100,200,120]);
			translate([12,case_height_left,(inset_from_anet_wall*2)]) rotate([0,0,-angle]) mirror() cube([10,50,50]);
			translate([0,(inset_from_anet_wall*2),(inset_from_anet_wall*2)]) mirror() cube([100,100,120]);
			translate([0,case_height,(inset_from_anet_wall*2)]) cube([150,100,120]);
			translate([145,110,60+outline_walls]) mirror() cube([25,50,60]);
			translate([120,54,47.5]) rotate([0,90,0]) mirror() cylinder(h=30, d=14, center=false, $fn=20);
			translate([96.5,-5.5,(inset_from_anet_wall*2)]) mirror() cylinder(h=45, d=20, center=false, $fn=20);
			translate([125,135,90]) rotate([0,90,0]) Nema17(motor_height);
			translate([115,-9.5+10/2,45.75-10/2]) rotate([0,90,0]) minkowski()
			{
				cube([24.5,10,40]);
				cylinder(d=10,h=1);
			}

			translate([0,47,22])rotate([0,90,0]) minkowski()
			{
				cube([10,10,10]);
				cylinder(d=9,h=3);
			}
			// translate([96.5+10,-2,(inset_from_anet_wall*2)]) mirror() cube([3,3,20]);
			// translate([96.5-10,-2,-(inset_from_anet_wall*2)]) rotate([0,90,0]) mirror() cube([3,3,20]);
		}
	}

	// translate([-30,265,0]) %import("anet_a8.stl");
	// translate([-150,413,282]) rotate([90,0,270]) import("anet_a8.stl"); /* for developing holes */
	translate([75,37,5]) rotate([0,0,90]) union()
	{
		translate([0,0,20])rotate([90,0,0])ruler(40);
		if(pcbs == "yes")
		{
			translate([-25.5,-52,1.75]) color("SteelBlue", 0.45) %import("mega.stl");
			translate([0,0,20]) color("red", 0.45) %import("ramps.stl");
		}
		if(clips == "yes")
		{
			translate([1.25-25.5,83.75-52,0]) color("Green") clip(base_depth = 8, base_height = 2,
				board_width = 53.3, board_height = 3.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");
			translate([1.25-25.5,8.85-52,0]) color("Green") clip(base_depth = 8, base_height = 2,
				board_width = 53.3, board_height = 3.5, board_holes_inset = 2.5, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "right");

			rotate([0,0,-90]) translate([-75,-35,-5]) color("green")
			{
				translate([5,15,5]) cube([35,10,2]);
				translate([5,15,5]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([114,15,5]) cube([17,10,2]);
				translate([114+17,15+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([6,30,5]) cube([30,10,2]);
				translate([6,30,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([114,50,5]) cube([17,10,2]);
				translate([114+17,50+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
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
				translate([-4-2,-4,12]) cube([88,67,28]);
				translate([0-2,0,12]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([80-2,0,12]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([0-2,59,12]) cylinder(h=100, d=4, center=true, $fn=20);
				translate([80-2,59,12]) cylinder(h=100, d=4, center=true, $fn=20);
			}
		}
		if(clips == "yes")
		{
			color("green") translate([2,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
				board_width = 67, board_height = 2, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 10,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");
			color("green") translate([82,-5,0])rotate([0,0,90]) clip(base_depth = 8, base_height = 2,
				board_width = 67, board_height = 2, board_holes_inset = 4, board_holes_diameter = 3.5, support_after_hole_pin = 4, board_standoff_from_base = 10,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 1,
				only_hole = "both");

			translate([-47,-138,-5]) color("green")
			{
				translate([124,175,5]) cube([7,10,2]);
				translate([124+7,175+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([124,150,5]) cube([7,10,2]);
				translate([124+7,150+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
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
			color("LightGreen", 0.9) translate([0,0,10]) import("raspberry_pi.stl");
		}
		if(clips == "yes")
		{
			translate([58+3--3.5,49+1.5-49-1,0])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
				board_width = 56, board_height = 2, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 10,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 2,
				only_hole = "both");
			translate([3--3.5,49+1.5-49-1,0])rotate([0,0,90]) color("Green") clip(base_depth = 6, base_height = 2,
				board_width = 56, board_height = 2, board_holes_inset = 3.5, board_holes_diameter = 2, support_after_hole_pin = 4, board_standoff_from_base = 10,
				mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
				clip_wall_depth = 2,
				only_hole = "both");

			rotate([0,0,-180]) translate([-115,-130,-5]) color("green")
			{
				translate([22,110,5]) cube([30,10,2]);
				translate([22,110,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([15.5,80,5]) cube([35,10,2]);
				translate([15.5,80,5]) rotate([0,0,-12]) mirror() clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([110,80,5]) cube([22,10,2]);
				translate([110+22,80+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
				translate([110,110,5]) cube([22,10,2]);
				translate([110+22,110+0,5+0]) clip_single(clip_wall_depth = 2, clip_depth = 10, clip_height = 8, profile = [[0,0],[3.5,0],[0,4]]);
			}

			translate([2.5,5,0]) color("green") cube([60,10,2]);
			translate([2.5,45,0]) color("green") cube([60,10,2]);
		}
	}

	if(small_mosfet == "yes")
	{
		translate([20,205,88]) rotate([180,0,270])
		{
			if(pcbs == "yes")
			{
				color("DarkSlateGray", 0.9) import("small_mosfet.stl");
			}

			if(clips_on_honeycomb == "yes")
			{
				translate([--3,0-48.75+1.5,-5--5+4]) color("Green") clip(base_depth = 5, base_height = 2,
					board_width = 60, board_height = 2, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
				translate([--3,-40.5-48.75,-5--5+4]) color("Green") clip(base_depth = 5, base_height = 2,
					board_width = 60, board_height = 2, board_holes_inset = 4, board_holes_diameter = 2.5, support_after_hole_pin = 4, board_standoff_from_base = 1,
					mounting_holes_diameter = 0, mounting_holes_spacing_from_ends = 20,
					clip_wall_depth = 1,
					only_hole = "both");
			}
		}
	}
}
