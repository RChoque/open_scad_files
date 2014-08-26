longueur_boite = 165;
largeur_boite_1 = 80;
largeur_boite_2 = 144;
epaisseur = 1.5;
longueur_tuile = 70;
largeur_tuile = 70;
nb_tuiles = 16;
longueur_carte_role = 45;
largeur_carte_role = 35;
nb_carte_role = 6;
longueur_pion = 30;
largeur_pion = 17;
nb_pion = 6;
longueur_carte_fleche = 25;
largeur_carte_fleche = 16;
nb_carte_fleche = 6;
longueur_carte_action = 32;
largeur_carte_action = 32;
nb_carte_action = 4;
longueur_compte_rebour = 140;
largeur_compte_rebour = 60;
diametre_jeton = 22;
nb_jetons = 6;
epaisseur_carte = 2.4;
espace = 5;


module plateau(longueur, largeur, epaisseur){
	cube([longueur, largeur, epaisseur], center = true);
}

module bloc_carte(longueur_carte, largeur_carte, hauteur_bloc, epaisseur){
	difference(){
		cube([longueur_carte+2*epaisseur, largeur_carte+2*epaisseur, hauteur_bloc], center=true);
		cube([longueur_carte, largeur_carte, 2*hauteur_bloc], center=true);
		triangle_decoupe(largeur_carte+3*epaisseur, longueur_carte, 2*hauteur_bloc);
		rotate([0,0,90]) triangle_decoupe(longueur_carte+3*epaisseur, largeur_carte+2*epaisseur, 2*hauteur_bloc);
	}
}

module cylindre_carte(diametre_carte, hauteur_bloc, epaisseur){
	difference(){
		cylinder(h=hauteur_bloc, r=diametre_carte/2+epaisseur, $fn=detail, center=true);
		cylinder(h=2*hauteur_bloc, r=diametre_carte/2, $fn=detail, center=true);
		triangle_decoupe(diametre_carte+3*epaisseur, diametre_carte, 4*hauteur_bloc);
		rotate([0,0,90]) triangle_decoupe(diametre_carte+3*epaisseur, diametre_carte+2*epaisseur, 4*hauteur_bloc);
	}
}

module bloc_compte_rebour(longueur_carte, largeur_carte, hauteur_bloc, hauteur_support, epaisseur){
	difference(){
		bloc_carte(longueur_carte-4*epaisseur, largeur_carte-4*epaisseur, hauteur_bloc+hauteur_support, 3*epaisseur);
		translate([0,0, hauteur_support/2]) cube([longueur_carte,largeur_carte,hauteur_bloc], center=true);
	}
}

module triangle_decoupe(longueur, largeur, hauteur){
	translate([-largeur/2,0,hauteur/2])rotate([-90,0,0]) linear_extrude(height=longueur, center=true) polygon(points=[[0,0],[largeur,0],[largeur/2,hauteur]], paths=[[0,1,2]]);
}


module rangement1(){
	union(){
		translate([0,0,-epaisseur/2]) plateau(longueur_boite, largeur_boite_1, epaisseur);
		translate([(longueur_tuile+2*epaisseur)/2+((longueur_boite/2)-(longueur_tuile+2*epaisseur))/2,0,nb_tuiles*epaisseur_carte/2]) bloc_carte(longueur_tuile, largeur_tuile, nb_tuiles*epaisseur_carte, epaisseur);
		translate([-(longueur_tuile+2*epaisseur)/2-((longueur_boite/2)-(longueur_tuile+2*epaisseur))/2,0,nb_tuiles*epaisseur_carte/2]) bloc_carte(longueur_tuile, largeur_tuile, nb_tuiles*epaisseur_carte, epaisseur);
	}
}

module rangement2(){
	position_compte_rebour_y = espace+(largeur_compte_rebour+3*epaisseur-(largeur_boite_2+epaisseur))/2;
	position_carte_role_x = espace+((longueur_carte_role+epaisseur)-(longueur_compte_rebour+3*epaisseur))/2;
	position_carte_role_y = position_compte_rebour_y;
	
	espace_carte_action = (longueur_boite-6*(nb_carte_action*epaisseur_carte+2*epaisseur)-2*espace)/5;
	echo(espace_carte_action);
	position_carte_action1_x = espace+(nb_carte_action*epaisseur_carte)/2-longueur_boite/2;
	position_carte_action2_x = position_carte_action1_x+espace_carte_action+(nb_carte_action*epaisseur_carte)/2;
	position_carte_action3_x = position_carte_action2_x+espace_carte_action+(nb_carte_action*epaisseur_carte)/2;
	position_carte_action4_x = position_carte_action3_x+espace_carte_action+(nb_carte_action*epaisseur_carte)/2;
	position_carte_action5_x = position_carte_action4_x+espace_carte_action+(nb_carte_action*epaisseur_carte)/2;
	position_carte_action6_x = position_carte_action5_x+espace_carte_action+(nb_carte_action*epaisseur_carte)/2;
	position_carte_action_y = largeur_boite_2/2-espace-(longueur_carte_action+2*epaisseur)/2;

	position_pion_x = espace+longueur_pion/2-longueur_boite/2;
	position_pion_y = position_carte_action_y-(longueur_carte_action+2*epaisseur)/2-(largeur_pion+2*epaisseur)/2-espace;
	position_carte_fleche_x = position_pion_x+(largeur_pion+2*epaisseur)/2+(largeur_carte_fleche+2*epaisseur)/2;
	position_carte_fleche_y = position_compte_rebour_y+(largeur_carte_role-largeur_carte_fleche)/2 + epaisseur;

	union(){
		translate([0,0,-epaisseur/2]) plateau(longueur_boite, largeur_boite_2, epaisseur);
		translate([0,position_compte_rebour_y,(nb_carte_role+4)*epaisseur_carte/2]) bloc_compte_rebour(longueur_compte_rebour, largeur_compte_rebour, 3*epaisseur_carte, (nb_carte_role+1)*epaisseur_carte, epaisseur);
		translate([position_carte_role_x,position_carte_role_y,nb_carte_role*epaisseur_carte/2]) rotate([0,0,90]) bloc_carte(longueur_carte_role, largeur_carte_role, nb_carte_role*epaisseur_carte, epaisseur);
		translate([position_carte_fleche_x,position_carte_fleche_y,nb_carte_fleche*epaisseur_carte/2]) bloc_carte(longueur_carte_fleche, largeur_carte_fleche, nb_carte_fleche*epaisseur_carte, epaisseur);
		translate([0,0,(nb_jetons*epaisseur_carte)/2])cylindre_carte(diametre_jeton, nb_jetons*epaisseur_carte, epaisseur);
		
		// Cartes action
		translate([position_carte_action1_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
		translate([position_carte_action2_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
		translate([position_carte_action3_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
		translate([position_carte_action4_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
		translate([position_carte_action5_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
		translate([position_carte_action6_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action, nb_carte_action*epaisseur_carte, largeur_carte_action, epaisseur);
	
		// Cartes pions
		translate([position_pion_x,position_pion_y,nb_pion*epaisseur_carte/2]) bloc_carte(longueur_pion, largeur_pion, nb_pion*epaisseur_carte, epaisseur);
		
	}
}

rangement2();


		