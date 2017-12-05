include <honeycomb.scad>

// usage example:
// case_width = 130;
// case_height = 210;
// case_low_height = 35;
// case_depth = 60;
// angle = 12;
// frame_wall = 3;
// honeycomb_wall = 2;
// honeycomb_diam = 8;
// anet_honeycomb_enclosure(case_width, case_height, case_low_height, case_depth, angle, frame_wall, honeycomb_wall, honeycomb_diam);

module anet_honeycomb_enclosure(case_width = 130, case_height = 210, case_low_height = 35, case_depth = 60, angle = 12, frame_wall = 3, honeycomb_wall = 2, honeycomb_diam = 8)
{
//
//                        /______/ < case_depth
//                       /       |
//                      /        |
//                     /         |
//                    /          | case_height
//              angle/           |
//                  |            |
// case_low_height  |            |
//                  |____________|
//                    case_width
//
// LOOK AT IT ALL MIRRORED AND STUFF

	alpha = 180-90-angle;
	case_top_width = case_width - (((case_height - case_low_height) * sin(angle))/(sin(alpha)));
	profile =
	[
		[0, 0],
		[case_width, 0],
		[case_width, case_height],
		[case_width - case_top_width, case_height],
		[0, case_low_height],
		[0, 0]
	];

	union()
	{
		difference()
		{
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* interior cavity */
			translate([frame_wall, frame_wall, frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* frame_wall face */
			translate([frame_wall, frame_wall, -frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* bottom face */
			translate([frame_wall, -frame_wall, frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* left face */
			translate([-frame_wall, frame_wall, frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* front face */
			translate([frame_wall, frame_wall, 3*frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			/* top face */
			translate([case_width - frame_wall, frame_wall, frame_wall])
			// resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			// #linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			// polygon(points = profile);
			mirror()
			cube([case_top_width - frame_wall*2, case_height, case_depth - frame_wall*2]);

			/* right face */
			translate([3*frame_wall, frame_wall, frame_wall])
			resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);
		}
		intersection()
		{
			linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
			polygon(points = profile);

			union()
			{
				/* bottom honeycomb */
				translate([0, frame_wall/2, 0])
				rotate([90, 0, 0])
				linear_extrude(honeycomb_wall)
				honeycomb(case_width,case_depth,honeycomb_diam,honeycomb_wall);

				/* front honeycomb */
				translate([0, frame_wall, case_depth - frame_wall + (frame_wall - honeycomb_wall)])
				linear_extrude(honeycomb_wall)
				honeycomb(case_width,case_height,honeycomb_diam,honeycomb_wall);

				/* right honeycomb */
				translate([case_width, 0, 0])
				rotate([0, -90, 0])
				linear_extrude(honeycomb_wall)
				honeycomb(case_depth, case_height, honeycomb_diam, honeycomb_wall);

				/* left low honeycomb */
				translate([honeycomb_wall, 0, 0])
				rotate([0, -90, 0])
				linear_extrude(honeycomb_wall)
				honeycomb(case_depth, case_height, honeycomb_diam, honeycomb_wall);

				/* left high honeycomb */
				translate([honeycomb_wall, case_low_height, 0])
				rotate([0, -90, -angle])
				linear_extrude(honeycomb_wall)
				honeycomb(case_depth, case_height - case_low_height, honeycomb_diam, honeycomb_wall);

				/* top honeycomb */
				translate([0, case_height, 0])
				rotate([90, 0, 0])
				linear_extrude(honeycomb_wall)
				honeycomb(case_width, case_depth, honeycomb_diam, honeycomb_wall);
			}
		}
	}
}

