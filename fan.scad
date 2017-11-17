// Parametric fan design by Jason Frazier (neveroddoreven)
// Remixed from non-parametric design by MiseryBot at http://www.thingiverse.com/thing:8063
// Case size selections inspired by https://en.wikipedia.org/wiki/Computer_fan

//=======================================================================================
/* [Global] */
// Low quality for configuring, High for final output
$fn=60; // [60:Low Quality,720:High Quality]
// Fan length/width in mm
housing_side=80; // [8,17,20,25,30,35,38,40,45,50,60,70,80,90,92,100,110,120,130,140,150,250,360]
// Fan thickness in mm
housing_height=15; // [3,5,7,10,15,20,25,30,38]
// Default 0.144, adjust based on housing size
housing_mount_tab_thickness_ratio=0.144; // [0.1,0.12,0.144,0.2,0.25]
// Default 7
fan_blade_count=9; // [1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,19]
// Default counter-clockwise
fan_blade_direction=-1; // [-1:Counter-clockwise, 1:Clockwise]
// Default 0.58
fan_blade_twist_ratio=0.58; // [0.145,0.29,0.435,0.58,0.725,0.87,1.015,1.16,1.305,1.45]
// Default 1.5
fan_blade_thickness=1.5; // [0.5,0.75,1.0,1.5,2.0]
// Default 0.75
fan_blade_edge_gap=0.75; // [0.25,0.5,0.75,1]
// Default 0.525
hub_diameter_to_housing_ratio=0.525; // [0.15,0.275,0.4,0.525,0.65,0.775,0.9]
// Default 3.4 for an M3 screw, these values are a made-up WIP
mount_hole_diameter=3.4; // [1.1:M1, 1.4:M1.2, 1.8:M1.6, 2.3:M2, 2.8:M2.5, 3.4:M3, 4.5:M4, 5.5:M5, 6.5:M6, 8.5:M8]

/* [Hidden] */
// leave these be unless you know what you're doing
housing_inner_diameter=housing_side*0.95;
housing_corner_radii1=housing_side*0.081667;
housing_corner_radii2=housing_side*0.083333;
housing_corner_radii3=housing_side*0.085;
housing_corner_radii4=housing_side*0.001667;
housing_outer_diameter=housing_side*1.066667;
housing_mount_tab_thickness=housing_height*housing_mount_tab_thickness_ratio;
hub_diameter=housing_side*hub_diameter_to_housing_ratio;
mount_hole_offset=housing_side*0.416667;
fan_blade_recess=0.5;
fan_blade_twist=360/fan_blade_count*fan_blade_twist_ratio;

module fan_parametric()
  {
  difference()
    {
    linear_extrude(height=housing_height, center = true, convexity = 4, twist = 0)
      difference()
        {
        //overall outside
        square([housing_side,housing_side],center=true);
        //main inside bore, less hub
        difference()
          {
          circle(r=housing_inner_diameter/2,center=true);
          //hub. Just imagine the blades, OK?
          circle(r=hub_diameter/2,center=true);
          }
        //Mounting holes
        translate([mount_hole_offset,mount_hole_offset]) circle(r=mount_hole_diameter/2,h=mount_hole_offset+0.2,center=true);
        translate([mount_hole_offset,-mount_hole_offset]) circle(r=mount_hole_diameter/2,h=mount_hole_offset+0.2,center=true);
        translate([-mount_hole_offset,mount_hole_offset]) circle(r=mount_hole_diameter/2,h=mount_hole_offset+0.2,center=true);
        translate([-mount_hole_offset,-mount_hole_offset]) circle(r=mount_hole_diameter/2,h=mount_hole_offset+0.2,center=true);
        //Outside Radii
        translate([housing_side/2,housing_side/2]) difference()
          {
          translate([-housing_corner_radii1,-housing_corner_radii1]) square([housing_corner_radii3,housing_corner_radii3]);
          translate([-housing_corner_radii2,-housing_corner_radii2]) circle(r=housing_corner_radii2);
          }
        translate([housing_side/2,-housing_side/2]) difference()
          {
          translate([-housing_corner_radii1,-housing_corner_radii4]) square([housing_corner_radii3,housing_corner_radii3]);
          translate([-housing_corner_radii2,housing_corner_radii2]) circle(r=housing_corner_radii2);
          }
        translate([-housing_side/2,housing_side/2]) difference()
          {
          translate([-housing_corner_radii4,-housing_corner_radii1]) square([housing_corner_radii3,housing_corner_radii3]);
          translate([housing_corner_radii2,-housing_corner_radii2]) circle(r=housing_corner_radii2);
          }
        translate([-housing_side/2,-housing_side/2]) difference()
          {
          translate([-housing_corner_radii4,-housing_corner_radii4]) square([housing_corner_radii2+housing_corner_radii4,housing_corner_radii2+housing_corner_radii4]);
          translate([housing_corner_radii2,housing_corner_radii2]) circle(r=housing_corner_radii2);
          }
      } //linear extrude and 2-d difference
    //Remove outside ring
    difference()
      {
      cylinder(r=housing_outer_diameter,h=housing_height-housing_mount_tab_thickness-housing_mount_tab_thickness,center=true);
      cylinder(r=housing_outer_diameter/2,h=housing_height-housing_mount_tab_thickness-housing_mount_tab_thickness+0.2,center=true);
      }
    }// 3-d difference

    //Blades
    linear_extrude(height=housing_height-(fan_blade_recess*2), center = true, convexity = 4, twist = fan_blade_twist*fan_blade_direction)
      for(i=[0:fan_blade_count-1])
        rotate((360*i)/fan_blade_count)
          translate([0,-1.5/2]) #square([housing_inner_diameter/2-fan_blade_edge_gap,fan_blade_thickness]);
  }
//=======================================================================================
//fan_parametric();
//=======================================================================================
