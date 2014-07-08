detail = 100;
marge = 0.5;
epaisseur = 2;
diametre_boite = 79;
hauteur_boite = 80;
rayon_boite = diametre_boite/2;
hauteur = 20;

difference(){
	union(){
		cylinder (r=rayon_boite+epaisseur+marge, h=hauteur, $fn=detail);
		translate([0,rayon_boite+epaisseur+marge-rayon_boite/4,hauteur_boite*0.75/2]) cube([rayon_boite,rayon_boite/2,hauteur_boite*0.75], center=true);
	}
	translate([0,0,epaisseur]) cylinder (r=marge+rayon_boite, h=hauteur_boite*0.75, $fn=detail);
	translate([0,0,-epaisseur]) cylinder (r=diametre_boite/5, h=hauteur, $fn=detail);
	rotate([-3.5,0,0]) translate([0,rayon_boite-epaisseur+marge-rayon_boite/8,hauteur_boite*0.75/2+hauteur+epaisseur]) color("blue") cube([rayon_boite+marge,2*epaisseur,hauteur_boite*0.75], center=true);
	translate([0,rayon_boite,1.5*hauteur]) rotate([-90,0,0]) vis();
	translate([0,rayon_boite,2.5*hauteur]) rotate([-90,0,0]) vis();
}


module vis(){
	cylinder (r1=1.5, r2=1.5, h=10, $fn=100);
	cylinder (r1=4, r2=1.5, h=3, $fn=100);
}

