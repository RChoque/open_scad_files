hauteur = 50;
nb_tige = 8;
rayon = 25;
petit_rayon = 5;
twist = 90;
detail = 100;

module tete(id_tete){
	if(id_tete == 1){
		tete_1();
	}
	if(id_tete == 2){
		tete_2();
	}
	if(id_tete == 3){
		tete_3();
	}
}

module tete_1(){
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

module tete_2(){
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



module tete_3_haut(diametre,petit_rayon,grand_rayon){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module tete_3_bas(diametre,petit_rayon,grand_rayon,angle){
	difference(){
		rotate_extrude(convexity = 10, $fn = detail)
		translate([grand_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
		translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
		rotate([0,0,90+angle]) translate([-(grand_rayon+petit_rayon), 0, -diametre]) cube([2*(grand_rayon+petit_rayon),2*petit_rayon+grand_rayon,2*diametre]);
	}	
}

module tete_3(){
	diametre = 12;
	petit_rayon = 25;
	grand_rayon = 50;
	angle = 45;
	translate([0,0,hauteur/2])
	union(){
		rotate([-angle,0,0]) translate([0, 0, -grand_rayon]) tete_3_haut(diametre,petit_rayon,grand_rayon);
		translate([petit_rayon, 0, 0]) rotate([0,90,0]) tete_3_bas(diametre,petit_rayon,grand_rayon,angle);
		translate([-petit_rayon, 0, 0]) rotate([0,90,0]) tete_3_bas(diametre,petit_rayon,grand_rayon,angle);
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




