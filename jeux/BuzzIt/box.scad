longueur_carte = 88;
largeur_carte = 56.5;
epaisseur_carte = 0.3;
nb_cartes = 84;
hauteur_cartes = epaisseur_carte*nb_cartes;
epaisseur = 2;
marge = 0.5;
manifold = 0.01;
hauteur_buzzer = 31;
largeur_plaque = 2*largeur_carte+5*marge+5*epaisseur;
longueur_plaque = longueur_carte+3*marge+4*epaisseur;
	
module bloc_carte(longueur_carte, largeur_carte, hauteur_bloc, epaisseur){
	difference(){
		cube([longueur_carte+2*epaisseur, largeur_carte+2*epaisseur, hauteur_bloc], center=true);
		cube([longueur_carte, largeur_carte, 2*hauteur_bloc], center=true);
		triangle_decoupe(largeur_carte+3*epaisseur, longueur_carte, 2*hauteur_bloc);
		rotate([0,0,90]) triangle_decoupe(longueur_carte+3*epaisseur, largeur_carte+2*epaisseur, 2*hauteur_bloc);
	}
}

module triangle_decoupe(longueur, largeur, hauteur){
	translate([-largeur/2,0,hauteur/2])rotate([-90,0,0]) linear_extrude(height=longueur, center=true) polygon(points=[[0,0],[largeur,0],[largeur/2,hauteur]], paths=[[0,1,2]]);
}

module bloc_verrou(largeur_plaque, epaisseur){
	translate([0,-largeur_plaque/2+epaisseur,0]) verrou(epaisseur);
	translate([0,largeur_plaque/2-epaisseur,0]) rotate([0,0,180])verrou(epaisseur);
}

module verrou(epaisseur){
	translate([0,0, 2*epaisseur]) sphere(r = epaisseur);
	translate([0,epaisseur/2, 3*epaisseur/2]) cube([2*epaisseur, epaisseur, 3*epaisseur], center=true);
}

module base(){
	cube([longueur_plaque, largeur_plaque, epaisseur], center=true);
	translate([0,-(largeur_carte+2*marge+2*epaisseur)/2+epaisseur/2,(hauteur_cartes+epaisseur)/2]) bloc_carte(longueur_carte+2*marge, largeur_carte+2*marge, hauteur_cartes, epaisseur);	
	translate([0,(largeur_carte+2*marge+2*epaisseur)/2-epaisseur/2,(hauteur_cartes+epaisseur)/2]) bloc_carte(longueur_carte+2*marge, largeur_carte+2*marge, hauteur_cartes, epaisseur);	
	bloc_verrou(largeur_plaque, epaisseur);
}


module couvercle_1(){
	hauteur_couvercle = hauteur_cartes+epaisseur+marge;
	difference(){
		cube([longueur_plaque, largeur_plaque, hauteur_couvercle], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_plaque-2*epaisseur, largeur_plaque-2*epaisseur, hauteur_cartes+manifold+marge], center=true);
		translate([0,0,hauteur_couvercle/2]) rotate([180,0,0]) bloc_verrou(largeur_plaque, epaisseur);
	}
	translate([0,0,-(hauteur_couvercle+hauteur_buzzer)/2]) 
	difference(){
		cube([longueur_plaque-2*epaisseur-marge, largeur_plaque-2*epaisseur-marge, hauteur_buzzer], center=true);
		cube([longueur_plaque-4*epaisseur-marge, largeur_plaque-4*epaisseur-marge, hauteur_buzzer+manifold+marge], center=true);
	}
}

module couvercle_2(){
	difference(){
		cube([longueur_plaque, largeur_plaque, hauteur_buzzer+epaisseur+marge], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_plaque-2*epaisseur, largeur_plaque-2*epaisseur, hauteur_cartes+manifold+marge], center=true);
	}
}



translate([0,0,hauteur_cartes/2]) rotate([0, 180, 0]) translate([0,-2*largeur_carte,0]) color("blue") base();
translate([0,+2*largeur_carte,0]) couvercle_1();
