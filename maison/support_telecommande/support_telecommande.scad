largeur_telecommande = 30;
epaisseur_telecommande = 10;
hauteur_support = 40;
hauteur_totale_support = 60;
epaisseur_support = 4;
detail = 10;
epaisseur_minkowski = 2;

module cube_base_rounded(){
	supp = 2*(epaisseur_support-epaisseur_minkowski);
	translate([0,-epaisseur_minkowski/2,0]) 
	minkowski (){
		cube([largeur_telecommande+supp, epaisseur_telecommande+supp+epaisseur_minkowski, hauteur_totale_support], center = true);
		sphere (epaisseur_minkowski, $fn=detail);
	}
}

module step1(){
	supp = 2*epaisseur_support+1;
	difference(){
		cube_base_rounded();
		translate([0,epaisseur_minkowski/2-epaisseur_telecommande,0]) cube([largeur_telecommande+supp, epaisseur_minkowski, hauteur_totale_support+supp], center = true);
		translate([0,epaisseur_minkowski/2,hauteur_support]) cube([largeur_telecommande+supp, epaisseur_telecommande+epaisseur_minkowski+epaisseur_support, hauteur_totale_support], center = true);
	}
}

module support_rounded(){
	difference(){
		cube_base_rounded();
		translate([0,0,hauteur_support]) cube([largeur_telecommande, epaisseur_telecommande, hauteur_totale_support], center = true);

	}
}

step1();

