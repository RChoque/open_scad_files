longueur_carte = 114;
largeur_carte = 64;
epaisseur_carte = 0.5;
nb_cartes = 94;
hauteur_cartes = epaisseur_carte*nb_cartes;
epaisseur = 1.5;
marge = 0.5;
manifold = 0.01;

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

module bloc_verrou(longueur_carte, largeur_carte, epaisseur){
	translate([0,-largeur_carte/2-epaisseur+marge,0]) verrou(epaisseur);
	translate([0,largeur_carte/2+epaisseur-marge,0]) rotate([0,0,180])verrou(epaisseur);
}

module verrou(epaisseur){
	translate([0,0, 2*epaisseur]) sphere(r = epaisseur);
	translate([0,epaisseur/2, 3*epaisseur/2])cube([2*epaisseur, epaisseur, 3*epaisseur], center=true);
}

module base(){
	cube([longueur_carte+4*marge+4*epaisseur, largeur_carte+4*marge+4*epaisseur, epaisseur], center=true);
	translate([0,0,(hauteur_cartes+epaisseur)/2])bloc_carte(longueur_carte+2*marge, largeur_carte+2*marge, hauteur_cartes, epaisseur);	
	bloc_verrou(longueur_carte+2*marge, largeur_carte+2*marge, epaisseur);
}

module base_negative(){
	cube([longueur_carte+4*marge+4*epaisseur, largeur_carte+4*marge+4*epaisseur, epaisseur], center=true);
	translate([0,0,(hauteur_cartes+epaisseur)/2])bloc_carte(longueur_carte+marge, largeur_carte+marge, hauteur_cartes, epaisseur+2*marge);	
	bloc_verrou(longueur_carte+2*marge, largeur_carte+2*marge, epaisseur+marge);
}

module couvercle(){
	difference(){
		cube([longueur_carte+4*marge+4*epaisseur, largeur_carte+4*marge+4*epaisseur, hauteur_cartes+epaisseur+marge], center=true);
		translate([0,0,epaisseur/2]) cube([longueur_carte+2*marge, largeur_carte+2*marge, hauteur_cartes+manifold+marge], center=true);
		translate([0,0,hauteur_cartes/2+epaisseur]) rotate([180,0,0]) color("green") base_negative();
	}
}

module couvercle_with_logo(){
	difference(){
		couvercle();
		translate([-45,25,-hauteur_cartes/2-epaisseur+0.6]) color("black") logo();
	}
}

module logo(){
	rotate([180, 0, 0]) linear_extrude(height=0.7) scale([0.6, 0.6]) import("shinobi.dxf");
}

translate([0,0,hauteur_cartes/2]) rotate([0, 180, 0]) translate([0,-largeur_carte,0]) color("blue") base();
//translate([0,+largeur_carte,0]) couvercle();
translate([0,+largeur_carte,0]) couvercle_with_logo();
