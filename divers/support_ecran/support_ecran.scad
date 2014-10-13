largeur_socle = 30.7;
longueur_socle = 86.7;
hauteur_socle = 100.3;
epaisseur_socle = 3;
largeur_fixation = 27.9;
longueur_fixation = 84.5;
hauteur_fixation = 17.8;
profondeur_fixation = 11;
epaisseur_fixation = 2;
cran_longueur_1 = 9.9;
espace_1_2 = 3;
cran_longueur_2 = 7.15;
espace_2_3 = 3;
cran_longueur_3 = 39;
espace_3_4 = 3;
cran_longueur_4 = 7.15;
espace_4_5 = 3;
cran_longueur_5 = 9.9;
cran_largeur_1 = 6.3;
espace_largeur_1_2 = 3.13;
cran_largeur_2 = 3.8;
espace_largeur_2_3 = 3.13;
cran_largeur_3 = 11.8;
longueur_encoche = 8.2;
hauteur_encoche = 5.6;
espace_encoche_x = 3.25;
espace_encoche_y = 5.5;
longueur_cran = 10;
radius = 3;
marge = 0.5;
longueur_max_tige = 71.1;
longueur_min_tige = 58;
largeur_max_tige = 12.8;
largeur_min_tige = 6;



module socle_etape1(longueur, largeur, hauteur, radius){
	difference(){
		minkowski(){
			cube([longueur-2*radius, largeur-2*radius, hauteur], center = true);
			sphere (radius, $fn=detail);
		}
		translate([0,0,(hauteur+radius)/2]) cube([longueur, largeur, radius], center = true);
		translate([0,0,-(hauteur+radius)/2]) cube([longueur, largeur, radius], center = true);
	}
}

module socle_etape2(longueur, largeur, hauteur, radius, epaisseur){
	difference(){
		socle_etape1(longueur, largeur, hauteur, radius);
		socle_etape1(longueur-2*epaisseur, largeur-2*epaisseur, hauteur+1, radius);
	}
}

module fixation_bas(){
	position_creux_y = -(hauteur_fixation-profondeur_fixation)/2;
	position_espace_1_x = -longueur_fixation/2+cran_longueur_1+espace_1_2/2;
	position_espace_2_x = position_espace_1_x+espace_1_2/2+cran_longueur_2+espace_2_3/2;
	position_espace_3_x = position_espace_2_x+espace_2_3/2+cran_longueur_3+espace_3_4/2;
	position_espace_4_x = position_espace_3_x+espace_3_4/2+cran_longueur_4+espace_4_5/2;
	
	position_espace_1_y = -largeur_fixation/2+cran_largeur_1+espace_largeur_1_2/2;
	position_espace_2_y = position_espace_1_y+espace_largeur_1_2/2+cran_largeur_2+espace_largeur_2_3/2;

	position_encoche_1_x = position_espace_2_x+espace_2_3/2+espace_encoche_x+longueur_encoche/2;
	position_encoche_2_x = position_espace_3_x-espace_3_4/2-espace_encoche_x-longueur_encoche/2;
	position_encoche_y = -(hauteur_fixation/2-hauteur_encoche/2-espace_encoche_y);

	difference(){
		socle_etape2(longueur_fixation, largeur_fixation, hauteur_fixation, radius, epaisseur_fixation);
		translate([position_espace_1_x,largeur_fixation/2,position_creux_y]) cube([espace_1_2,10,profondeur_fixation], center = true);
		translate([position_espace_2_x,largeur_fixation/2,position_creux_y]) cube([espace_2_3,10,profondeur_fixation], center = true);
		translate([position_espace_3_x,largeur_fixation/2,position_creux_y]) cube([espace_3_4,10,profondeur_fixation], center = true);
		translate([position_espace_4_x,largeur_fixation/2,position_creux_y]) cube([espace_4_5,10,profondeur_fixation], center = true);

		translate([longueur_fixation/2,position_espace_1_y,position_creux_y]) cube([10,espace_largeur_1_2,profondeur_fixation], center = true);
		translate([longueur_fixation/2,position_espace_2_y,position_creux_y]) cube([10,espace_largeur_2_3,profondeur_fixation], center = true);

		translate([position_espace_1_x,-largeur_fixation/2,position_creux_y]) cube([espace_1_2,10,profondeur_fixation], center = true);
		translate([position_espace_2_x,-largeur_fixation/2,position_creux_y]) cube([espace_2_3,10,profondeur_fixation], center = true);
		translate([position_espace_3_x,-largeur_fixation/2,position_creux_y]) cube([espace_3_4,10,profondeur_fixation], center = true);
		translate([position_espace_4_x,-largeur_fixation/2,position_creux_y]) cube([espace_4_5,10,profondeur_fixation], center = true);

		translate([-longueur_fixation/2,position_espace_1_y,position_creux_y]) cube([10,espace_largeur_1_2,profondeur_fixation], center = true);
		translate([-longueur_fixation/2,position_espace_2_y,position_creux_y]) cube([10,espace_largeur_2_3,profondeur_fixation], center = true);

		translate([position_encoche_1_x, -largeur_fixation/2,position_encoche_y]) cube([longueur_encoche,10,hauteur_encoche], center = true);
		translate([position_encoche_2_x, -largeur_fixation/2,position_encoche_y]) cube([longueur_encoche,10,hauteur_encoche], center = true);

		translate([position_encoche_1_x, largeur_fixation/2,position_encoche_y]) cube([longueur_encoche,10,hauteur_encoche], center = true);
		translate([position_encoche_2_x, largeur_fixation/2,position_encoche_y]) cube([longueur_encoche,10,hauteur_encoche], center = true);
	}
		
}

module fixation_haut(){
	position_creux_z = hauteur_fixation-profondeur_fixation/2;
	position_espace_1_x = -longueur_fixation/2+cran_longueur_1+espace_1_2/2;
	position_espace_2_x = position_espace_1_x+espace_1_2/2+cran_longueur_2+espace_2_3/2;
	position_espace_3_x = position_espace_2_x+espace_2_3/2+cran_longueur_3+espace_3_4/2;
	position_espace_4_x = position_espace_3_x+espace_3_4/2+cran_longueur_4+espace_4_5/2;
	position_espace_1_y = -largeur_fixation/2+cran_largeur_1+espace_largeur_1_2/2;
	position_espace_2_y = position_espace_1_y+espace_largeur_1_2/2+cran_largeur_2+espace_largeur_2_3/2;
	
	difference(){
		socle_etape1(longueur_socle-2*epaisseur_socle, largeur_socle-2*epaisseur_socle, 12, radius);
		translate([0,0,-(largeur_socle-2*epaisseur_socle)/2]) rotate([45,0,0]) cube([longueur_socle-2*epaisseur_socle, largeur_socle-2*epaisseur_socle, largeur_socle-2*epaisseur_socle], center = true);
	}

	translate([position_espace_1_x,(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_1_2-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_2_x,(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_2_3-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_3_x,(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_3_4-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_4_x,(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_4_5-2*marge,longueur_cran,profondeur_fixation-marge], center = true);

	translate([position_espace_1_x,-(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_1_2-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_2_x,-(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_2_3-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_3_x,-(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_3_4-2*marge,longueur_cran,profondeur_fixation-marge], center = true);
	translate([position_espace_4_x,-(largeur_socle-2*epaisseur_socle-longueur_cran)/2,position_creux_z]) cube([espace_4_5-2*marge,longueur_cran,profondeur_fixation-marge], center = true);

	translate([(longueur_socle-2*epaisseur_socle-longueur_cran)/2,position_espace_1_y,position_creux_z]) cube([longueur_cran,espace_largeur_1_2-2*marge,profondeur_fixation-marge], center = true);
	translate([(longueur_socle-2*epaisseur_socle-longueur_cran)/2,position_espace_2_y,position_creux_z]) cube([longueur_cran,espace_largeur_2_3-2*marge,profondeur_fixation-marge], center = true);

	translate([-(longueur_socle-2*epaisseur_socle-longueur_cran)/2,position_espace_1_y,position_creux_z]) cube([longueur_cran,espace_largeur_1_2-2*marge,profondeur_fixation-marge], center = true);
	translate([-(longueur_socle-2*epaisseur_socle-longueur_cran)/2,position_espace_2_y,position_creux_z]) cube([longueur_cran,espace_largeur_2_3-2*marge,profondeur_fixation-marge], center = true);

	rotate([0,0,180]) translate([0,0,hauteur_fixation-profondeur_fixation]) tige();
}

module tige(){
	translate([0,0,(30.8+hauteur_fixation-2*radius)/2])
	difference(){
		minkowski(){
			linear_extrude(height=(30.8+hauteur_fixation-2*radius), center=true, convexity = 10, twist = 0, scale=[1.05,1.43]) 
			polygon(points=[
				[(longueur_max_tige/2-radius),(largeur_min_tige-radius)],
				[-(longueur_max_tige/2-radius),(largeur_min_tige-radius)],
				[-(longueur_max_tige/2-radius),0],
				[-(longueur_min_tige/2-radius),-(largeur_max_tige-largeur_min_tige-radius)],
				[(longueur_min_tige/2-radius),-(largeur_max_tige-largeur_min_tige-radius)],
				[(longueur_max_tige/2-radius),0]
				], paths=[[0,1,2,3,4,5]]);
			sphere (radius, $fn=detail);
		}
		translate([0,0,(30.8+hauteur_fixation-radius)/2]) cube([longueur_max_tige, 2*largeur_max_tige, radius], center = true);
		translate([0,0,-(30.8+hauteur_fixation-radius)/2]) cube([longueur_max_tige, 2*largeur_max_tige, radius], center = true);
	}				
}

module support_complet(){
	difference(){
		socle_etape2(longueur_socle, largeur_socle, hauteur_socle, radius, epaisseur_socle);
		translate([0,0,hauteur_socle/2-hauteur_fixation/2])color("red") fixation_bas();
	}
	translate([0,0,-(hauteur_socle+hauteur_fixation)/2]) fixation_bas();	
	translate([0,0,hauteur_socle/2-6-hauteur_fixation]) fixation_haut();
	//translate([0,10,hauteur_socle/2-hauteur_fixation/2])color("red") fixation_bas();	
	
	
}

support_complet();