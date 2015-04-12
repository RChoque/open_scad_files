epaisseur = 0.5;
longueur_col = 5;
largeur_col = 5;

module hollow_cube(x,y,z,epaisseur){
	difference(){
		cube([x,y,z], center=true);
		cube([x-2*epaisseur,y-2*epaisseur,z+epaisseur], center=true);
	}
}

module x(){
	hypotenuse = ceil(sqrt(pow((longueur_col-2*epaisseur),2) + pow((largeur_col-2*epaisseur),2)));
	angle = 45;
	translate([0,0,2.5]) rotate([0,0,angle]) cube([hypotenuse,epaisseur,5],center = true);
	translate([0,0,2.5]) rotate([0,0,-angle]) cube([hypotenuse,epaisseur,5],center = true);
}

module y(){
	hypotenuse = ceil(sqrt(pow((longueur_col-2*epaisseur),2) + pow((largeur_col-2*epaisseur),2)));
	angle = 45;
	translate([0,0,2.5]) rotate([0,0,angle]) cube([hypotenuse,epaisseur,5],center = true);
	rotate([0,0,3*angle]) cube([hypotenuse/2,epaisseur,5]);
}

module calibration_base(longueur,largeur,hauteur){
	union(){
		hollow_cube(longueur,largeur,hauteur,epaisseur);
		translate([-(longueur-longueur_col)/2, (largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
		translate([-(longueur-longueur_col)/2, -(largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
		translate([(longueur-longueur_col)/2, -(largeur-largeur_col)/2, 0]) hollow_cube(longueur_col,largeur_col,hauteur,epaisseur);
		translate([-(longueur-longueur_col)/2,(largeur-largeur_col)/2,-hauteur/2]) y();
		translate([(longueur-longueur_col)/2,-(largeur-largeur_col)/2,-hauteur/2]) x();
	}
}

module calibration_1(longueur,largeur,hauteur){
	translate([0,0,hauteur/2]) hollow_cube(longueur,largeur,hauteur,epaisseur);
	// hypotenuse = ceil(sqrt(pow((longueur-2*epaisseur),2) + pow((largeur-2*epaisseur),2)));
	// epaisseur_hypo = epaisseur;	
	// hauteur_diag = 5;

	// angleZ = atan(largeur/longueur);
	// union(){
	// 	translate([0,0,hauteur_diag/2]) rotate([0,0,angleZ]) cube([hypotenuse,epaisseur_hypo,hauteur_diag],center = true);
	// 	translate([0,0,hauteur_diag/2]) rotate([0,0,-angleZ]) cube([hypotenuse,epaisseur_hypo,hauteur_diag],center = true);
	// 	translate([0,0,hauteur_diag/2]) rotate([0,0,0]) cube([longueur,epaisseur_hypo,hauteur_diag],center = true);
	// 	translate([0,0,hauteur_diag/2]) rotate([0,0,90]) cube([largeur,epaisseur_hypo,hauteur_diag],center = true);

	// 	translate([0,0,hauteur-hauteur_diag/2]) rotate([0,0,90]) cube([largeur,epaisseur_hypo,hauteur_diag],center = true);
	// 	translate([0,(largeur-hauteur_diag)/2,hauteur/2]) rotate([0,90,90]) cube([hauteur,epaisseur_hypo,hauteur_diag],center = true);
	// 	translate([0,-(largeur-hauteur_diag)/2,hauteur/2]) rotate([0,90,90]) cube([hauteur,epaisseur_hypo,hauteur_diag],center = true);
	// }
}

module calibration_2(longueur,largeur,hauteur){
	calibration_base(longueur,largeur,hauteur);
	hypotenuse = ceil(sqrt(pow((longueur-longueur_col),2) + pow((largeur-largeur_col),2)));
	epaisseur_hypo = sqrt(pow((longueur_col-2*epaisseur),2) + pow((largeur_col-2*epaisseur),2));
	angle = 45;
	
	difference(){
		translate([0, 0, -hauteur/2]) 
		union(){
			translate([0,0,2.5]) rotate([0,0,angle]) cube([hypotenuse,epaisseur_hypo,5],center = true);
			translate([0,0,2.5]) rotate([0,0,-angle]) cube([hypotenuse,epaisseur_hypo,5],center = true);
			translate([(longueur-longueur_col)/2, (largeur-largeur_col)/2, 2.5]) cube([longueur_col,largeur_col,5], center=true);
		}
		translate([-(longueur-longueur_col)/2, (largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
		translate([-(longueur-longueur_col)/2, -(largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
		translate([(longueur-longueur_col)/2, -(largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
	}
}

module calibration_3(longueur,largeur,hauteur){
	calibration_base(longueur,largeur,hauteur);
	difference(){
		translate([0,0,-(hauteur-epaisseur)/2]) cube([longueur,largeur,epaisseur], center=true);
		translate([-(longueur-longueur_col)/2, (largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
		translate([-(longueur-longueur_col)/2, -(largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
		translate([(longueur-longueur_col)/2, -(largeur-largeur_col)/2, -hauteur/2]) cube([longueur_col,largeur_col,hauteur], center=true);
	}
}

calibration_1(20,10,50);

//calibration_2(30,30,10);