epaisseur_plaque = 7;
longueur_plaque = 127;
epaisseur_crochet = 14;
epaisseur_minkowski = 2;
espace_entre_crochet = 45;
detail = 10;


module crochet_base(){
	em = epaisseur_minkowski;
	rotate([0,-90,0])
	linear_extrude(height=epaisseur_crochet-2*em) polygon(points=[[0,em],[0,99-em],[1,95-em],[12-em,58],[54-em,8],[54-em,1+em],[15,3+em],[2,em]],paths=[ [0,1,2,3,4,5,6,7] ]);
}

module crochet(){
	minkowski (){
		crochet_base();
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
	position_x_crochet1 = epaisseur_crochet-epaisseur_minkowski+epaisseur_crochet;
	position_x_crochet2 = position_x_crochet1+epaisseur_crochet+espace_entre_crochet;
	position_x_crochet3 = position_x_crochet2+epaisseur_crochet+espace_entre_crochet;
	position_y_crochet = epaisseur_plaque-1;
	largeur_plaque = 5*epaisseur_crochet + 2*espace_entre_crochet;
	position_x_vis1 = position_x_crochet1+espace_entre_crochet/2;
	position_x_vis2 = position_x_vis1+epaisseur_crochet+espace_entre_crochet;
	difference(){
		union(){
			translate([position_x_crochet1,epaisseur_crochet,position_y_crochet]) crochet();
			translate([position_x_crochet2,epaisseur_crochet,position_y_crochet]) crochet();
			translate([position_x_crochet3,epaisseur_crochet,position_y_crochet]) crochet();
			translate([0,0,-3/2*epaisseur_minkowski])
			minkowski (){
				cube([largeur_plaque, longueur_plaque, epaisseur_plaque-2*epaisseur_minkowski]);
				sphere (3*epaisseur_minkowski, $fn=detail);
			}
		}
		translate([position_x_vis1,40,epaisseur_plaque]) rotate([180,0,0]) vis(4,2);
		translate([position_x_vis2,40,epaisseur_plaque]) rotate([180,0,0]) vis(4,2);
		translate([-3*epaisseur_minkowski,-3*epaisseur_minkowski,-(epaisseur_plaque+3*epaisseur_minkowski)]) cube([largeur_plaque+6*epaisseur_minkowski, longueur_plaque+6*epaisseur_minkowski, epaisseur_plaque+3*epaisseur_minkowski]);
	}
translate([position_x_vis2,40,(epaisseur_plaque-2*epaisseur_minkowski)/2]) rotate([180,0,0]) color("red") vis();
}

guitar_hero();

translate([-100,0,0]) color("green") resized_support();
