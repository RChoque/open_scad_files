epaisseur = 0.5;
hauteur = 50;
longueur = 50;
largeur = 30;
longueur_col = 5;
largeur_col = 5;

module hollow_cube(x,y,z,epaisseur){
	difference(){
		cube([x,y,z], center=true);
		cube([x-2*epaisseur,y-2*epaisseur,z+epaisseur], center=true);
	}
}

module x(){
	hypotenuse = ceil(sqrt(pow((longueur_col-2*epaisseur),2) + pow((largeur_col-2*epaisseur),2)));
	angle = 45;
	translate([0,0,2.5]) rotate([0,0,angle]) cube([hypotenuse,epaisseur,5],center = true);
	translate([0,0,2.5]) rotate([0,0,-angle]) cube([hypotenuse,epaisseur,5],center = true);
}

module y(){
	hypotenuse = ceil(sqrt(pow((longueur_col-2*epaisseur),2) + pow((largeur_col-2*epaisseur),2)));
	angle = 45;
	translate([0,0,2.5]) rotate([0,0,angle]) cube([hypotenuse,epaisseur,5],center = true);
	rotate([0,0,3*angle]) cube([hypotenuse/2,epaisseur,5]);
}

union(){
	hollow_cube(longueur,largeur,hauteur,epaisseur);
	translate([-(longueur-longueur_col)/2, (largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
	translate([-(longueur-longueur_col)/2, -(largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
	translate([(longueur-longueur_col)/2, -(largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
translate([-(longueur-longueur_col)/2,(largeur-largeur_col)/2,-hauteur/2]) y();
translate([(longueur-longueur_col)/2,-(largeur-largeur_col)/2,-hauteur/2]) x();
}