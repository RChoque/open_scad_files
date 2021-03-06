largeur_telecommande_tv = 48.5;
epaisseur_telecommande_tv = 24;
largeur_telecommande_freebox = 38.8;
epaisseur_telecommande_freebox = 17.5;
largeur_telecommande_ampli = 50;
epaisseur_telecommande_ampli = 18.8;
hauteur_support = 40;
hauteur_totale_support = 60;
epaisseur_support = 2;
detail = 10;
epaisseur_minkowski = 2;
grand_rayon_vis = 4;
petit_rayon_vis = 1.5;

module cube_rounded(longueur, largeur, hauteur){
	minkowski (){
		cube([longueur, largeur, hauteur], center = true);
		sphere (epaisseur_minkowski, $fn=detail);
	}
}

module vis(){
	cylinder (r1=petit_rayon_vis, r2=petit_rayon_vis, h=10, $fn=100);
	cylinder (r1=grand_rayon_vis, r2=petit_rayon_vis, h=3, $fn=100);
}

module ovale(hauteur, largeur){
	cube([largeur, 2*epaisseur_support, hauteur-largeur], center=true);
	translate([0,epaisseur_support,(hauteur-largeur)/2]) rotate([90,0,0]) cylinder(r=largeur/2, h=2*epaisseur_support, $fn=100);
	translate([0,epaisseur_support,-(hauteur-largeur)/2]) rotate([90,0,0]) cylinder(r=largeur/2, h=2*epaisseur_support, $fn=100);
}

module rainure(hauteur, largeur){
	difference() {
		cube([2*largeur, 2*epaisseur_support-0.1, hauteur-largeur], center = true);
		translate([largeur, 0, -largeur/2]) ovale(hauteur, largeur);
		translate([-largeur, 0, -largeur/2]) ovale(hauteur, largeur);
	}
	translate([0, 0, -largeur/2]) ovale(hauteur, largeur);
}

module step1(largeur_telecommande, epaisseur_telecommande){
	supp = 2*epaisseur_support;
	em = epaisseur_minkowski;
	difference(){
		cube_rounded(largeur_telecommande+supp, epaisseur_telecommande+supp, hauteur_totale_support);
		translate([0,-(em/2+epaisseur_telecommande/2+epaisseur_support),0]) 
			cube([largeur_telecommande+supp+2*em, em, hauteur_totale_support+supp], center = true);
		translate([0,(epaisseur_support+em)/2,hauteur_support]) 
			cube([largeur_telecommande+supp+2*em+1, epaisseur_telecommande+em+epaisseur_support, hauteur_totale_support], center = true);
	}
}

module step2(largeur_telecommande, epaisseur_telecommande){
	em = epaisseur_minkowski;
	difference(){
		step1(largeur_telecommande, epaisseur_telecommande);
		translate([0,0,epaisseur_support])
		difference(){
			cube_rounded(largeur_telecommande, epaisseur_telecommande, hauteur_totale_support);
			translate([0,-(epaisseur_telecommande+em)/2,0])
			cube([largeur_telecommande+2*em, em, hauteur_totale_support+2*em], center = true);
		}
	}
	
}

module step3(largeur_telecommande, epaisseur_telecommande){
	hauteur_rainure = grand_rayon_vis-hauteur_support/4+(hauteur_totale_support/2-(hauteur_totale_support-hauteur_support));
	hauteur_vis_1 = hauteur_totale_support/2 - (hauteur_totale_support-hauteur_support)/2;
	hauteur_vis_2 = hauteur_rainure+2*grand_rayon_vis-hauteur_support/2;
	difference(){
		step2(largeur_telecommande, epaisseur_telecommande);
		translate([0,-epaisseur_telecommande/2+0.01, hauteur_vis_1]) rotate([90,0,0]) color("red") vis();
		translate([0,-epaisseur_telecommande/2+0.01, hauteur_vis_2]) rotate([90,0,0]) color("red") vis();
		translate([0,epaisseur_telecommande/2+epaisseur_support,hauteur_rainure]) rainure(hauteur_support/2, 2*grand_rayon_vis);
	}
}

module telecommande_freebox(){
	largeur_telecommande = largeur_telecommande_freebox;
	epaisseur_telecommande = epaisseur_telecommande_freebox;
	step3(largeur_telecommande, epaisseur_telecommande);
}

module telecommande_ampli(){
	largeur_telecommande = largeur_telecommande_ampli;
	epaisseur_telecommande = epaisseur_telecommande_ampli;
	step3(largeur_telecommande, epaisseur_telecommande);
}

module telecommande_tv(){
	largeur_telecommande = largeur_telecommande_tv;
	epaisseur_telecommande = epaisseur_telecommande_tv;
	step3(largeur_telecommande, epaisseur_telecommande);
}

module telecommande_groupees(){
	position_x_freebox = 0;
	position_y_freebox = epaisseur_telecommande_freebox/2;
	position_x_ampli = largeur_telecommande_freebox/2+largeur_telecommande_ampli/2+epaisseur_support+2*epaisseur_minkowski;
	position_y_ampli = epaisseur_telecommande_ampli/2;
	position_x_tv = position_x_ampli+largeur_telecommande_ampli/2+largeur_telecommande_tv/2+epaisseur_support+2*epaisseur_minkowski;
	position_y_tv = epaisseur_telecommande_tv/2;
	longueur_totale = largeur_telecommande_freebox+largeur_telecommande_ampli+largeur_telecommande_tv+6*epaisseur_minkowski+4*epaisseur_support;
	difference(){
		union(){
			translate([position_x_freebox,position_y_freebox,0]) color("red") telecommande_freebox();
			translate([position_x_ampli,position_y_ampli,0]) color("green") telecommande_ampli();
			translate([position_x_tv,position_y_tv,0]) color("blue") telecommande_tv();
		}
		translate([-(largeur_telecommande_freebox/2+epaisseur_support+epaisseur_minkowski),-epaisseur_support,hauteur_totale_support/2-(hauteur_totale_support-hauteur_support)]) cube([longueur_totale+1, 2*epaisseur_support, hauteur_totale_support-hauteur_support+epaisseur_minkowski]);
	}

}

//telecommande_groupees();
//telecommande_freebox();
//telecommande_ampli();
telecommande_tv();


