detail = 30;
rayon_sphere = 2;
marge = 0.5;
diametre_tube_blaireau = 8;
diametre_tube_rasoir = 6;
petit_rayon_support_blaireau = 14+diametre_tube_blaireau/2;
petit_rayon_support_rasoir = 6.5+diametre_tube_rasoir/2;
grand_rayon_support_blaireau = petit_rayon_support_blaireau*2;
grand_rayon_support_rasoir = petit_rayon_support_rasoir*2;
cote_triangle = 26+diametre_tube_blaireau*4;
hauteur_triangle = sin(45)*cote_triangle;
longueur_trapeze = 30;
angle = 45;

module vis(){
	cylinder (r1=2, r2=2, h=50, $fn=100);
	cylinder (r1=4, r2=2, h=2, $fn=100);
}

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

module pince(diametre, petit_rayon, grand_rayon){
	semi_circle(diametre, petit_rayon);
	translate([petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve(diametre, petit_rayon, grand_rayon);
	translate([petit_rayon,petit_rayon/2-0.1,0]) rotate([90,0,0]) cylinder(h=petit_rayon+0.4, r=diametre/2, $fn=detail, center=true);
	translate([petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)+0.2]) sphere(diametre/2, $fn=detail); 
	translate([-petit_rayon,petit_rayon,grand_rayon]) rotate([0,90,180]) end_curve(diametre, petit_rayon, grand_rayon);
	translate([-petit_rayon,petit_rayon/2-0.1,0]) rotate([90,0,0]) cylinder(h=petit_rayon+0.4, r=diametre/2, $fn=detail, center=true);
	translate([-petit_rayon,petit_rayon+(sin(angle)*grand_rayon),grand_rayon-(cos(angle)*grand_rayon)+0.2]) sphere(diametre/2, $fn=detail); 
}

module support_pince(diametre, petit_rayon, grand_rayon, hauteur){
	minkowski(){
		difference(){
			union(){
				difference(){
					rotate_extrude($fn = detail) translate([petit_rayon-rayon_sphere/2, 0, 0]) square([diametre/2-rayon_sphere/2, hauteur]);	
					translate([-(petit_rayon+rayon_sphere),0,-marge]) cube([2*(petit_rayon+rayon_sphere+marge), petit_rayon+rayon_sphere, hauteur+2*marge]);
				}
				translate([petit_rayon-3*rayon_sphere/4+diametre/4, petit_rayon/2, hauteur/2]) cube([diametre/2-rayon_sphere/2, petit_rayon, hauteur], center = true);
				translate([-(petit_rayon-3*rayon_sphere/4)-diametre/4, petit_rayon/2, hauteur/2]) cube([diametre/2-rayon_sphere/2, petit_rayon, hauteur], center = true);
				translate([0, -petit_rayon-rayon_sphere, (hauteur+diametre-3*rayon_sphere)/2]) cube([petit_rayon-2*rayon_sphere,diametre-2*rayon_sphere,hauteur+diametre-3*rayon_sphere], center=true);	
			}
			translate([0, -petit_rayon, hauteur]) rotate([-90,0,90]) linear_extrude(height=2*(petit_rayon+rayon_sphere+marge), center=true) polygon(points=[[2*(petit_rayon+marge),hauteur+marge],[2*(petit_rayon+marge),0],[0,hauteur+marge]], paths=[[0,1,2]]);
		}
		sphere (rayon_sphere, $fn=detail);
	}
}

module pince_complete(diametre, petit_rayon, grand_rayon, hauteur){
	pince(diametre, petit_rayon, grand_rayon);
	translate([0,0,-hauteur]) support_pince(diametre, petit_rayon, grand_rayon, hauteur);
}

module pince_blaireau(){
	translate([-rayon_sphere-petit_rayon_support_blaireau-diametre_tube_blaireau/2,0,cote_triangle/2]) rotate([0,90,90]) pince_complete(diametre_tube_blaireau, petit_rayon_support_blaireau, grand_rayon_support_blaireau,diametre_tube_blaireau);
	rotate([90,0,0]) 
	difference(){
		minkowski(){
			difference(){
				linear_extrude(height=longueur_trapeze, center=true) polygon(points=[[0,0],[cote_triangle,0],[0,cote_triangle]], paths=[[0,1,2]]);
				rotate([0,O,45]) cube([8,8,longueur_trapeze], center=true);
			}
			sphere (rayon_sphere, $fn=detail);
		}
		rotate([0,0,45]) translate([hauteur_triangle+(rayon_sphere/2),0,0]) cube([rayon_sphere,150,150], center=true);
	}
}

module pince_rasoir(){
	translate([cote_triangle/2,0,-(rayon_sphere+petit_rayon_support_rasoir+diametre_tube_rasoir/2)]) rotate([0,-90,0]) rotate([0,90,90]) pince_complete(diametre_tube_rasoir, petit_rayon_support_rasoir, grand_rayon_support_rasoir, diametre_tube_rasoir);
	translate([4-rayon_sphere+cote_triangle/8, 0, -rayon_sphere]) color("red") rotate([90,0,0]) linear_extrude(height=3*longueur_trapeze/4, center=true) polygon(points=[[0,0],[3*cote_triangle/4,0],[0,3*cote_triangle/4]], paths=[[0,1,2]]);
}

module support_blaireau(){
	difference(){
		pince_blaireau();
		translate([4-rayon_sphere-marge+cote_triangle/8, 0, -rayon_sphere]) color("red") rotate([90,0,0]) linear_extrude(height=2*marge+3*longueur_trapeze/4, center=true) polygon(points=[[0,0],[2*marge+3*cote_triangle/4,0],[0,2*marge+3*cote_triangle/4]], paths=[[0,1,2]]);
		translate([0,longueur_trapeze/4-rayon_sphere,0]) rotate([0,45,0]) translate([0,0,2]) vis();
		translate([0,-longueur_trapeze/4+rayon_sphere,0]) rotate([0,45,0]) translate([0,0,2]) vis();
	}
}

module support_rasoir(){
	difference(){
		pince_rasoir();
		translate([0,longueur_trapeze/4-rayon_sphere,0]) rotate([0,45,0]) translate([0,0,2]) vis();
		translate([0,-longueur_trapeze/4+rayon_sphere,0]) rotate([0,45,0]) translate([0,0,2]) vis();
	}
}

//support_blaireau();
support_rasoir();
