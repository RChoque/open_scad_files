difference(){
translate([-19,0,0]) color("blue") cube([38,39.1,10]);
rotate([0,0,180]) translate([0,-40,-1]) color("green") frein_hollow();
}
translate([0,7,9]) color("red") frein();

module frein(){
	difference(){
		union(){
			translate([-16,0,5]) cube([32,32,4]);
			translate([-12.5,5,0]) cube([25,24,5]);
		}
		translate([0,13.5,0]) cylinder (r=3, h=10, $fn=96);
	}
}

module frein_hollow(){
	translate([-17,0,3]) cube([34,38,6]);
	translate([-13.5,0,0]) cube([27,34,3]);
	translate([0,19.5,0]) cylinder (r=3, h=15, $fn=96);
}