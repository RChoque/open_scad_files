hauteur = 50;
nb_tige = 8;
rayon = 25;
petit_rayon = 5;
twist = 90;
detail = 100;

module tete(){
	angle = 360/nb_tige;
	rotate([90,0,0])
	translate([0, 0, hauteur/2])
	union(){
		translate([0, 0, hauteur/2]) tore(rayon,petit_rayon*1.25);
	
		for (i=[0:nb_tige-1]){
			rotate([0,0,angle*i]) translate([rayon, 0, 0]) rotate([0,0,2*angle]) translate([-rayon, 0, 0]) tige(hauteur, rayon, petit_rayon, twist);
		}
	}
}

module tete2(){
	angle = 360/nb_tige;
	rotate([90,0,0])
	translate([0, 0, hauteur/2])
	union(){
		translate([0, 0, hauteur/2]) scale([1,1,0.5]) sphere(rayon,center = true);
	
		for (i=[0:nb_tige-1]){
			rotate([0,0,angle*i]) translate([rayon, 0, 0]) rotate([0,0,angle]) translate([-rayon, 0, 0]) tige(hauteur, rayon, petit_rayon, twist);
		}
	}
}

module tore(rayon, petit_rayon){
	rotate_extrude(convexity = 1, $fn=detail) translate([rayon,0,0]) circle(r=petit_rayon, $fn=detail);
}

module tige(hauteur, rayon, petit_rayon, angle){
	linear_extrude(height = hauteur, center = true, convexity = 10, twist = -angle, $fn=detail)
	translate([rayon, 0, 0])
	circle(r = petit_rayon, $fn=detail);
}




