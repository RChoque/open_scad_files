
module paradize(){
	union(){
	translate([-0.07,0.5,0]) color("white") linear_extrude(height = 1.5) scale(0.20,0.20,1) import("paradize3.dxf");
	translate([0.19,0,1.4]) color("red") linear_extrude(height = 3.5) scale(0.20,0.20,1) import("paradize1.dxf");
	translate([-0.06,0,4.8]) color("black") linear_extrude(height = 1.5) scale(0.20,0.20,1) import("paradize2.dxf");
	}
}

difference(){
	union(){
		paradize();
		translate([20.3,54,0]) color("yellow") cylinder(r=2.5, h=6.3, $fn=96);
	}
	translate([20.3,54,-2]) color("orange") cylinder(r=1.5, h=10, $fn=96);
}
