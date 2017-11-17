// approximate section to be expected from this library:
//
//                                                                 clip_wall_depth
//                                 board_width                     |
//                                 |
// |\       board_holes_diameter (only_hole)                       /|
// | \      |                                 board_holes_inset   / |
// |  \     _     support_after_hole_pin                   _  |  /  |
// | __\   | |    |                                       | |   /__ | _ board_height
// ||   ___| |______    board_standoff_from_base _  ______| |____  ||
// ||  |            |                              |            |  ||
// ||  |            |                              |            |  ||
// ||  |            |                              |            |  ||
// ||__|            |__      _______________      _|            |__|| _ base_height
// |                  |_   _|               |_   _|                 |
// |                    | |                   | |                   | /
// |____________________| |___________________| |___________________| base depth
//
//                                                       |
//                                             |         mounting_holes_spacing_from_ends
//                                             mounting_holes_diameter
//
//
// the user can choose to have centering pins on both sides, only one of them or none


module clip(base_depth, base_height, board_width, board_height, board_holes_inset, board_holes_diameter, support_after_hole_pin, board_standoff_from_base, mounting_holes_diameter, mounting_holes_spacing_from_ends, clip_wall_depth, only_hole)
{
	base_width= board_width+clip_wall_depth*2;
	difference() /* base rectangle */
	{
		cube([base_width, base_depth, base_height]);
		translate([mounting_holes_spacing_from_ends, base_depth/2, 0]) cylinder(h=base_height+1, d=mounting_holes_diameter, center=false);
		translate([mounting_holes_spacing_from_ends, base_depth/2, base_height/2]) cylinder(h=base_height+1, d=mounting_holes_diameter+mounting_holes_diameter/2, center=false);
		translate([base_width-mounting_holes_spacing_from_ends, base_depth/2, 0]) cylinder(h=base_height+1, d=mounting_holes_diameter, center=false);
		translate([base_width-mounting_holes_spacing_from_ends, base_depth/2, base_height/2]) cylinder(h=base_height+1, d=mounting_holes_diameter+mounting_holes_diameter/2, center=false);
	}

	/* supports add-on */
	support_width = board_holes_inset+board_holes_diameter/2+support_after_hole_pin;
	translate([clip_wall_depth*2, 0, base_height])cube([support_width, base_depth,board_standoff_from_base]);
	translate([base_width-clip_wall_depth*2-support_width, 0, base_height])cube([support_width, base_depth,board_standoff_from_base]);

	/* adding centering pins */
	if((only_hole == "left" && only_hole != "right") || only_hole == "both")
	{
		translate([clip_wall_depth+board_holes_inset,base_depth/2,base_height+board_standoff_from_base])
		union()
		{
			cylinder(d=board_holes_diameter,h=board_holes_diameter/2);
			translate([0,0,board_holes_diameter/2])sphere(d=board_holes_diameter);
		}
	}
	if((only_hole == "right" && only_hole != "left") || only_hole == "both")
	{
		translate([base_width-clip_wall_depth - board_holes_inset,base_depth/2,base_height+board_standoff_from_base])
		union()
		{
			cylinder(d=board_holes_diameter,h=board_holes_diameter/2);
			translate([0,0,board_holes_diameter/2])sphere(d=board_holes_diameter);
		}
	}

	/* adding clips */
	union()
	{
		translate([0,0,base_height]) cube([clip_wall_depth, base_depth, board_standoff_from_base+board_height]);
		translate([0,base_depth,base_height+board_standoff_from_base+board_height]) rotate([90,0,0])
		linear_extrude(height = base_depth, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0)
		{
			mirror([0,0,0])polygon(points = [[0,0],[2.5,0],[0,3]]);
		}
	}
	union()
	{
		translate([base_width-clip_wall_depth,0,base_height]) cube([clip_wall_depth, base_depth, board_standoff_from_base+board_height]);
		translate([base_width,base_depth,base_height+board_standoff_from_base+board_height]) rotate([90,0,0])
		linear_extrude(height = base_depth, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0)
		{
			mirror([1,0,0])polygon(points = [[0,0],[2.5,0],[0,3]]);
		}
	}
}

module clip_single(clip_wall_depth, clip_depth, clip_height, profile)
{
	union()
	{
		translate([0,0,0]) cube([clip_wall_depth, clip_depth, 0+clip_height]);
		translate([0,clip_depth,0+0+clip_height]) rotate([90,0,0])
		linear_extrude(height = clip_depth, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0)
		{
			polygon(points = profile);
		}
	}
}
