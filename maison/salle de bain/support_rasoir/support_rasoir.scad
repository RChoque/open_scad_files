detail = 100;
diametre = 8;
petit_rayon = 13+diametre/2;
grand_rayon = petit_rayon*2;
angle = 45;

module semi_circle(){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([0,(petit_rayon+diametre)/2,0]) cube([petit_rayon*2+diametre,petit_rayon+diametre,10], center=true);
	}
}

module end_curve(){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([grand_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
		rotate([0,0,90+angle]) translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module support_line(){
	linear_extrude(height = petit_rayon, center = true, convexity = 10, twist = 0)
	circle(r = diametre/2, $fn = detail);
}

module support_brosse(){
	semi_circle();
	translate([petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve();
	translate([petit_rayon,petit_rayon/2,0]) rotate([90,0,0]) support_line();
	translate([petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)]) sphere(diametre/2, $fn=detail); 
	translate([-petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve();
	translate([-petit_rayon,petit_rayon/2,0]) rotate([90,0,0]) support_line();
	translate([-petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)]) sphere(diametre/2, $fn=detail); 
}


support_brosse();