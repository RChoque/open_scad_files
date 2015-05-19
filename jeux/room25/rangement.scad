longueur_boite = 165;
largeur_boite_1 = 80;
largeur_boite_2 = 144;
epaisseur = 1.5;
longueur_tuile = 69.6;
largeur_tuile = 69.6;
nb_tuiles = 16;
longueur_carte_role = 44.9;
largeur_carte_role = 34.8;
nb_carte_role = 6;
longueur_pion = 29.7;
largeur_pion = 16.8;
nb_pion = 6;
longueur_carte_fleche = 24.9;
largeur_carte_fleche = 15.8;
nb_carte_fleche = 6;
longueur_carte_action = 31.7;
largeur_carte_action = 31.7;
nb_carte_action = 4;
longueur_compte_rebour = 140;
largeur_compte_rebour = 60;
longueur_dice = 17.5;
diametre_jeton = 22;
nb_jetons = 6;
epaisseur_carte = 2.4;
espace = 5;
marge = 0.5;
detail = 100;


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

module bloc_pieces(longueur, largeur, hauteur, epaisseur){
	difference(){
		cube([longueur+2*epaisseur, largeur+2*epaisseur, hauteur], center=true);
		cube([longueur, largeur, 2*hauteur], center=true);
	}
}

module cylindre_carte(diametre_carte, hauteur_bloc, epaisseur){
	difference(){
		cylinder(h=hauteur_bloc, r=diametre_carte/2+epaisseur, $fn=detail, center=true);
		cylinder(h=2*hauteur_bloc, r=diametre_carte/2, $fn=detail, center=true);
		rectangle_decoupe(diametre_carte+3*epaisseur, (diametre_carte+2*epaisseur)/2, 4*hauteur_bloc);
		rotate([0,0,90]) rectangle_decoupe(diametre_carte+3*epaisseur, (diametre_carte+2*epaisseur)/2, 4*hauteur_bloc);
	}
}

module bloc_compte_rebour(longueur_carte, largeur_carte, hauteur_bloc, hauteur_support, epaisseur){
	difference(){
		bloc_carte(longueur_carte-4*epaisseur, largeur_carte-4*epaisseur, hauteur_bloc+hauteur_support, 3*epaisseur);
		translate([0,0, hauteur_support/2]) cube([longueur_carte,largeur_carte,hauteur_bloc], center=true);
	}
}

module triangle_decoupe(longueur, largeur, hauteur){
	translate([-largeur/2,0,hauteur/2]) rotate([-90,0,0]) linear_extrude(height=longueur, center=true) polygon(points=[[0,0],[largeur,0],[largeur/2,5*hauteur/4]], paths=[[0,1,2]]);
}

module rectangle_decoupe(longueur, largeur, hauteur){
	cube([largeur, longueur, hauteur], center = true);
}

module rangement1(){
	hauteur_bloc = nb_tuiles*epaisseur_carte;
	union(){
		translate([0,0,-epaisseur/2]) plateau(longueur_boite, largeur_boite_1, epaisseur);
		translate([(longueur_tuile+2*marge+2*epaisseur)/2+((longueur_boite/2)-(longueur_tuile+2*marge+2*epaisseur))/2,0,hauteur_bloc/2]) bloc_carte(longueur_tuile+2*marge, largeur_tuile+2*marge, hauteur_bloc, epaisseur);
		translate([-(longueur_tuile+2*marge+2*epaisseur)/2-((longueur_boite/2)-(longueur_tuile+2*marge+2*epaisseur))/2,0,hauteur_bloc/2]) bloc_carte(longueur_tuile+2*marge, largeur_tuile+2*marge, hauteur_bloc, epaisseur);
	}
}

module rangement2(){
	hauteur_support_bloc_compte_rebour = (nb_carte_role+1)*epaisseur_carte;
	hauteur_bloc_carte_role = nb_carte_role*epaisseur_carte;
	longueur_bloc_figurines = (longueur_compte_rebour-2*epaisseur)-(longueur_carte_role+2*epaisseur)-2*espace;
	largeur_bloc_figurines = (largeur_compte_rebour-2*epaisseur)-2*espace;
	largeur_bloc_carte_action = nb_carte_action*epaisseur_carte+2*marge;
	espace_carte_action = (longueur_boite-6*(largeur_bloc_carte_action+2*epaisseur))/7;
	hauteur_bloc_jetons = nb_jetons*epaisseur_carte;
	hauteur_bloc_pion = nb_pion*epaisseur_carte;
	
	position_compte_rebour_y = espace+(largeur_compte_rebour+3*epaisseur-(largeur_boite_2+epaisseur))/2;
	position_carte_role_x = espace+((longueur_carte_role+epaisseur)-(longueur_compte_rebour+3*epaisseur))/2;
	position_carte_role_y = position_compte_rebour_y;
	position_bloc_figurines_x = (longueur_compte_rebour+3*epaisseur)/2 - espace-(longueur_carte_role+epaisseur);
	position_bloc_figurines_y = position_carte_role_y;

	position_carte_action1_x = espace_carte_action+(largeur_bloc_carte_action+2*epaisseur)/2-longueur_boite/2;
	position_carte_action2_x = position_carte_action1_x+espace_carte_action+(largeur_bloc_carte_action+2*epaisseur);
	position_carte_action3_x = position_carte_action2_x+espace_carte_action+(largeur_bloc_carte_action+2*epaisseur);
	position_carte_action4_x = position_carte_action3_x+espace_carte_action+(largeur_bloc_carte_action+2*epaisseur);
	position_carte_action5_x = position_carte_action4_x+espace_carte_action+(largeur_bloc_carte_action+2*epaisseur);
	position_carte_action6_x = position_carte_action5_x+espace_carte_action+(largeur_bloc_carte_action+2*epaisseur);
	position_carte_action_y = largeur_boite_2/2-espace-(longueur_carte_action+2*epaisseur)/2;

	espace_ligne_2 = (longueur_boite-(diametre_jeton+2*epaisseur+2*marge)-(longueur_pion+2*epaisseur+2*marge)-(largeur_carte_fleche+2*epaisseur+2*marge)-(longueur_dice+2*epaisseur+2*marge))/5;
	position_jeton_x = espace_ligne_2+(diametre_jeton+2*epaisseur)/2-longueur_boite/2;
	position_jeton_y = position_carte_action_y-(longueur_carte_action+2*epaisseur)/2-(diametre_jeton+2*epaisseur)/2-espace;
	position_pion_x = position_jeton_x+(diametre_jeton+2*epaisseur+2*marge)/2+(longueur_pion+2*epaisseur+2*marge)/2+espace_ligne_2;
	position_pion_y = position_jeton_y;
	position_carte_fleche_x = position_pion_x+(largeur_pion+2*epaisseur+2*marge)/2+(largeur_carte_fleche+2*epaisseur+2*marge)/2+espace_ligne_2;
	position_carte_fleche_y = position_jeton_y;
	position_dice_x = position_carte_fleche_x+(largeur_carte_fleche+2*epaisseur+2*marge)/2+(longueur_dice+2*epaisseur+2*marge)/2+espace_ligne_2;
	position_dice_y = position_jeton_y;
	
	union(){
		translate([0,0,-epaisseur/2]) plateau(longueur_boite, largeur_boite_2, epaisseur);
		translate([0,position_compte_rebour_y,(nb_carte_role+4)*epaisseur_carte/2]) color("blue") bloc_compte_rebour(longueur_compte_rebour+2*marge, largeur_compte_rebour+2*marge, 3*epaisseur_carte, hauteur_support_bloc_compte_rebour, epaisseur);
		translate([position_carte_role_x,position_carte_role_y,hauteur_bloc_carte_role/2]) rotate([0,0,90]) color("green") bloc_carte(longueur_carte_role+2*marge, largeur_carte_role+2*marge, hauteur_bloc_carte_role, epaisseur);
		translate([position_bloc_figurines_x,position_bloc_figurines_y,hauteur_bloc_carte_role/2]) bloc_pieces(longueur_bloc_figurines, largeur_bloc_figurines, hauteur_bloc_carte_role, epaisseur);

		// Cartes action
		translate([position_carte_action1_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		translate([position_carte_action2_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		translate([position_carte_action3_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		translate([position_carte_action4_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		translate([position_carte_action5_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		translate([position_carte_action6_x, position_carte_action_y, largeur_carte_action/2]) rotate([0,0,90]) color("red") bloc_carte(longueur_carte_action+2*marge, largeur_bloc_carte_action, largeur_carte_action, epaisseur);
		
		// Jeton
		translate([position_jeton_x,position_jeton_y,hauteur_bloc_jetons/2])cylindre_carte(diametre_jeton+2*marge, hauteur_bloc_jetons, epaisseur);
		
		// Cartes pions
		translate([position_pion_x,position_pion_y,hauteur_bloc_pion/2]) bloc_carte(longueur_pion+2*marge, largeur_pion+2*marge, hauteur_bloc_pion, epaisseur);
		
		// Cartes fleches
		translate([position_carte_fleche_x,position_carte_fleche_y,nb_carte_fleche*epaisseur_carte/2]) bloc_carte(longueur_carte_fleche+2*marge, largeur_carte_fleche+2*marge, nb_carte_fleche*epaisseur_carte, epaisseur);
		
		// Dé
		translate([position_dice_x,position_dice_y,longueur_dice/2]) bloc_carte(longueur_dice+2*marge, longueur_dice+2*marge, longueur_dice, epaisseur);
		
	}
}

rangement1();


		