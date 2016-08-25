nb_cadres = 6;
largeur_photo = 100;
longueur_photo = 150;
epaisseur_photo = 1.5;
epaisseur_vitre = 1.75;
epaisseur = 1.5;
epaisseur_totale = 2*epaisseur+epaisseur_vitre+epaisseur_photo;
rayon_carousel = largeur_photo+2*epaisseur+cos(360/(2*nb_cadres))*epaisseur_totale+epaisseur;
hauteur_marche = 4;
nb_marches = 4;
hauteur_chapiteau = 50;
hauteur_hexagone = (sqrt(3)/2)*(largeur_photo+2*epaisseur);
hauteur_socle = nb_marches*hauteur_marche;
diametre_axe = 36;
largeur_fixation_rondelle = 10;
diametre_rondelle = diametre_axe + 2*epaisseur + 2*largeur_fixation_rondelle;

angle = 360/nb_cadres;
detail = 100;
nb_encoches = 5;
longueur_encoche = (longueur_photo+2*epaisseur)/(2*nb_encoches-1);

module vis(){
	cylinder (r1=1.5, r2=1.5, h=20, $fn=100);
	cylinder (r1=4, r2=1.5, h=3, $fn=100);
}

module accroche(marge){
	translate([0,10,(marge+hauteur_marche)/2]) cube([marge+largeur_photo/10, marge+10, marge+hauteur_marche], center=true);
	cylinder(h = marge+hauteur_marche, r=marge+largeur_photo/10);
}

module triangle_isocele(base, hauteur, epaisseur){
    linear_extrude(height=epaisseur) 
    polygon(points=[[0,-base/2],[0,base/2],[hauteur,0]],paths=[ [0,1,2] ]);
        
}

module socle(){
    difference(){
        translate([0,0,-hauteur_marche/2])
		for(couche =[0 : 1 : nb_marches-1]){
			translate([0,0,-couche*hauteur_marche])
	    	cylinder(r=rayon_carousel+couche*hauteur_marche, h=hauteur_marche, $fn=detail, center=true);
	    }
		#axe();
    }
}

module axe(){
    
    translate([0,0,epaisseur-hauteur_socle])
    union(){
        cylinder(d=diametre_axe, h=hauteur_socle, $fn=detail);
        translate([0,0,hauteur_socle])
        cylinder(d=diametre_axe-2*epaisseur, h=longueur_photo-2*epaisseur, $fn=detail);
        translate([0,0,hauteur_socle+longueur_photo-2*epaisseur])
        cylinder(d=diametre_axe-4*epaisseur, h=4*epaisseur, $fn=detail);
        translate([0,0,hauteur_socle+longueur_photo+2*epaisseur])
        cylinder(r1=(diametre_axe-4*epaisseur)/2, r2=0, h=hauteur_chapiteau/3, $fn=detail); 
    }
}

module colonne(){
    difference(){
    cylinder(r=epaisseur_totale, h=longueur_photo+2*epaisseur, $fn=detail);
    translate([0,0,-0.5])
    union(){
        translate([0,-0.5,0])
        cube([epaisseur_totale,epaisseur_totale+1,longueur_photo+2*epaisseur+1]);
        rotate([0,0,angle])
        translate([-epaisseur_totale,0,0])
        cube([epaisseur_totale,epaisseur_totale,longueur_photo+2*epaisseur+1]);
        translate([-epaisseur_totale,-epaisseur_totale,0])
    cube([2*epaisseur_totale,epaisseur_totale,longueur_photo+2*epaisseur+1]);
    }
    
}
}

module chapiteau(){
    translate([0,0, hauteur_chapiteau/3])
	difference(){
        union(){
            translate([0,0, -hauteur_chapiteau/6])
            cylinder(r=rayon_carousel+epaisseur, h=hauteur_chapiteau/3, $fn=detail, center=true);
            translate([0,0, 2*hauteur_chapiteau/4])
            difference(){
                cylinder(r1=rayon_carousel+epaisseur, r2=0, h=2*hauteur_chapiteau/2, $fn=18, center=true);
            }
        }
        for(vis =[0 : 1 : 2*nb_cadres-1]){
            rotate([0,0,angle/2*vis])
            translate([hauteur_hexagone-(largeur_photo/2+hauteur_hexagone-diametre_rondelle/2)/4,0,-hauteur_chapiteau/2-3])
            vis();
        }
        translate([0,0, -hauteur_chapiteau/3-0.1])
        cylinder(r1=(diametre_axe-3*epaisseur)/2, r2=epaisseur/2, h=hauteur_chapiteau/3, $fn=detail);
	}
    translate([0,0,hauteur_chapiteau/4])
    difference(){
        cylinder(r=rayon_carousel+epaisseur, h=hauteur_chapiteau/2, $fn=detail, center=true);
        cylinder(r=rayon_carousel-epaisseur, h=hauteur_chapiteau/2+1, $fn=detail, center=true);
        for(creux =[0 : 1 : nb_cadres-1]){
        	rotate([0,0,180/nb_cadres*creux])
        	translate([0,0,largeur_photo/3])
        	scale([1,1,0.5])
        	rotate([90,0,0])
			cylinder(d=largeur_photo, h=2*(rayon_carousel+epaisseur+1), $fn=detail, center=true);
	    }
        
    }
    
}

module rainure(hauteur, largeur, epaisseur){
    cube([largeur, 2*epaisseur, hauteur],center = true);
    translate([0,0,hauteur/2])
	rotate([90,0,0])
	cylinder(d=largeur, h=2*epaisseur, $fn=detail, center=true);

	translate([0,0,-hauteur/2])
	rotate([90,0,0])
	cylinder(d=largeur, h=2*epaisseur, $fn=detail, center=true);
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
        scale(1.025)
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
		cylinder(d=diametre_axe-4*epaisseur, h=6*epaisseur, $fn=detail, center=true);

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
		cylinder(d=diametre_axe-2*epaisseur, h=6*epaisseur, $fn=detail, center=true);
		for(cadres =[0 : 1 : 2*nb_cadres-1]){
		    rotate([0,0,angle/2*cadres])
		    translate([diametre_rondelle/2-largeur_fixation_rondelle/2,0,-2*epaisseur])
			#vis();
		}
	}
}

module cadre(){
    marge = 0.5;
    translate([(epaisseur)/2,0,0])
    difference(){
        cube([epaisseur, largeur_photo+2*epaisseur, longueur_photo+2*epaisseur], center=true);
        rotate([0,0,90])
        rainure(longueur_photo/2, largeur_photo/3, 2*epaisseur);
        for(encoches =[0 : 1 : nb_encoches-1]){
        translate([0,0,(longueur_photo+2*epaisseur+longueur_encoche)/2 - 2*encoches*longueur_encoche])
            union(){
                translate([0,(largeur_photo+epaisseur)/2,0])
        cube([epaisseur+2, epaisseur, longueur_encoche+marge],center=true);
                translate([0,-(largeur_photo+epaisseur)/2,0])
        cube([epaisseur+2, epaisseur, longueur_encoche+marge],center=true);
            }
        }
        translate([0, 0, -(longueur_photo+epaisseur)/2])
        cube([epaisseur, largeur_photo/4, epaisseur],center=true);
    }  
    //support_bas
    translate([0,0,-longueur_photo/2-epaisseur])
    rotate([0,0,180])
    difference(){
    	triangle_isocele(largeur_photo+2*epaisseur, hauteur_hexagone, 4*epaisseur);
        translate([hauteur_hexagone,0,2*epaisseur])
        empreinte_rondelle();
        translate([(largeur_photo/2+hauteur_hexagone-diametre_rondelle/2)/4,0,0])
        rotate([90,0,90])
        rainure((hauteur_hexagone-diametre_rondelle/2)/4, largeur_photo/4, 10*epaisseur);
    }
    //support_haut
    translate([0,0,longueur_photo/2-3*epaisseur])
    rotate([0,0,180])
    difference(){
    	triangle_isocele(largeur_photo+2*epaisseur, hauteur_hexagone, 4*epaisseur);
        translate([hauteur_hexagone,0,2*epaisseur])
        rotate([180,0,0])
        empreinte_rondelle();
        translate([(largeur_photo/2+hauteur_hexagone-diametre_rondelle/2)/4,0,0])
        #vis();
    }
}

module couvercle_cadre(){
    translate([0,-(largeur_photo+2*epaisseur)/2, -(longueur_photo+2*epaisseur)/2])
    difference(){
        cube([epaisseur+epaisseur_vitre+epaisseur_photo, largeur_photo+2*epaisseur, longueur_photo+2*epaisseur]);
        translate([-1, epaisseur, epaisseur])
        cube([epaisseur_photo+1, largeur_photo, longueur_photo+epaisseur+1]);
        //TODO supprimer les +1
        translate([epaisseur_photo, epaisseur, epaisseur])
        cube([epaisseur_vitre+1, largeur_photo, longueur_photo]);
        translate([0, 3*epaisseur, 3*epaisseur])
        cube([epaisseur+epaisseur_vitre+epaisseur_photo+2, largeur_photo-4*epaisseur, longueur_photo-4*epaisseur]);
    }
    
    translate([-epaisseur/2,0,0])
    difference(){
        cube([epaisseur, largeur_photo+2*epaisseur, longueur_photo+2*epaisseur], center=true);
        cube([epaisseur+2, largeur_photo, longueur_photo],center=true);
        for(encoches =[0 : 1 : nb_encoches-1]){
        translate([0,0,(longueur_photo+2*epaisseur-longueur_encoche)/2 - 2*encoches*longueur_encoche])
        cube([epaisseur+2, largeur_photo+2*epaisseur+2, longueur_encoche],center=true);
        }
    }
    translate([-epaisseur/2, 0, -(longueur_photo+epaisseur)/2])
        cube([epaisseur, largeur_photo/4, epaisseur],center=true);
}

module socle_coupe(){
	difference(){
		socle();
		translate([-(rayon_carousel+hauteur_socle),-(rayon_carousel+hauteur_socle),-0.5-hauteur_socle])
		cube([(rayon_carousel+hauteur_socle),2*(rayon_carousel+hauteur_socle),hauteur_socle+1]);
		translate([-(rayon_carousel+hauteur_socle),-(rayon_carousel+hauteur_socle),-0.5-hauteur_socle])
		cube([2*(rayon_carousel+hauteur_socle),(rayon_carousel+hauteur_socle),hauteur_socle+1]);
	}
}

module socle_coupe_1(){
	difference(){
		socle_coupe();
        translate([2+largeur_photo/10,rayon_carousel/2,-hauteur_socle]) 
        rotate([0,0,90])
        #union(){
        	accroche(0);
        	translate([0,0,-5]) vis();
        }
        translate([rayon_carousel/2,2+largeur_photo/10,-hauteur_socle])
        rotate([0,0,180])
        #union(){
        	accroche(0);
        	translate([0,0,-5]) vis();
        }
	}
}

module socle_coupe_2(){
	socle_coupe();
    translate([-2-largeur_photo/10,rayon_carousel/2,-hauteur_socle])
    rotate([0,0,-90])
    difference(){
		accroche(0);
        vis();
    }
    translate([rayon_carousel/2,-2-largeur_photo/10,-hauteur_socle])
    difference(){
		accroche(0);
        vis();
    }
}

module chapiteau_coupe(){
	difference(){
		rotate([0,0,angle/4])
		chapiteau();
		translate([-(rayon_carousel+epaisseur),-(rayon_carousel+epaisseur),-0.5])
		cube([(rayon_carousel+epaisseur),2*(rayon_carousel+epaisseur),2*hauteur_chapiteau+1]);
		translate([-(rayon_carousel+epaisseur),-(rayon_carousel+epaisseur),-0.5])
		cube([2*(rayon_carousel+epaisseur),(rayon_carousel+epaisseur),2*hauteur_chapiteau+1]);
	}
}

module chapiteau_coupe_1(){
	difference(){
		chapiteau_coupe();
		translate([2+largeur_photo/10,2*(rayon_carousel+epaisseur)/3,0]) 
        rotate([0,0,90])
        #union(){
        	accroche(0);
        	translate([0,0,-5]) vis();
        }
        translate([2*(rayon_carousel+epaisseur)/3,2+largeur_photo/10,]) 
        rotate([0,0,180])
        #union(){
        	accroche(0);
        	translate([0,0,-5]) vis();
        }
	}
}

module chapiteau_coupe_2(){
	chapiteau_coupe();
    translate([-2-largeur_photo/10,2*(rayon_carousel+epaisseur)/3,0]) 
    rotate([0,0,-90])
    difference(){
		accroche(0);
        vis();
    }
    translate([2*(rayon_carousel+epaisseur)/3,-2-largeur_photo/10,0])
    difference(){
		accroche(0);
        vis();
    }
}

module carousel(){
    
    for(socles =[0 : 1 : 3]){
		rotate([0,0,socles*90])
        if(socles%2!=0){
            socle_coupe_1();            
        }else{
            socle_coupe_2();
        }
    }
    color("green") axe();
    
    rotate([0,0,angle/4])
    translate([0,0,3*epaisseur])
    color("gray") rondelle_bas();
    
    translate([0,0,longueur_photo+epaisseur])
    rotate([180,0,angle/4])
    color("silver") rondelle_haut();
    translate([0,0,longueur_photo+3*epaisseur])
    for(socles =[0 : 1 : 3]){
		rotate([0,0,socles*90])
        if(socles%2!=0){
            chapiteau_coupe_1();            
        }else{
            chapiteau_coupe_2();
        }
    }


	for(cadres =[0 : 1 : nb_cadres-1]){
	    rotate([0,0,angle*cadres])
	    translate([hauteur_hexagone,0,longueur_photo/2+2*epaisseur])
	    union(){
            color([0,1/6*cadres,1-1/6*cadres])
            cadre();
            translate([epaisseur,0,0])
            color([1-1/6*cadres,0,1-1/6*cadres])
            couvercle_cadre();
        }
	}
    
    for(cadres =[0 : 1 : nb_cadres-1]){
	    rotate([0,0,angle/2+angle*cadres])
	    translate([rayon_carousel-epaisseur_totale,0,epaisseur])
	    union(){
            rotate([0,0,270-angle/2])
            colonne();
        }
	}
    
}

carousel();


