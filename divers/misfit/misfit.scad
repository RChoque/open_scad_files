detail = 20;
diametre_externe = 27.43;
hauteur = 3.3;
epaisseur = 2;
epaisseur_minkowski = 1;


module tore(diametre, petit_rayon){
	rotate_extrude(convexity=10, $fn=2*detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
}

module medaillon(){
	difference(){
		minkowski (){
			cylinder (r=diametre_externe/2+epaisseur-epaisseur_minkowski, h=hauteur-2*epaisseur_minkowski, $fn=2*detail, center=true);
			sphere (epaisseur_minkowski, $fn=detail);
		}	
		cylinder (r=diametre_externe/2, h=hauteur+epaisseur+2*epaisseur_minkowski, $fn=2*detail, center=true);
	}
	
}

module attache(){
	difference(){
		minkowski (){
			difference() {
				rotate([90,0,0]) scale([1, 1/3, 1]) cylinder (r=diametre_externe/6-epaisseur_minkowski, h=diametre_externe/4, $fn=2*detail, center=true);
				translate([0,-diametre_externe/5,0]) rotate([0,0,0]) cylinder (r=diametre_externe/6, h=hauteur, $fn=2*detail, center=true);
				translate([0,diametre_externe/5,0]) rotate([0,0,0]) cylinder (r=diametre_externe/6, h=hauteur, $fn=2*detail, center=true);
			}	
			sphere (epaisseur_minkowski/2, $fn=detail);
		}
		rotate([90,0,0]) scale([1, 1/3, 1]) cylinder (r=diametre_externe/6-epaisseur, h=diametre_externe, $fn=2*detail, center=true);
	}
}

module pendentif(){
	difference() {
		union(){
			medaillon();
			translate([diametre_externe/2+diametre_externe/6,0,0]) color("blue") attache();
		}
		color("green") tore(1, diametre_externe/2);
	}

	for(i = [0:7])
	{
		rotate(i*360/8, [0,0,1])
		translate([0,diametre_externe/2,0])
		sphere(r=1, $fn=detail);
	}
}


pendentif();