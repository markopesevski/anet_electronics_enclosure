include <fan.scad>
include <honeycomb.scad>

// honeycomb(200,200,10,3);

translate([0,0,0]) %import("anet_a8_whole.stl");

translate([0,245.25,0])
{
	translate([0,5.5,132.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,28.25,120.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,91.75,132.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,113,120.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,5.5,223.75])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,91.75,223.75])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,28.25,246.5])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
	translate([0,47,341])rotate([0,90,0])cylinder(h = 500, d = 3, center = true, $fn = 20);
}

translate([-205,300,80]) rotate([0,90,0]) #fan_parametric();
// translate([-205,300,180]) rotate([0,90,0]) #fan_parametric();

translate([-150,382,16]) rotate([90,0,270])
union()
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


	// translate([-30,265,0]) %import("anet_a8.stl");
	// translate([-150,413,282]) rotate([90,0,270]) #import("anet_a8.stl"); /* for developing holes */
	translate([80,40,0]) rotate([0,0,90]) #union()
	{
		translate([-25.5,-52,0]) import("mega.stl");
		translate([0,0,18]) import("ramps.stl");
	}
	translate([45,140,0]) #difference()
	{
		translate([-4,-4,0]) cube([88,67,28]);
		translate([0,0,0]) cylinder(h=100, d=4, center=true, $fn=20);
		translate([80,0,0]) cylinder(h=100, d=4, center=true, $fn=20);
		translate([0,59,0]) cylinder(h=100, d=4, center=true, $fn=20);
		translate([80,59,0]) cylinder(h=100, d=4, center=true, $fn=20);
	}
	translate([130,132,0]) rotate([0,0,180]) #import("raspberry_pi.stl");
	translate([20,170,70]) rotate([180,0,270])#import("small_mosfet.stl");
}

