epaisseur = 2;
arrondi = 2;
largeur = 15;
hauteur = 30;
profondeur = 18-2*arrondi;
detail = 50;
longueur = 100;


difference(){
	union(){
		translate([0,0,-(hauteur-epaisseur+1)]) difference(){
			pied();
			translate([-50,-50,-2]) cube([200,200,2]);
			translate([-50,-2,-50]) cube([200,3,200]);
		}
		difference(){
			plaque();
			translate([-50,-50,-2]) cube([200,200,3]);	
		}
	}
	translate([profondeur/2,largeur/2,-hauteur+10]) cylinder (r1=5, r2=5, h=hauteur, $fn=detail);
	translate([profondeur/2,largeur/2,-hauteur+11]) rotate([0,180,0]) vis();
	translate([profondeur/2,largeur*2,-hauteur+10]) cylinder (r1=5, r2=5, h=hauteur, $fn=detail);
	translate([profondeur/2,largeur*2,-hauteur+11]) rotate([0,180,0]) vis();

translate([profondeur/2,-largeur/2,4]) rotate([0,180,0]) vis();
translate([profondeur*7/2,-largeur/2,4]) rotate([0,180,0]) vis();
translate([profondeur*13/2,-largeur/2,4]) rotate([0,180,0]) vis();
}

module pied(){
	minkowski (){ 
		union(){
  		 	translate([0,largeur,0]) polyhedron(
				points=[[0,0,0], [0,0,hauteur], [profondeur,0,hauteur], [profondeur,0,0],[profondeur,2*largeur,0], [0,2*largeur,0]],  
				triangles=[[3,2,4],  // face avant
             [0,1,2],[0,2,3],  // face gauche
             [4,2,5],[5,2,1],  // face droite
             [0,5,1],  // face arrière
             [3,4,5],[0,3,5]]  // bas
  			);
			cube([profondeur,largeur,hauteur]);		
		
		}
		sphere (arrondi, $fn=detail);
	}
}

module plaque(){
	minkowski (){ 
		union(){
  		 	translate([profondeur,0,0]) polyhedron(
				points=[[0,0,0], [0,largeur,0], [largeur,0,0], [largeur,0,epaisseur],[0,0,epaisseur], [0,largeur,epaisseur], [largeur,0,epaisseur]],  
				triangles=[[0,2,1],  // face avant
             [0,4,2],[4,3,2],  // face gauche
             [0,1,4],[4,1,5],  // face droite
             [3,4,5],  // face arrière
             [1,2,5],[2,3,5]]  // bas
  			);
			color("red") cube([profondeur,largeur,epaisseur]);
			translate([0,-(largeur),0]) cube([longueur,largeur,epaisseur]);
		
		}
		sphere (arrondi, $fn=detail);
	}
}

module vis(){
	cylinder (r1=2, r2=2, h=12, $fn=detail);
	cylinder (r1=4, r2=2, h=3, $fn=detail);
}