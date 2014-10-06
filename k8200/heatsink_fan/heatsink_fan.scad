fan_width = 40;
rounded_corner = 2;
detail = 50;

//translate([0,0, -17.5]) import("K8200_extruder_fan_housing.stl");

translate([0,-3,0]) etape5();

module fan_holder(){
	$fn=50;
	difference(){
		union(){
			difference(){
				union(){
					translate([0,0,0])	minkowski() {
		    			cube([fan_width-2*rounded_corner,fan_width-2*rounded_corner,5], center=true);
		    			cylinder(r=rounded_corner,h=2);
					}
				}
				translate([0,0,1]) cylinder(h=14, r=37/2, $fn=60, center=true);
			}
	
		}
		for (i=[0:3]){
			rotate([0,0,90*i]) translate([16.5,16.5,1]) cylinder(h=11, r=4/2, $fn=30, center=true);
		}

	}
}

module etape1(){
	difference(){
		union(){
			translate([0,2,-1.5]) color("cyan") cube([30,26,24], center=true);
			translate([15,3,-1.5]) color("red") cylinder(r=6, h=24, center=true);
			translate([-15,3,-1.5]) color("red") cylinder(r=6, h=24, center=true);
		}
		translate([0,2,1]) cube([26,26.1,25], center=true);
		translate([0,3,0]) cylinder(r=9, h=30, center=true);
	}
}

module etape1b(){
	difference(){
		union(){
			translate([0,-2.5,-1.5]) color("cyan") cube([30,25,24], center=true);
			translate([15,3,-1.5]) color("red") cylinder(r=6, h=24, center=true);
			translate([-15,3,-3]) color("red") cylinder(r=6, h=21, center=true);
			translate([0,8,-1.5]) cylinder(r=15, h=24, center=true);
		}
		translate([0,-3,1]) cube([26,24,25], center=true);
		translate([0,3,0]) cylinder(r=9, h=30, center=true);
		translate([0,8,0.5]) cylinder(r=13, h=24, center=true);
		translate([0,20,1]) cube([8,10,24], center=true);
	}
}

module etape2(){
	difference(){
		union(){
			etape1b();
			translate([13,3,-9.5]) color("green") cube([2,11,8], center=true);
			translate([-13,3,-9.5]) color("green") cube([2,11,8], center=true);
		}
		translate([15,3,8]) rotate([0,0,90]) color("red") cylinder(r=3.6, h=27, $fn=6, center=true);
		translate([-15,3,8]) rotate([0,0,90]) color("red") cylinder(r=3.6, h=27, $fn=6, center=true);
		translate([15,3,-1.5]) color("red") cylinder(r=1.8, h=27, $fn=20, center=true);
		translate([-15,3,-1.5]) color("red") cylinder(r=1.8, h=27, $fn=20, center=true);
	}
}

module etape3(){
	difference(){
		union(){
			etape2();
			translate([0,-22,0]) cube([30,15,27], center=true);
		}
		translate([0,-25,0]) rotate([90,0,0]) color("red") cylinder(r=12, h=40, $fn=detail, center=true);
	}	
}

module etape4(){
	etape3();
	translate([0,-34.5,-13.5]) rotate([90,0,180])
	difference(){
		linear_extrude(height = 10, center = true, convexity = 10, scale=[0.75,0.67], $fn=detail) translate([-20, 0, 0]) square([40,40]);
		translate([0,1.5,0]) linear_extrude(height = 11, center = true, convexity = 10, scale=[0.6,0.6], $fn=detail) translate([0, 18.8, 0]) circle(r = 18.9);
	}
}

module etape5(){
	difference(){
		union(){
			etape4();
			translate([0,-42,6.5]) rotate([90,0,0]) fan_holder();			
		}
		for (i=[0:3]){
			translate([0,0,6.5]) rotate([90,90,0]) rotate([0,0,90*i]) translate([16.5,16.5,34.6]) cylinder(h=10, r=4, $fn=detail, center=true);
			translate([0,0,6.5]) rotate([90,90,0]) rotate([0,0,90*i]) translate([18.2,18.2,34.6]) cube([2,2,5]);
		}	
	}
}