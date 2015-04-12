diametre_min = 27.5;
diametre_max = 80;
diametre_axe = 8.5;
diametre_max_creux = 36;
diametre_rondelle = 25;
profondeur_creux = 5.5;
hauteur = 20;
epaisseur = 3;
epaisseur_rondelle = 2.5;
detail = 50;

module cone(){
    rayon_tore = (diametre_max-diametre_min)/2;
	coef = hauteur/rayon_tore;
    difference(){
		cylinder(h=hauteur, r2=diametre_min/2, r1=diametre_max/2, $fn=detail);
		translate([0,0,coef*rayon_tore+epaisseur]) scale([1,1,coef]) tore(rayon_tore, diametre_max/2);
		cylinder(h=profondeur_creux, r2=diametre_axe/2, r1=diametre_max_creux/2, $fn=detail);
		cylinder(h=2*hauteur, r=diametre_axe/2, $fn=detail);
        translate([0,0,hauteur-epaisseur_rondelle/2]) cylinder(h=epaisseur_rondelle, r=diametre_rondelle/2, $fn=detail);
	}
}

module tore(rayon_cercle, rayon){
	rotate_extrude(convexity=10, $fn=2*detail)
		translate([rayon, 0, 0])
		circle(r = rayon_cercle, $fn = detail);
}

cone();
