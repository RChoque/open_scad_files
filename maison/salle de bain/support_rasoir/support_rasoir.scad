detail = 50;
diametre_tube_blaireau = 8;
petit_rayon_support_blaireau = 13+diametre_tube_blaireau/2;
grand_rayon_support_blaireau = petit_rayon_support_blaireau*2;
cote_triangle = 26+diametre_tube_blaireau*4;
hauteur_triangle = cote_triangle*sqrt(3)/4;
angle = 45;

module semi_circle(diametre, petit_rayon){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([0,(petit_rayon+diametre)/2,0]) cube([petit_rayon*2+diametre,petit_rayon+diametre,10], center=true);
	}
}

module end_curve(diametre, petit_rayon, grand_rayon){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([grand_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
		rotate([0,0,90+angle]) translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module support_line(diametre, petit_rayon){
	linear_extrude(height = petit_rayon, center = true, convexity = 10, twist = 0)
	circle(r = diametre/2, $fn = detail);
}

module pince(diametre, petit_rayon, grand_rayon){
	semi_circle(diametre, petit_rayon);
	translate([petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve(diametre, petit_rayon, grand_rayon);
	translate([petit_rayon,petit_rayon/2,0]) rotate([90,0,0]) support_line(diametre, petit_rayon);
	translate([petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)]) sphere(diametre/2, $fn=detail); 
	translate([-petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve(diametre, petit_rayon, grand_rayon);
	translate([-petit_rayon,petit_rayon/2,0]) rotate([90,0,0]) support_line(diametre, petit_rayon);
	translate([-petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)]) sphere(diametre/2, $fn=detail); 
translate([0,-petit_rayon-diametre/2,0]) cube([2*petit_rayon/3,diametre,diametre], center=true);
}


translate([0,0,hauteur_triangle]) rotate([0,45,0]) rotate([0,90,90]) 
pince(diametre_tube_blaireau, petit_rayon_support_blaireau, grand_rayon_support_blaireau);

rotate([90,0,0]) linear_extrude(height=50, center=true) polygon(points=[[0,0],[cote_triangle,0],[cote_triangle/2,hauteur_triangle]], paths=[[0,1,2]]);