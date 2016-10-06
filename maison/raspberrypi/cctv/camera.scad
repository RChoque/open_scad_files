epaisseur = 1.5;
epaisseur_interne = 1;
diametre_vis = 1;
marge_support_haut = 5;
marge_support_bas = 5;
marge_support_droite = 5;
marge_support_gauche = 5;
hauteur_support = 5;
hauteur_carte = 25;
largeur_carte = 30;
profondeur_box = 10;
diametre_led = 5;
position_objectif_haut = 15; 
longueur_objectif=8;
largeur_objectif=8;
largeur_totale = largeur_carte+4*diametre_led+2*epaisseur_interne+2*epaisseur;
detail = 100;

module front(){
	difference(){
		cube([hauteur_carte+2*epaisseur, largeur_totale, profondeur_box], center = true);
		//carte
		translate([0,0,epaisseur]) cube([hauteur_carte, largeur_carte, profondeur_box], center = true);
		
		//led droite
		translate([0,(diametre_led+largeur_carte/2+epaisseur_interne),epaisseur+epaisseur_interne]) cube([hauteur_carte, 2*diametre_led, profondeur_box], center = true);
		translate([0,(diametre_led+largeur_carte/2+epaisseur_interne),epaisseur-diametre_led-profondeur_box/2]) reflector();
		
		//led gauche
		translate([0,-(diametre_led+largeur_carte/2+epaisseur_interne),epaisseur+epaisseur_interne]) cube([hauteur_carte, 2*diametre_led, profondeur_box], center = true);
		translate([0,-(diametre_led+largeur_carte/2+epaisseur_interne),epaisseur-diametre_led-profondeur_box/2]) reflector();

		//camera
		translate([(hauteur_carte+longueur_objectif)/2,0,0]) cube([longueur_ojectif,largeur_objectif, 15], center = true);
	}
	position_z_support = hauteur_support/2-profondeur_box/2+epaisseur;
	position_y1_support = largeur_carte/2-marge_support_droite;
	position_y2_support = -(largeur_carte/2-marge_support_gauche);
	translate([hauteur_carte/2-marge_support_haut,position_y1_support,position_z_support]) color("blue") support();
	translate([hauteur_carte/2-marge_support_haut,position_y2_support,position_z_support]) color("blue") support();
	translate([-(hauteur_carte/2-marge_support_bas),position_y1_support,position_z_support]) color("blue") support();
	translate([-(hauteur_carte/2-marge_support_bas),position_y2_support,position_z_support]) color("blue") support();
}

module reflector(){
	rotate([0,90,0]) 
	union(){
		cylinder (r=diametre_led, h=hauteur_carte-2*diametre_led, $fn=detail, center=true);
		translate([0,0,hauteur_carte/2-diametre_led]) sphere(diametre_led, $fn=detail, center = true);
		translate([0,0,-(hauteur_carte/2-diametre_led)]) sphere(diametre_led, $fn=detail, center = true);
	}
}

module support(){
	difference(){
		cylinder (r=diametre_vis/2+epaisseur_interne, h=hauteur_support, $fn=detail, center=true);
		cylinder (r=diametre_vis/2, h=hauteur_support, $fn=detail, center=true);
	}
}

module back(){

}

front();