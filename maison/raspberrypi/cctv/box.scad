largeur_pi = 40;
longueur_pi = 40;
hauteur_gpio = 10;
epaisseur = 1.5;
rayon_arrondi = 4;
detail = 20;



module rounded_block(longueur, largeur, hauteur, rayon){
	difference(){
		minkowski(){
			cube([longueur-2*rayon, largeur-2*rayon, hauteur]);
			sphere (rayon, $fn=detail);
		}
		translate([-rayon,-rayon,hauteur]) cube([longueur, largeur, rayon]);
		translate([-rayon,-rayon,-rayon]) cube([longueur, largeur, rayon]);
	}
	
}

module rounded_box(longueur, largeur, hauteur, rayon, epaisseur){
	difference(){
		rounded_block(longueur, largeur, hauteur, rayon);
		translate([epaisseur,epaisseur,epaisseur]) rounded_block(longueur-2*epaisseur, largeur-2*epaisseur, hauteur, rayon);
	}
	
}

rounded_box(largeur_pi, longueur_pi, hauteur_gpio, rayon_arrondi, epaisseur);