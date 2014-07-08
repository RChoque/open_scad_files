diametre = 10;
petit_rayon = 25;
grand_rayon = 50;
detail = 100;
angle = 45;

module haut(){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module bas(){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([grand_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
		rotate([0,0,90+angle]) translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module tete(){
	rotate([-angle,0,0]) translate([0, 0, -grand_rayon]) haut();
	translate([petit_rayon, 0, 0]) rotate([0,90,0]) bas();
	translate([-petit_rayon, 0, 0]) rotate([0,90,0]) bas();
}




