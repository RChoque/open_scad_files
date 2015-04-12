longueur_socle = 52.7;
longueur_avec_accroche = 54.1;
largeur_socle = 42.7;
epaisseur_socle = 6;

diametre_frein = 7.2;
longueur_frein = 5;
ecart_freins = 28;
nb_rainures = 20;
depassement_z_frein = 3.2;

diametre_accroche = 7.2;
diametre_interne_accroche = 4.2;
depassement_z_accroche = 1.4;
espace_accroche_bas = 12;
hauteur_accroche = 2.6;
profondeur_accroche = 2;

hauteur_apn = 63.5;
epaisseur_apn = 21.5;
detail = 25;
profondeur_vis = 6;

largeur_crochet = 16;

module fixation(){
	position_z_accroche = (diametre_accroche/2) - (epaisseur_socle/2) - depassement_z_accroche;
	position_z_frein = (diametre_frein/2) - (epaisseur_socle/2) - depassement_z_frein;
	difference(){
		cube([longueur_socle,largeur_socle,epaisseur_socle],center= true);
		translate([(longueur_avec_accroche-hauteur_accroche)/2,espace_accroche_bas-largeur_socle/2,position_z_accroche])
		rotate([0,90,0]) 
			cylinder (r=diametre_accroche/2, h=hauteur_accroche, $fn=detail, center=true);
		translate([-(longueur_avec_accroche-hauteur_accroche)/2,espace_accroche_bas-largeur_socle/2,position_z_accroche])
		rotate([0,-90,0]) 
			cylinder (r=diametre_accroche/2, h=hauteur_accroche, $fn=detail, center=true);
	translate([largeur_crochet/2,0,0])
		linear_extrude(height=longueur_socle, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[(longueur_socle-largeur_crochet)/2,0],
					[0,largeur_socle/2],
					[(longueur_socle-largeur_crochet)/2,largeur_socle/2],
					], paths=[[0,1,2]]);
		translate([-largeur_crochet/2,0,0])
		linear_extrude(height=longueur_socle, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[-(longueur_socle-largeur_crochet)/2,0],
					[0,largeur_socle/2],
					[-(longueur_socle-largeur_crochet)/2,largeur_socle/2],
					], paths=[[0,1,2]]);
		translate([0,-largeur_socle/2,-0.1])
		rotate([0,90,0]) color("pink")
		linear_extrude(height=longueur_socle+2, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[0,0],
					[3,0],
					[3,3],
					], paths=[[0,1,2]]);

	}

	
	translate([(longueur_avec_accroche-hauteur_accroche)/2,espace_accroche_bas-largeur_socle/2,position_z_accroche])
		rotate([0,90,0]) accroche();
	translate([-(longueur_avec_accroche-hauteur_accroche)/2,espace_accroche_bas-largeur_socle/2,position_z_accroche])
		rotate([0,-90,0]) accroche();

	translate([(longueur_frein+ecart_freins)/2,espace_accroche_bas-largeur_socle/2,position_z_frein])
		rotate([0,90,0]) frein();
	translate([-(longueur_frein+ecart_freins)/2,espace_accroche_bas-largeur_socle/2,position_z_frein])
		rotate([0,90,0]) frein();

	translate([0,-largeur_socle/2,epaisseur_socle/2])
	plaque_vissage();

	translate([0,hauteur_apn/2-0.1,0])
		crochet_apn();
	//translate([largeur_crochet/2,largeur_socle/2,0])
	//	boucle();
	//translate([-largeur_crochet/2,largeur_socle/2,0])
	//	boucle();
}

module plaque_vissage(){
	difference(){
		union(){
			translate([0,epaisseur_socle/6,epaisseur_apn/2]) color("red")
				cube([longueur_socle, epaisseur_socle/3, epaisseur_apn], center = true);
			translate([0,0,epaisseur_apn]) 
			rotate([0,90,0])
			linear_extrude(height=longueur_socle, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[0,0],
					[0,-3],
					[epaisseur_apn/2,0],
					], paths=[[0,1,2]]);
		}
		translate([0,0,13])
		rotate([90,0,0]) cylinder (r=4, h=epaisseur_socle, $fn=detail, center=true);
			translate([0,0,13+epaisseur_apn/2])	
				cube([8,8,epaisseur_apn], center=true);
		
		translate([0,-7,epaisseur_socle+6]) rotate([-90,0,0]) 
		vis();
	}
}

module accroche(){
	difference(){
		cylinder (r=diametre_accroche/2, h=hauteur_accroche, $fn=detail, center=true);
		translate([0,0,hauteur_accroche-profondeur_accroche]) cylinder (r=diametre_interne_accroche/2, h=hauteur_accroche, $fn=detail, center=true);
	}
}

module frein(){
	angle = 360/nb_rainures;
	difference(){
		cylinder (r=diametre_frein/2, h=longueur_frein, $fn=detail, center=true);
		for (i=[0:nb_rainures-1]){
			rotate([0,0,angle*i]) translate([diametre_frein/2, 0, 0]) color("blue") cylinder(r=1/2, h=longueur_frein, $fn=detail, center=true);
		}
	}
}

module crochet_apn(){
	cube([largeur_crochet,hauteur_apn-largeur_socle,epaisseur_socle], center=true);
	translate([0,(hauteur_apn-largeur_socle+epaisseur_socle/3)/2,epaisseur_apn/2+epaisseur_socle/6]) color("green")
	cube([largeur_crochet,epaisseur_socle/3,epaisseur_apn+4*epaisseur_socle/3], center=true);
	translate([0,(hauteur_apn-largeur_socle)/2 - 5,epaisseur_apn+2*epaisseur_socle/3]) 
	cube([largeur_crochet,10,epaisseur_socle/3], center=true);
	rayon = (epaisseur_apn+4*epaisseur_socle/3)/2;
	translate([0,(hauteur_apn-largeur_socle+epaisseur_socle/3)/2,epaisseur_apn/2+epaisseur_socle/6]) 
	rotate([0,90,0])
	scale([1,0.5,1]) 
	difference(){
		cylinder(r=rayon, h=epaisseur_socle, $fn=detail, center=true);
		cylinder(r=rayon-4, h=epaisseur_socle, $fn=detail, center=true);
		translate([0,-rayon,0])
		cube([2*rayon,2*rayon,epaisseur_socle], center=true);
	}
}

module boucle(){
	rayon = (longueur_socle - largeur_crochet)/2;
	difference(){
		cylinder(r=rayon, h=epaisseur_socle, $fn=detail, center=true);
		cylinder(r=rayon-3, h=epaisseur_socle, $fn=detail, center=true);
	}
}

module vis(){
	translate([0,0,3-1.1])
	difference(){
		import("CAM_screw.STL");
		translate([-10,-10,0]) cube([20,20,14-profondeur_vis-epaisseur_socle/3]);
	}
	translate([0,0,14-0.6-profondeur_vis-epaisseur_socle/3]) 
	cylinder(r1=5.55, r2=2, h=3, $fn=detail);
	difference(){
		import("CAM_screw.STL");
		translate([-10,-10,14-profondeur_vis-epaisseur_socle/3]) cube([20,20,profondeur_vis+epaisseur_socle/3]);
	}
}

fixation();

