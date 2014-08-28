longueur_carte = 114;
largeur_carte = 63;
epaisseur_carte = 0.5;
nb_cartes = 94;
hauteur_cartes = epaisseur_carte*nb_cartes;
epaisseur = 2;
marge = 0.1;


module boite(){
	difference(){
		cube([longueur_carte+2*epaisseur, largeur_carte+2*epaisseur, hauteur_cartes+epaisseur], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte, largeur_carte, hauteur_cartes+marge], center=true);
		translate([0,0,hauteur_cartes/2-hauteur_cartes/6+epaisseur]) rotate([180,0,0]) couvercle();
	}
}


module couvercle(){
	difference(){
		cube([longueur_carte+2*epaisseur+marge, largeur_carte+2*epaisseur+marge, hauteur_cartes/3+epaisseur], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte+epaisseur, largeur_carte+epaisseur, hauteur_cartes/3+marge], center=true);
	}
}

translate([0,-largeur_carte,0]) color("blue") boite();
translate([0,+largeur_carte,0]) color("red") couvercle();