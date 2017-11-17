import("big_mosfet_clip.stl");

%cube([220,220,1],center=true);

%translate([-50,0,0]) import("ramps.stl");
%translate([0,50,0]) import("small_mosfet.stl");
translate([0,0,-18]) import("big_mosfet.stl");
%translate([0,-100,0]) import("raspberry_pi.stl");

#translate([10,-2,0])rotate([270,0,90])import("big_mosfet_clip.stl");
#translate([90,-2,0])rotate([270,0,90])import("big_mosfet_clip.stl");
