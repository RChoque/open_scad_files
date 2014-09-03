longueur_carte = 114;
largeur_carte = 63;
epaisseur_carte = 0.5;
nb_cartes = 94;
hauteur_cartes = epaisseur_carte*nb_cartes;
epaisseur = 2;
marge = 0.5;
manifold = 0.01;


module boite(){
	difference(){
		cube([longueur_carte+2*epaisseur+2*marge, largeur_carte+2*epaisseur+2*marge, hauteur_cartes+epaisseur+marge], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte+2*marge, largeur_carte+2*marge, hauteur_cartes+manifold+marge], center=true);
		translate([0,0,hauteur_cartes/2-hauteur_cartes/6+epaisseur]) rotate([180,0,0]) color("red") couvercle_negatif();
	}
}


module couvercle(){
	difference(){
		cube([longueur_carte+2*epaisseur+manifold+2*marge, largeur_carte+2*epaisseur+manifold+2*marge, hauteur_cartes/3+epaisseur+marge], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte+epaisseur+marge, largeur_carte+epaisseur+marge, hauteur_cartes/3+manifold+marge], center=true);
	}
}

module couvercle_negatif(){
	difference(){
		cube([longueur_carte+2*epaisseur+manifold+2*marge, largeur_carte+2*epaisseur+manifold+2*marge, hauteur_cartes/3+epaisseur+marge], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte+epaisseur-marge, largeur_carte+epaisseur-marge, hauteur_cartes/3+manifold+marge], center=true);
	}
}

translate([0,-largeur_carte,0]) color("blue") boite();
translate([0,+largeur_carte,0]) color("red") couvercle();