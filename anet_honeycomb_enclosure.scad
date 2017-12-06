include <honeycomb.scad>
include <nema17.scad>

// usage example:
case_width = 130;
case_height = 210;
case_low_height = 35;
case_depth = 60;
angle = 12;
frame_wall = 3;
honeycomb_wall = 2;
honeycomb_diam = 8;
// anet_honeycomb_enclosure(case_width, case_height, case_low_height, case_depth, angle, frame_wall, honeycomb_wall, honeycomb_diam);

// anet_honeycomb_enclosure();

module anet_honeycomb_enclosure(case_width = 130, case_height = 210, case_low_height = 35, case_depth = 60, angle = 12, frame_wall = 3, honeycomb_wall = 2, honeycomb_diam = 8)
{
//
//                        /______/ < case_depth
//                       /       |
//                      /        |
//                     /         |
//                    /          | case_height
//              angle/           |MOTOR([135-19,110,70])
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
	angle_length = ((case_height - case_low_height)*sin(90))/(sin(alpha));

	motor_height_from_base = 90;
	motor_height = 37.0;
	motor_pos = [135-19, 110+motor_height/2, 70];

	inset_from_anet_wall = -5;

	/* main body */
	union()
	{
		difference()
		{
			union()
			{
				/* hollow frame */
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

					/* motor */
					// translate([145, 100, case_depth - 20]) mirror() cube([30, 150, 60]);
				}

				/* honeycombs */
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
						honeycomb(case_depth, angle_length, honeycomb_diam, honeycomb_wall);

						/* top honeycomb */
						translate([0, case_height, 0])
						rotate([90, 0, 0])
						linear_extrude(honeycomb_wall)
						honeycomb(case_width, case_depth, honeycomb_diam, honeycomb_wall);
					}
				}
			}

			/* motor */
				translate([case_width+10, motor_height_from_base, case_depth - 20]) mirror() cube([30, 150, 30]);
				// translate(motor_pos) rotate([0,90,0]) %Nema17(motor_height);

			/* hole from cabling on motor wall */
				translate([120, 54+16, 47.5]) rotate([0, 90, 0]) mirror() cylinder(h = 30, d = 14, center = false, $fn = 20);

			/* hole for USB on RAMPS */
				translate([0, 47, 22]) rotate([0, 90, 0]) minkowski()
				{
					cube([10, 10, 10]);
					cylinder(d = 9, h = 3);
				}

			/* hole for Z1 motor */
				translate([case_width - frame_wall, 11.5, 40.75]) rotate([0, 90, 0]) minkowski()
				{
					cube([24.5, 10, frame_wall]);
					cylinder(d = 10, h = 1);
				}
		}

		/* motor */
			translate([case_width-20,motor_height_from_base,case_depth - frame_wall]) rotate([0,0,90]) cube([case_height - motor_height_from_base,frame_wall,frame_wall]);
			translate([case_width,motor_height_from_base,case_depth - frame_wall-20]) rotate([0,0,90]) cube([case_height - motor_height_from_base,frame_wall,frame_wall]);
			translate([case_width - 20 - frame_wall, motor_height_from_base - frame_wall, case_depth - frame_wall]) cube([20, frame_wall, frame_wall]);
			translate([case_width - 20 - frame_wall, case_height - frame_wall, case_depth - 20 - frame_wall]) cube([20, frame_wall, frame_wall]);
			translate([case_width,motor_height_from_base - frame_wall,case_depth - 20 - frame_wall]) rotate([0,-90,0]) cube([20,frame_wall,frame_wall]);
			translate([case_width - 20,case_height - frame_wall,case_depth - 20 - frame_wall]) rotate([0,-90,0]) cube([20,frame_wall,frame_wall]);

		/* flanges for clipping PCBs */
			difference()
			{
				translate([frame_wall+1, case_low_height, -(inset_from_anet_wall * 2)]) rotate([0, 0, 90 -angle]) cube([angle_length - frame_wall, frame_wall, frame_wall]);

				translate([0, 47, 22]) rotate([0, 90, 0]) minkowski()
				{
					cube([10, 10, 10]);
					cylinder(d = 14, h = 1);
				}
			}
			difference()
			{
				translate([case_width-1, frame_wall, -(inset_from_anet_wall * 2)]) rotate([0, 0, 90]) cube([case_height - 2*frame_wall, frame_wall, frame_wall]);

				translate([case_width - frame_wall * 2, 11.5, 40.75]) rotate([0, 90, 0]) minkowski()
				{
					cube([24.5, 10, 40]);
					cylinder(d = 10, h = 1);
				}
			}
			translate([frame_wall+1, frame_wall, -(inset_from_anet_wall * 2)]) rotate([0, 0, 90]) cube([case_low_height + frame_wall, frame_wall, frame_wall]);

		/* hole from cabling on motor wall */
			difference()
			{
				translate([case_width - frame_wall+1, 54+16, 47.5]) rotate([0, 90, 0]) cylinder(h = 2, d = 19, center = false, $fn = 20);
				translate([case_width - frame_wall, 54+16, 47.5]) rotate([0, 90, 0]) cylinder(h = 30, d = 14, center = false, $fn = 20);
			}

		/* hole for USB on RAMPS */
			intersection()
			{
				difference()
				{
					translate([0, 47, 22]) rotate([0, 90, 0]) minkowski()
					{
						cube([10, 10, 10]);
						cylinder(d = 14, h = 1);
					}
					translate([0, 47, 22]) rotate([0, 90, 0]) minkowski()
					{
						cube([10, 10, 10]);
						cylinder(d = 9, h = 3);
					}
					/* interior cavity */
					translate([frame_wall, frame_wall, frame_wall])
					resize(newsize=[case_width - (2*frame_wall), case_height - (2*frame_wall), case_depth - (2*frame_wall)])
					linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
					polygon(points = profile);
				}

				linear_extrude(height = case_depth, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0)
				polygon(points = profile);
			}

		/* hole for Z1 motor */
			difference()
			{
				translate([case_width - frame_wall, 11.5, 40.75]) rotate([0, 90, 0]) minkowski()
				{
					cube([24.5, 10, honeycomb_wall]);
					cylinder(d = 16, h = 1);
				}

				translate([case_width - frame_wall * 2, 11.5, 40.75]) rotate([0, 90, 0]) minkowski()
				{
					cube([24.5, 10, 40]);
					cylinder(d = 10, h = 1);
				}
			}
	}
}

