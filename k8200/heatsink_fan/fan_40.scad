fan_width = 40;
rounded_corner = 2;


module fan(){
	$fn=50;
	difference(){
		union(){
			difference(){
				union(){
					translate([0,0,0])	minkowski() {
		    			cube([fan_width-2*rounded_corner,fan_width-2*rounded_corner,8], center=true);
		    			// rounded corners
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

fan();