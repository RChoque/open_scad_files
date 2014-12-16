largeur_porte = 920;
hauteur_decalage = 21.65-10.34;
hauteur_biseau = 10;
largeur_biseau = 12;
largeur_biseau_bas = 3;
hauteur_renfort = 23+hauteur_decalage;
epaisseur = 1.5;
longueur_max = 190;


module biseau(longueur, largeur, largeur_bas, hauteur){
	translate([0,0,-(hauteur+hauteur_renfort)])
	rotate([90,0,0])
	linear_extrude(height=longueur, center=true, convexity = 10, twist = 0) 
			polygon(points=[
				[0,0],
				[0,hauteur+hauteur_renfort],
				[largeur+largeur_bas,hauteur+hauteur_renfort],
				[largeur+largeur_bas,hauteur],
				[largeur_bas,0]
				], paths=[[0,1,2,3,4]]);
}

module moule_porte(){
	rotate([0, 90, 0])
	difference(){
		cube([2*largeur_porte, 2*largeur_porte, 190], center = true);
		cube([largeur_porte, largeur_porte, 200], center = true);
	}
}

module biseau2(){
	angle = atan(hauteur_decalage/largeur_porte);
	decallage=hauteur_decalage/2+epaisseur/2;
	difference(){
		rotate([angle, 0, 0]) biseau(1.5*largeur_porte, largeur_biseau+epaisseur, largeur_biseau_bas, hauteur_biseau+epaisseur);
		translate([-0.5, 0, decallage]) biseau(largeur_porte, largeur_biseau, largeur_biseau_bas+1, hauteur_biseau);
	}
}

module barre_complete(){
	rotate([0,90,0])
	translate([0,largeur_porte/2,0]) 
	difference(){
		translate([0, 0, hauteur_decalage]) biseau2();
		translate([-0.5,-(largeur_porte/2+hauteur_renfort),0]) rotate([90, 0, 0]) biseau(200, largeur_biseau, largeur_biseau_bas+1, hauteur_biseau);
		translate([-0.5,largeur_porte/2+hauteur_renfort,0]) rotate([-90, 0, 0]) biseau(200, largeur_biseau, largeur_biseau_bas+1, hauteur_biseau);
		translate([0, 0, -largeur_porte/2]) moule_porte();
	}
}


module partie1(){
	difference(){
	translate([0,-longueur_max,0]) barre_complete();
	translate([0,largeur_porte/2,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	translate([0,-largeur_porte/2-longueur_max,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	}
}

module partie2(){
	difference(){
	translate([0,-2*longueur_max,0]) barre_complete();
	translate([0,largeur_porte/2,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	translate([0,-largeur_porte/2-longueur_max,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	}
}

module partie3(){
	difference(){
	translate([0,-3*longueur_max,0]) barre_complete();
	translate([0,largeur_porte/2,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	translate([0,-largeur_porte/2-longueur_max,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	}
}

module partie4(){
	difference(){
	translate([0,-4*longueur_max,0]) barre_complete();
	translate([0,largeur_porte/2,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	translate([0,-largeur_porte/2-longueur_max,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	}
}

module partie5(){
	difference(){
	translate([0,-5*longueur_max,0]) barre_complete();
	translate([0,largeur_porte/2,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	translate([0,-largeur_porte/2-longueur_max,0])cube([largeur_porte,largeur_porte,largeur_porte], center=true);
	}
}



//barre_complete();
//partie1();
//translate([100,0,0]) partie2();
//translate([200,0,0]) partie3();
//translate([300,0,0]) partie4();
translate([400,0,0]) partie5();