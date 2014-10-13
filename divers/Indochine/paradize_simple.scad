difference(){
	union(){
		translate([0.19,0,0]) color("red") linear_extrude(height = 6) scale(0.15,0.15,1) import("paradize1.dxf");
		translate([15,40,0]) color("yellow") cylinder(r=2.5, h=6, $fn=96);
	}
	translate([15,40,-2]) color("orange") cylinder(r=1.68, h=10, $fn=96);
}
