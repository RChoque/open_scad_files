largeur_photo = 100;
longueur_photo = 150;
epaisseur_photo = 2;
epaisseur_vitre = 2;
epaisseur = 2;
epaisseur_totale = 2*epaisseur+epaisseur_vitre+epaisseur_photo;
rayon_carousel = largeur_photo+epaisseur_totale;
hauteur_marche = 5;
nb_marches = 4;
hauteur_chapiteau = 50;
hauteur_hexagone = (sqrt(3)/2)*rayon_carousel;
diametre_axe = 36;
largeur_fixation_rondelle = 10;
diametre_rondelle = diametre_axe + 2*epaisseur + 2*largeur_fixation_rondelle;
nb_cadres = 6;
angle = 360/nb_cadres;
detail = 100;

module tore(rayon){
	rotate_extrude(convexity=10, $fn=200)
		translate([rayon/2, 0, 0])
        rotate(-25)
        scale([1,0.5])
		circle(r = rayon/2, $fn = 100);
}

module vis(){
	cylinder (r1=2, r2=2, h=20, $fn=100);
	cylinder (r1=4, r2=2, h=2, $fn=100);
}

module triangle_isocele(base, hauteur, epaisseur){
    linear_extrude(height=epaisseur) 
    polygon(points=[[0,-base/2],[0,base/2],[hauteur,0]],paths=[ [0,1,2] ]);
        
}

module socle(){
    difference(){
		for(couche =[0 : 1 : nb_marches-1]){
			translate([0,0,-couche*hauteur_marche])
	    	cylinder(r=rayon_carousel+couche*hauteur_marche, h=hauteur_marche, $fn=detail, center=true);
	    }
		//translate([0,0,epaisseur-nb_marches*hauteur_marche])
    	axe();
    }
}

module axe(){
    hauteur_socle = nb_marches*hauteur_marche;
    cylinder(d=diametre_axe, h=hauteur_socle, $fn=detail);
    cylinder(d=diametre_axe-2*epaisseur, h=longueur_photo+2*epaisseur, $fn=detail);
}

module chapiteau(){
	difference(){
	    cylinder(r1=rayon_carousel+epaisseur, r2=0, h=hauteur_chapiteau, $fn=detail, center=true);
	    translate([0,0,rayon_carousel/6])
	    
	    tore(rayon_carousel);
	}
    translate([0,0,-hauteur_chapiteau/4])
    difference(){
        cylinder(r=rayon_carousel+epaisseur, h=hauteur_chapiteau/2, $fn=detail, center=true);
        cylinder(r=rayon_carousel-epaisseur, h=hauteur_chapiteau/2+1, $fn=detail, center=true);
        for(creux =[0 : 1 : 6]){
        	rotate([0,0,180/6*creux])
        	translate([0,0,largeur_photo/4])
        	scale([1,1,0.5])
        	rotate([90,0,0])
			cylinder(d=largeur_photo, h=2*(rayon_carousel+epaisseur+1), $fn=detail, center=true);
	    }
        
    }
    
}

module rainure(hauteur, largeur, epaisseur){
    #cube([largeur, 2*epaisseur, hauteur],center = true);
    translate([0,0,hauteur/2])
	rotate([90,0,0])
	#cylinder(d=largeur, h=2*epaisseur, $fn=detail, center=true);

	translate([0,0,-hauteur/2])
	rotate([90,0,0])
	#cylinder(d=largeur, h=2*epaisseur, $fn=detail, center=true);
}

module rondelle_base(){
	difference(){
		cylinder(d=diametre_rondelle, h=4*epaisseur, $fn=detail, center=true);
		translate([0,0,2*epaisseur])
		difference(){
			cylinder(d=diametre_rondelle+epaisseur, h=4*epaisseur, $fn=detail, center=true);
			cylinder(d=diametre_rondelle-2*largeur_fixation_rondelle, h=6*epaisseur, $fn=detail, center=true);
		}
	}
}

module empreinte_rondelle(){
    rotate([0,0,angle/4])
	union(){
		rondelle_base();
		for(cadres =[0 : 1 : 2*nb_cadres-1]){
		    rotate([0,0,angle/2*cadres])
		    translate([diametre_rondelle/2-largeur_fixation_rondelle/2,0,-2*epaisseur])
			vis();
		}
	}
}

module rondelle_haut(){
	difference(){
		rondelle_base();
		cylinder(d=diametre_axe-2*epaisseur, h=6*epaisseur, $fn=detail, center=true);

		for(cadres =[0 : 1 : 2*nb_cadres-1]){
		    rotate([0,0,angle/2*cadres])
		    translate([diametre_rondelle/2-largeur_fixation_rondelle/2,0,-2*epaisseur])
			#vis();
		}
	}
}

module rondelle_bas(){
	difference(){
		rondelle_base();
		cylinder(d=diametre_axe-4*epaisseur, h=6*epaisseur, $fn=detail, center=true);
		for(cadres =[0 : 1 : 2*nb_cadres-1]){
		    rotate([0,0,angle/2*cadres])
		    translate([diametre_rondelle/2-largeur_fixation_rondelle/2,0,-2*epaisseur])
			#vis();
		}
	}
}

module cadre(){
    translate([-(epaisseur_photo+epaisseur)/2,0,0])
    difference(){
        cube([epaisseur_photo+epaisseur, largeur_photo+2*epaisseur, longueur_photo+2*epaisseur], center=true);
        translate([(epaisseur+1)/2, 0, (epaisseur+1)/2])
        cube([epaisseur_photo+1, largeur_photo, longueur_photo+epaisseur+1], center=true);
        rotate([0,0,90])
        rainure(longueur_photo/2, largeur_photo/3, 2*epaisseur);
    }
    //support_bas
    translate([-(epaisseur_photo+epaisseur),0,-longueur_photo/2-epaisseur])
    rotate([0,0,180])
    difference(){
    	triangle_isocele(largeur_photo+2*epaisseur, hauteur_hexagone-(epaisseur_photo+epaisseur), 4*epaisseur);
        translate([hauteur_hexagone-(epaisseur_photo+epaisseur),0,2*epaisseur])
        empreinte_rondelle();
        translate([(largeur_photo/2+hauteur_hexagone-diametre_rondelle/2)/4,0,0])
        rotate([90,0,90])
        rainure((hauteur_hexagone-diametre_rondelle/2)/4, largeur_photo/4, 10*epaisseur);
    }
    //support_haut
    translate([-(epaisseur_photo+epaisseur),0,longueur_photo/2-3*epaisseur])
    rotate([0,0,180])
    difference(){
    	triangle_isocele(largeur_photo+2*epaisseur, hauteur_hexagone-(epaisseur_photo+epaisseur), 4*epaisseur);
        translate([hauteur_hexagone-(epaisseur_photo+epaisseur),0,2*epaisseur])
        rotate([180,0,0])
        empreinte_rondelle();
    }
}

module couvercle_cadre(){
    translate([(epaisseur_photo+epaisseur_vitre)/2,0,0])
    difference(){
        cube([epaisseur+epaisseur_vitre, largeur_photo+2*epaisseur, longueur_photo+2*epaisseur], center=true);
        translate([(epaisseur+1)/2, 0, 0])
        cube([epaisseur_vitre+1, largeur_photo, longueur_photo+1], center=true);
        cube([epaisseur+epaisseur_vitre+1, largeur_photo-2*epaisseur, longueur_photo-2*epaisseur], center=true);
    }
}

module carousel(){
    
	translate([0,0,-hauteur_marche/2])
	socle();
    axe();    translate([0,0,longueur_photo+2*epaisseur+hauteur_chapiteau/2])
    chapiteau();

	for(cadres =[0 : 1 : nb_cadres-4]){
	    rotate([0,0,angle*cadres])
	    translate([hauteur_hexagone,0,longueur_photo/2+epaisseur])
	    union(){
            cadre();
            couvercle_cadre();
        }
        rotate([0,0,angle*cadres])
        translate([0,rayon_carousel,longueur_photo/2+epaisseur])
            cylinder(d=epaisseur_totale, h=longueur_photo+2*epaisseur, center=true, $fn=detail);
	}
    
    
}


carousel();
//rondelle_bas();
//translate([diametre_rondelle,0,0])rondelle_haut();