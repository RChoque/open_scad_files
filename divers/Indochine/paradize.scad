
module paradize(){
	union(){
	translate([-0.005,0.38,0]) color("white") linear_extrude(height = 1.5) scale(0.15,0.15,1) import("paradize3.dxf");
	translate([0.19,0,1.4]) color("red") linear_extrude(height = 3.5) scale(0.15,0.15,1) import("paradize1.dxf");
	translate([0,0,4.8]) color("black") linear_extrude(height = 1.5) scale(0.15,0.15,1) import("paradize2.dxf");
	}
}

difference(){
	union(){
		paradize();
		translate([15,40,0]) color("yellow") cylinder(r=2.5, h=6.3, $fn=96);
	}
	translate([15,40,-2]) color("orange") cylinder(r=1.5, h=10, $fn=96);
}
