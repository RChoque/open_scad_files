largeur_nexus7 = 128;
epaisseur_nexus7 = 18;
hauteur_support = 85;
hauteur_prise = 18;
largeur_prise = 10.5;
epaisseur_prise = 6.5;
hauteur_cordon = 5;
diametre_cordon = 5;

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

module prise(){
	translate([0,0,hauteur_prise/2+hauteur_cordon]) cube([largeur_prise,epaisseur_prise,hauteur_prise], center=true);
	translate([0,0,-hauteur_cordon/2]) cylinder (r=diametre_cordon/2, h=2*hauteur_cordon, $fn=100);
}

module step1(){
	angle = 45;
	hauteur_angle = (epaisseur_nexus7/2)/cos(angle);
	em = epaisseur_minkowski;
	supp = 2*(epaisseur_support-em);	
	translate([0,0,hauteur_support/2+epaisseur_support]) 
	difference(){
		cube_rounded(largeur_nexus7+supp, epaisseur_nexus7+supp, hauteur_support);
		translate([0,-(em/2+epaisseur_nexus7/2+epaisseur_support),0]) 
			cube([largeur_nexus7+supp+2*em, em, hauteur_support+supp], center = true);
		translate([0,0,(hauteur_angle+hauteur_support)/2])rotate([angle,0,0]) 
			cube([largeur_nexus7+supp+3*em, epaisseur_nexus7, hauteur_support+supp], center = true);
		translate([0,0,hauteur_prise+hauteur_cordon]) cube_rounded(largeur_nexus7-2*em, epaisseur_nexus7-2*em, hauteur_support);
	}
}

module step2(){
	difference(){
		step1();
		translate([0,(epaisseur_nexus7/2+epaisseur_support-epaisseur_minkowski), hauteur_cordon+hauteur_support/2+hauteur_prise]) cube([2*largeur_nexus7/3, 2*epaisseur_support, hauteur_support], center=true);
	translate([largeur_nexus7/3-grand_rayon_vis,(epaisseur_support-epaisseur_nexus7)/2,2*hauteur_support/3]) rotate([90,0,0]) vis();
	translate([-largeur_nexus7/3+grand_rayon_vis,(epaisseur_support-epaisseur_nexus7)/2,2*hauteur_support/3]) rotate([90,0,0]) vis();
	}

}

module step3(){
	difference(){
		step2();
		translate([0, 0, 0.1]) prise();
		translate([0, -epaisseur_prise, 0.1]) rotate([0,0,90]) prise();
		translate([0, -epaisseur_nexus7/2, 0.1+hauteur_cordon/2]) cube([diametre_cordon,epaisseur_nexus7,hauteur_cordon+0.2], center=true);
	}
}


step3();

