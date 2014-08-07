detail = 10;
rayon_sphere = 2;
hauteur = 20;
diametre= 10;
rayon = 80;

module tore(diametre, petit_rayon){
	rotate_extrude(convexity = 10, $fn = 2*detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
	
}

module support_tore(diametre, petit_rayon, hauteur){
	angle = -10;
	minkowski(){
		union(){
		difference(){
		rotate_extrude($fn = 2*detail) translate([petit_rayon+rayon_sphere-diametre/2, 0, 0]) square([diametre-2*rayon_sphere, hauteur]);	
		rotate([0, angle, 0]) translate([0,0, -hauteur/2]) cube([3*petit_rayon, 3*petit_rayon, 2*hauteur], center=true);
					}
		translate([-petit_rayon-diametre/2,0,(hauteur+diametre/2)/2]) cube([3*diametre/2, petit_rayon,hauteur+(diametre/2)-rayon_sphere], center = true);
}
		sphere (rayon_sphere, $fn=detail);
	}
}


translate([0,0,hauteur]) tore(diametre,rayon);
support_tore(diametre, rayon, hauteur);
//-rotate([10, 0, 0]) cube([160, 160, 20], center=true);