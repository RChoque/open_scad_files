
module base(){
minkowski (){
	union(){
		cube([16,70,20.5]);
		translate([0,70,0]) rotate([90,0,0]) linear_extrude(height = 70) polygon (points=[[0,0],[0,20.5],[-8,20.5]]);
	}
	sphere (2, $fn=20);
}
}

module vis(){
	cylinder (r1=1.5, r2=1.5, h=10, $fn=100);
	cylinder (r1=4, r2=1.5, h=3, $fn=100);
}

difference(){
	base();
	translate([0,-2,0]) cube([20,80,22.5]);
	translate([-18,5,10]) rotate([0,90,0]) cylinder (r1=5, r2=5, h=16, $fn=100);
	translate([-18,25,10]) rotate([0,90,0]) cylinder (r1=5, r2=5, h=16, $fn=100);
	translate([-18,45,10]) rotate([0,90,0]) cylinder (r1=5, r2=5, h=16, $fn=100);
	translate([-18,65,10]) rotate([0,90,0]) cylinder (r1=5, r2=5, h=16, $fn=100);
	translate([-5,55,-10]) cylinder (r1=4.5, r2=4.5, h=30, $fn=100);
	translate([-5,35,-10]) cylinder (r1=4.5, r2=4.5, h=30, $fn=100);
	translate([-5,15,-10]) cylinder (r1=4.5, r2=4.5, h=30, $fn=100);
	translate([-5,15,20]) vis();
	translate([-5,35,20]) vis();
	translate([-5,55,20]) vis();
	translate([-2,5,10]) rotate([0,90,0]) vis();
	translate([-2,25,10]) rotate([0,90,0]) vis();
	translate([-2,45,10]) rotate([0,90,0]) vis();
	translate([-2,65,10]) rotate([0,90,0]) vis();
	translate([10,15,-2]) vis();
	translate([10,35,-2]) vis();
	translate([10,55,-2]) vis();
}





