include <honeycomb.scad>

case_width = 130;
case_height = 210;
case_low_height = 30;
case_depth = 60;
angle = 12;
alpha = 180-90-angle;
frame_wall = 3;

honeycomb_wall = 2;
honeycomb_diam = 8;



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
// LOOK AT IT MIRRORED

profile = [
			[0, 0],
			[case_width, 0],
			[case_width, case_low_height],
			[case_width - (((case_height - case_low_height) * sin(angle))/(sin(alpha))), case_height],
			[0, case_height]
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
		translate([frame_wall, 3*frame_wall, frame_wall])
		resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
		linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
		polygon(points = profile);

		/*  */
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
			translate([0, frame_wall, 0])
			rotate([90, 0, 0])
			linear_extrude(honeycomb_wall)
			honeycomb(case_width,case_depth,honeycomb_diam,honeycomb_wall);

			/* front honeycomb */
			translate([0, frame_wall, case_depth - frame_wall])
			linear_extrude(honeycomb_wall)
			honeycomb(case_width,case_height,honeycomb_diam,honeycomb_wall);

			/* left honeycomb */
			translate([frame_wall, 0, 0])
			rotate([0, -90, 0])
			linear_extrude(honeycomb_wall)
			honeycomb(case_depth, case_height, honeycomb_diam, honeycomb_wall);

			/* right low honeycomb */
			translate([case_width - (frame_wall - honeycomb_wall), 0, 0])
			rotate([0, -90, 0])
			linear_extrude(honeycomb_wall)
			honeycomb(case_depth, case_low_height, honeycomb_diam, honeycomb_wall);

			/* right high honeycomb */
			translate([case_width - (frame_wall - honeycomb_wall), case_low_height, 0])
			rotate([0, -90, angle])
			linear_extrude(honeycomb_wall)
			honeycomb(case_depth, case_height - case_low_height, honeycomb_diam, honeycomb_wall);

			/* top honeycomb */
			translate([0, case_height - (frame_wall - honeycomb_wall), 0])
			rotate([90, 0, 0])
			linear_extrude(honeycomb_wall)
			honeycomb(case_width, case_depth, honeycomb_diam, honeycomb_wall);
		}
	}
}
