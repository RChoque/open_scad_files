epaisseur_crochet = 2;
largeur_crochet = 20;
base_basse = 25;
base_haute = 14;
hauteur_crochet = 10.5;
longueur_crochet = 200;
petite_longueur_crochet = 35;
manifold = 0.2;

module crochet(marge){
	difference(){
		union(){
			color("red") cube([epaisseur_crochet,base_basse+manifold,largeur_crochet+marge]);

			translate ([epaisseur_crochet-manifold,epaisseur_crochet,0]) 
				rotate ([0,0,-90]) color("blue") 
					cube([epaisseur_crochet,petite_longueur_crochet+manifold,largeur_crochet+marge]);

			translate ([epaisseur_crochet,base_basse,0]) 
				rotate ([0,0,90]) color("green") 
					cube([epaisseur_crochet,hauteur_crochet+manifold,largeur_crochet+marge]);

			translate ([-hauteur_crochet,base_basse,0]) 
				color("purple") 
					cube([epaisseur_crochet,(base_haute+2*epaisseur_crochet),largeur_crochet+marge]);

			translate ([-(hauteur_crochet-epaisseur_crochet+manifold),(base_basse+base_haute+2*epaisseur_crochet),0]) 
				rotate ([0,0,-90]) color("yellow") 
					cube([epaisseur_crochet,longueur_crochet+manifold,largeur_crochet+marge]);

			translate ([longueur_crochet-(largeur_crochet+marge)-(hauteur_crochet-epaisseur_crochet),(base_basse+base_haute+2*epaisseur_crochet)-1,0]) cube([largeur_crochet+marge,8+manifold,largeur_crochet+marge]);
		}
		translate ([longueur_crochet-((largeur_crochet+marge)/2)-(hauteur_crochet-epaisseur_crochet),(base_basse+base_haute+2*epaisseur_crochet+7)+marge,(largeur_crochet+marge)/2]) rotate ([90,0,0]) color("cyan") cylinder (r1=marge+5, r2=marge+3, h=marge+4, $fn=100);
	}
}


module crochet_plat(marge){
	difference(){
		union(){
			translate ([epaisseur_crochet-manifold,epaisseur_crochet,0]) 
				rotate ([0,0,-90]) color("blue") 
					cube([epaisseur_crochet,petite_longueur_crochet+manifold,largeur_crochet+marge]);

			translate ([0,manifold,0]) 
				color("purple") 
					cube([epaisseur_crochet,(base_haute+base_basse),largeur_crochet+marge]);

			translate ([0,(base_basse+base_haute+epaisseur_crochet),0]) 
				rotate ([0,0,-90]) color("yellow") 
					cube([epaisseur_crochet,longueur_crochet+manifold,largeur_crochet+marge]);

			translate ([longueur_crochet-(largeur_crochet+marge/2),(base_basse+base_haute+epaisseur_crochet)-1,0]) cube([largeur_crochet+marge,8+manifold,largeur_crochet+marge]);
		}
		translate ([longueur_crochet-((largeur_crochet+marge/2)/2),(base_basse+base_haute+epaisseur_crochet+7)+marge,(largeur_crochet+marge)/2]) rotate ([90,0,0]) color("cyan") cylinder (r1=marge+5, r2=marge+3, h=marge+4, $fn=100);
	}
}

module crochet_meuble(marge){
	difference(){
		union(){
			translate ([0,base_haute+manifold,0]) 
				color("purple") 
					cube([epaisseur_crochet,(base_basse),largeur_crochet+marge]);

			translate ([0,(base_basse+base_haute+epaisseur_crochet),0]) 
				rotate ([0,0,-90]) color("yellow") 
					cube([epaisseur_crochet,longueur_crochet,largeur_crochet+marge]);

			translate ([longueur_crochet-(largeur_crochet+marge/2),(base_basse+base_haute+epaisseur_crochet)-1,0]) cube([largeur_crochet+marge,8+manifold,largeur_crochet+marge]);
		}
		translate ([longueur_crochet-((largeur_crochet+marge/2)/2),(base_basse+base_haute+epaisseur_crochet+7)+marge,(largeur_crochet+marge)/2]) rotate ([90,0,0]) color("cyan") cylinder (r1=marge+5, r2=marge+3, h=marge+4, $fn=100);
	}
}


