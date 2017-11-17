//
// RAMPS Case
//

// parameters
$fn=20;
c=false;  // center True/False
th=2.0;
fanh=8.0;     // miniature fan height
//length=105.0;
length=105 + fanh; // add fan height
width=65.0;
height=46.0;
fh=2.0;     // feet height
mrlh=2.0;   // Left PCB mount ridge height
mrh=2.0;    // Right PCB mount ridge height
rmh=2.0;    // PCB Rail height   
rth=th+1;   // ridge thickness
mrw=3.0;    // width
mrd=2.0;    // offset
soh=6.0;    // standoff height
ch=5.0;     // cover height
cd=5.0;     // steppercable diameter

i=4; // cover1, cover2, case

if (i==1)        { Cover1();
} else if (i==2) { Cover2();
} else if (i==3) { CaseBody();
} else if (i==4) { Test();
}

module Test() {
   Cover2();
   translate([0,0,8])
   CaseBody();
   translate([0,0,130])
   rotate([360,180,0])
   Cover1();
}

module Cover1() {
   difference() {
 	  union() {
	    rampsCover();
	    translate([-14,-4,th]) //Fan standoff
       fanmount();
	  }
	  //Cableroom (stepper/min/max/heater/hbp)
	  translate( [15,-15,0] )
     rounded_slit(cd,4*cd,2*th);
	  //Ventilation slits
	  for ( y = [-4.5:3.5:18] ) {
		   translate( [-14,2-y,0] )
         rounded_slit(1,24,2*th);
	  }
	}
}

module Cover2() {
   difference() {
	  mirror() rampsCover();
	  //USB (12x11)
	  translate( [-13.5,10.75,0] )
     cube( size=[13,11.5,2*th], center=true );
	  //Powerjack (9x11)
	  translate( [16.5,10.25,0] )
     cube( size=[10,11.5,2*th], center=true );
	  //Powerconnector (21x9)
	  translate( [19,-2,0] )
     cube( size=[22,10,30], center=true );
     //Connector tabs
     translate( [13,-7,0] )
     cube( size=[2.5,4,30], center=true );
     translate( [24,-7,0] )
     cube( size=[2.5,4,30], center=true );
     // Ramps PCB Edge Clearance
     translate( [27.5,2.5,5] )
     cube( size=[10,4,5], center=true );
     translate( [-27.5,2.5,5] )
     cube( size=[10,4,5], center=true );
	  //Ventilation slits
	  for ( y = [0:3.5:15] ) {
			translate( [-15,-18+y,0] ) rounded_slit(1,20,2*th);
	  }
  }
}

module CaseBody() {
   difference() {
     union() {
	  rampsCase();
     }
   //Reset Button Access Hole
   translate( [32.5, -2,  33])
   rotate ([0,90,0])
   cylinder( h=4,d1=4,d2=4,center=c);
   };
}

module rampsCase() {
	//case
   roundedDuct([67,48,length], 4);
	//PCB mount ridge left
	
	translate( [23, 18, 9] )
    cube( size=[9.5,3,length -18], center=c);
    translate( [23,12.5,9] )
    cube( size=[9.5,3,length -18], center=c);
    translate( [26,15.5,9] )
    cube( size=[7,3,length -18], center=c);

	//right
	translate( [-32.5,18,9] ) 
    cube( size=[4.5,3,length-18], center=c);
	//upper right (shortened to leave room for the reset switch)
	translate( [-32.5,12.5,9] )
    cube( size=[4.5,3,length-18], center=c);

// Test for Mounting Cone placment
//    translate( [23, 20, 0] )
//    cube( size=[4.5,3,8], center=c);
// Test for Mounting Cone placment

	//feet
	translate( [-width/2+6,25.5,0] )
    cube( size=[5,fh,length], center=c);
	translate( [width/2-11,25.5,0] )
    cube( size=[5,fh,length], center=c);

	//embellishment
	for ( z = [0:1:5] ) {
		translate( [-5-z*1.25*th,-height/2-1.5*th,0] ) cylinder( r=th/2, h=length, center=c);
	}

	//bottom cover mount
	translate( [-width/2,height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=45 ) mountCone();
	translate( [-width/2,-height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=-45 ) mountCone();
	translate( [width/2,-height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=-135 ) mountCone();
	translate( [width/2,height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=135 ) mountCone();

	//top cover mount
	translate( [width/2,-height/2,length-12]  ) rotate( v=[0,0,1], a=45 ) mountCone();
	translate( [-width/2,-height/2,length-12]  ) rotate( v=[0,0,1], a=-45 ) mountCone();
	translate( [-width/2,height/2,length-12]  ) rotate( v=[0,0,1], a=-135 ) mountCone();
	translate( [width/2,height/2,length-12]  ) rotate( v=[0,0,1], a=135 ) mountCone();
}

module rampsCover() {

   roundedDuct([67,48,ch], 4);
   translate( [0,0,0] )
   roundedRect([67,48,th], 4);

	//ridge
	translate( [0,(height-rth+.7)/2,ch] ) cube( size=[width-14,rth,ch], center=true );
	translate( [0,-(height-rth-1.3)/2,ch] ) cube( size=[width-14,rth,ch], center=true );
	translate( [((width-rth)/2)-.3,0,ch] ) cube( size=[rth,height-14,ch], center=true );
	translate( [-((width-rth)/2)+.3,0,ch] ) cube( size=[rth,height-14,ch], center=true );

	//embellishment
	for ( z = [0:1:5] ) {
		translate( [5+z*1.25*th,-height/2-1.5*th,0] ) 
        cylinder( r=th/2, h=ch, center=c);
	}

	//holes
	translate( [width/2,-height/2,-7]  ) rotate( v=[0,0,1], a=45 ) mount();
	translate( [-width/2,-height/2,-7]  ) rotate( v=[0,0,1], a=-45 ) mount();
	translate( [-width/2,height/2,-7]  ) rotate( v=[0,0,1], a=-135 ) mount();
	translate( [width/2,height/2,-7]  ) rotate( v=[0,0,1], a=135 ) mount();

}

module mountCone() {
	difference() {
		union() {
			for ( z = [0:0.5:7] ) {
				translate( [0,z/2,z] ) cylinder( r=z/2, h=1, center=c );
			}
			mount();
		}
		translate( [0,3,8] ) cylinder( r=1, h=8, center=c );
	}
}

module mount() {
	difference() {
		translate( [0,3,7] ) cylinder( r=4, h=5, center=c );
		translate( [0,3,7] ) cylinder( r=1, h=6, center=c );
	}
}

module rounded_slit(height, width, depth) {
		cube( size=[width,height,depth], center=true );
		translate( [width/2,0,0] ) cylinder( r=height/2, h=depth, center=true );
		translate( [-width/2,0,0] ) cylinder( r=height/2, h=depth, center=true );

}


module fanmount()
{
   difference() {
      roundedRect([29,29,3 ], 2);
      cylinder( r=14, h=3, center=1 );
   }
}

module roundedRect(size, radius)
{
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull()
{
// place 4 circles in the corners, with the given radius
translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);
}
}


module roundedDuct(size, radius)
{
x = size[0];
y = size[1];
z = size[2];
x2 = size[0]-4;
y2 = size[1]-4;
radius2 = 2.5;
linear_extrude(height=z) 
difference() {
hull()
  {
  // place 4 circles in the corners, with the given radius
  translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
  circle(r=radius);

  translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
  circle(r=radius);

  translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
  circle(r=radius);

  translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
  circle(r=radius);
  }
hull()
  {
  // place 4 circles in the corners, with the given radius
  translate([(-x2/2)+(radius2/2), (-y2/2)+(radius2/2), 0])
  circle(r=radius2);

  translate([(x2/2)-(radius2/2), (-y2/2)+(radius2/2), 0])
  circle(r=radius2);

  translate([(-x2/2)+(radius2/2), (y2/2)-(radius2/2), 0])
  circle(r=radius2);

  translate([(x2/2)-(radius2/2), (y2/2)-(radius2/2), 0])
  circle(r=radius2);
  }
}

}


