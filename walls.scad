include <honeycomb.scad>

translate([35,210,0]) rotate([90,0,0]) linear_extrude(2) honeycomb(100,65,10,2.5);
translate([0,0,0]) rotate([90,0,0]) linear_extrude(2) honeycomb(135,65,10,2.5);
translate([0,0,65]) rotate([0,90,0]) linear_extrude(2) honeycomb(65,30,10,2.5);
translate([135,0,65]) rotate([0,90,0]) linear_extrude(2) honeycomb(65,210,10,2.5);
translate([0,30,65]) rotate([0,90,-12]) linear_extrude(2) honeycomb(65,185,10,2.5);
// difference()
// {
// 	translate([0,0,65]) rotate([0,0,0]) linear_extrude(2) honeycomb(135,210,10,2.5);
// 	translate([-50,40,75]) rotate([0,90,-12]) cube([80,185,50]);
// }
