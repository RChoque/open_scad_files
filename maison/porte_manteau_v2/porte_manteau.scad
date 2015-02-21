include <porte_manteau_crochet.scad>;
include <porte_manteau_bloc.scad>;
include <porte_manteau_tete.scad>;

marge = 0.5;

module vis(){
	cylinder (r1=1.5+marge, r2=1.5+marge, h=13, $fn=100);
	cylinder (r1=3.5+marge, r2=1.5+marge, h=2.5, $fn=100);
}

module bloc1_complet(){
	difference(){
		bloc1(marge);
		translate([-longueur_crochet, (largeur_crochet+marge)/2, -(epaisseur_bloc/2+base_basse+base_haute+epaisseur_crochet)-0.1]) rotate([90,0,0]) crochet(marge);
		translate([hauteur_crochet-(hauteur_bloc-largeur_crochet+marge-epaisseur_crochet)/2, 0, -epaisseur_bloc/2]) color("purple") vis();
		translate ([-hauteur_bloc/4,(longueur_bloc/2+longueur_bloc/6),-epaisseur_bloc/2-0.1]) color("purple") vis();
		translate ([hauteur_bloc/4,(longueur_bloc/2+longueur_bloc/6),-epaisseur_bloc/2-0.1]) color("purple") vis();
	}
	translate([0,0,epaisseur_bloc/2]) rotate([-90,0,90]) color("green") tete();
}

module bloc2_complet(){
	difference(){
		bloc2(marge);
		translate ([-hauteur_bloc/4,-(longueur_bloc/2-marge-longueur_bloc/6+marge),-epaisseur_bloc/2]) color("purple") vis();
		translate ([hauteur_bloc/4,-(longueur_bloc/2-marge-longueur_bloc/6+marge),-epaisseur_bloc/2]) color("purple") vis();
		translate ([-hauteur_bloc/4,(longueur_bloc/2+longueur_bloc/6),-epaisseur_bloc/2]) color("purple") vis();
		translate ([hauteur_bloc/4,(longueur_bloc/2+longueur_bloc/6),-epaisseur_bloc/2]) color("purple") vis();
	}
	translate([0,0,epaisseur_bloc/2]) rotate([-90,0,90]) color("green") tete();
}

module bloc3_complet(){
	difference(){
		bloc3(marge);
		translate([-longueur_crochet, (largeur_crochet+marge)/2, -(epaisseur_bloc/2+base_basse+base_haute+epaisseur_crochet)-0.1]) rotate([90,0,0]) crochet(marge);
		translate([hauteur_crochet-(hauteur_bloc-largeur_crochet+marge-epaisseur_crochet)/2, 0, -epaisseur_bloc/2]) color("purple") vis();
		translate ([-hauteur_bloc/4,-(longueur_bloc/2-marge-longueur_bloc/6+marge),-epaisseur_bloc/2]) color("purple") vis();
		translate ([hauteur_bloc/4,-(longueur_bloc/2-marge-longueur_bloc/6+marge),-epaisseur_bloc/2]) color("purple") vis();
	}
	translate([0,0,epaisseur_bloc/2]) rotate([-90,0,90]) color("green") tete();
}

module crochet_complet(){
	difference(){
		translate([-longueur_crochet, (largeur_crochet+marge)/2, -(base_basse+base_haute+epaisseur_crochet)]) rotate([90,0,0]) crochet(marge);
		translate([hauteur_crochet-(hauteur_bloc-largeur_crochet+marge-epaisseur_crochet)/2, 0, -0.1]) color("purple") vis();
	}
}

module crochet_plat_complet(){
	difference(){
		translate([-longueur_crochet, (largeur_crochet+marge)/2, -(base_basse+base_haute+epaisseur_crochet)]) rotate([90,0,0]) crochet_plat(marge);
		translate([2*hauteur_crochet-(hauteur_bloc-largeur_crochet+marge+epaisseur_crochet)/2, 0, -epaisseur_crochet-0.1]) color("purple") vis();
	}
}

module crochet_meuble_complet(){
	difference(){
		translate([-longueur_crochet, (largeur_crochet+marge)/2, -(base_basse+base_haute+epaisseur_crochet)]) rotate([90,0,0]) crochet_meuble(marge);
		translate([2*hauteur_crochet-(hauteur_bloc-largeur_crochet+marge+epaisseur_crochet)/2, 0, -epaisseur_crochet-0.1]) color("purple") vis();
		translate([-longueur_crochet-0.1, 0, -(epaisseur_crochet+base_basse/2)]) rotate([0,90,0]) color("purple") vis();
	}
}

color("yellow") bloc1_complet();
translate([0,longueur_bloc,0]) color("blue") bloc2_complet();
translate([0,2*longueur_bloc,0]) color("red") bloc2_complet();
translate([0,3*longueur_bloc,0]) color("green") bloc3_complet();
translate([0,0,-epaisseur_bloc/2]) color("grey") crochet_complet();
translate([0,3*longueur_bloc,-epaisseur_bloc/2]) color("grey") crochet_complet();




