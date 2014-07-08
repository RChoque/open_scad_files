detail = 10;
marge = 0.5;
epaisseur = 2;
longueur = 122;
profondeur = 99;
largeur = 17;
hauteur = 25;
espace_x = 6;
espace_y = 6;
epaisseur_support = 2*epaisseur;

longueur_ext = longueur+2*(epaisseur+marge);
profondeur_ext = profondeur+2*(epaisseur+marge);
hauteur_ext =  hauteur+epaisseur+marge;

module porte_savon(){
difference(){
	cube([longueur_ext, profondeur_ext, hauteur_ext], center=true);
	translate([0,0,epaisseur]) cube([longueur+2*marge, profondeur+2*marge, hauteur+marge], center=true);
	translate([0,0,-epaisseur]) cube([longueur-2*largeur, profondeur-2*largeur, hauteur], center=true);
}
}

module support(){
	difference(){
		cube([longueur_ext/3, espace_y+profondeur_ext, hauteur_ext]);
		translate([-marge,profondeur_ext,-marge])cube([espace_x+2*marge, espace_y+2*marge, hauteur_ext+2*marge]);
		translate([2*epaisseur_support,-2*epaisseur_support,2*epaisseur_support]) minkowski (){
			union(){			
			cube([longueur_ext/3,profondeur_ext,hauteur_ext]);
			translate([espace_x,espace_y,0]) cube([longueur_ext/3,profondeur_ext,hauteur_ext]);
			}
			sphere (epaisseur_support, $fn=detail);
		}
		translate([longueur_ext/3-(epaisseur_support+espace_x),espace_y+profondeur_ext-epaisseur_support-marge,hauteur_ext/2 ]) rotate([-90,0,0]) vis();
		translate([(longueur_ext/3-(epaisseur_support+espace_x))/2,espace_y+profondeur_ext-epaisseur_support-marge,hauteur_ext/2 ]) rotate([-90,0,0]) vis();
	}

}

color("Red") porte_savon();
translate([longueur_ext/2,-profondeur/2-(epaisseur+marge),-(hauteur+epaisseur+marge)/2])  support();

module vis(){
	cylinder (r1=1.5, r2=1.5, h=10, $fn=100);
	cylinder (r1=4, r2=1.5, h=3, $fn=100);
}

