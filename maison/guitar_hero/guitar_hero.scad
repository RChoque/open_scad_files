epaisseur_plaque = 5;
longueur_plaque = 127;
epaisseur_crochet = 14;
epaisseur_minkowski = 2;
espace_entre_crochet = 40;
detail = 10;


module crochet_base(){
	em = epaisseur_minkowski;
	rotate([0,-90,0])
	linear_extrude(height=epaisseur_crochet-2*em) polygon(points=[[0,em],[0,99-em],[1,95-em],[12-em,58],[54-em,8],[54-em,1+em],[15,3+em],[2,em]],paths=[ [0,1,2,3,4,5,6,7] ]);
}

module biseau_droit(){
	em = epaisseur_minkowski;
	largeur = epaisseur_crochet/4;
	translate([-(epaisseur_crochet-2*em),1.2,0])
	rotate([-13,0,0])
	linear_extrude(height=16) polygon(points=[[0,0],[0,largeur],[largeur,0]],paths=[ [0,1,2] ]);
	translate([-(epaisseur_crochet-2*em),4.7,14.5])
	rotate([3,0,0])
	linear_extrude(height=40) polygon(points=[[0,0],[0,largeur],[largeur,0]],paths=[ [0,1,2] ]);
}

module biseau_gauche(){
	em = epaisseur_minkowski;
	largeur = epaisseur_crochet/4;
	translate([0.1,1.2,0])
	rotate([-13,0,0])
	linear_extrude(height=16) polygon(points=[[0,0],[0,largeur],[-largeur,0]],paths=[ [0,1,2] ]);
	translate([0.1,4.7,14.5])
	rotate([3,0,0])
	linear_extrude(height=40) polygon(points=[[0,0],[0,largeur],[-largeur,0]],paths=[ [0,1,2] ]);
}

module crochet_gauche(){
	difference(){
		crochet_base();
		biseau_droit();
	}
}

module crochet_centre(){
	difference(){
		crochet_base();
		biseau_droit();
		biseau_gauche();
	}
}

module crochet_droit(){
	difference(){
		crochet_base();
		biseau_gauche();
	}
}

module crochets(){
	position_x_crochet1 = epaisseur_crochet-epaisseur_minkowski+epaisseur_crochet;
	position_x_crochet2 = position_x_crochet1+epaisseur_crochet+espace_entre_crochet;
	position_x_crochet3 = position_x_crochet2+epaisseur_crochet+espace_entre_crochet;
	minkowski (){
		union(){
			translate([position_x_crochet1,epaisseur_crochet,0]) crochet_droit();
			translate([position_x_crochet2,epaisseur_crochet,0]) crochet_centre();
			translate([position_x_crochet3,epaisseur_crochet,0]) crochet_gauche();
		}
		sphere (epaisseur_minkowski, $fn=detail);
	}
}

module resized_support(){
	scale(25.4) import("guitarhero-wallmount_02.stl");
}

module vis(diam_tete, diam_tige){
	cylinder (r1=diam_tige, r2=diam_tige, h=10, $fn=100);
	cylinder (r1=diam_tete, r2=diam_tige, h=3, $fn=100);
}

module guitar_hero(){
	position_y_crochet = epaisseur_plaque-1;
	largeur_plaque = 5*epaisseur_crochet + 2*espace_entre_crochet;
	position_x_vis1 = epaisseur_crochet-epaisseur_minkowski+epaisseur_crochet+espace_entre_crochet/2;
	position_x_vis2 = position_x_vis1+epaisseur_crochet+espace_entre_crochet;
	difference(){
		union(){
			translate([0,0,position_y_crochet]) crochets();
			translate([0,0,-3/2*epaisseur_minkowski])
			minkowski (){
				cube([largeur_plaque, longueur_plaque, epaisseur_plaque-2*epaisseur_minkowski]);
				sphere (3*epaisseur_minkowski, $fn=detail);
			}
		}
		translate([position_x_vis1,40,epaisseur_plaque]) rotate([180,0,0]) vis(4,2);
		translate([position_x_vis2,40,epaisseur_plaque]) rotate([180,0,0]) vis(4,2);
		translate([-3*epaisseur_minkowski-1,-3*epaisseur_minkowski,-(epaisseur_plaque+3*epaisseur_minkowski)]) cube([largeur_plaque+6*epaisseur_minkowski+2, longueur_plaque+6*epaisseur_minkowski, epaisseur_plaque+3*epaisseur_minkowski]);
	}
}

guitar_hero();

