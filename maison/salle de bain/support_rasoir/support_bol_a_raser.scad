detail = 20;

module semi_circle(diametre, petit_rayon){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([0,petit_rayon/2,0]) cube([petit_rayon,petit_rayon,10], center=true);
	}
	rotate([0,0,10]) translate([0,petit_rayon,0])sphere(diametre/2, $fn=detail);
translate([0,petit_rayon/2,0]) cube([petit_rayon,petit_rayon+diametre,10], center=true); 
}

semi_circle(10,80);