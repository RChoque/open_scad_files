detail = 20;

module tube(diametre, epaisseur, hauteur){
	difference(){
		cylinder(h=hauteur, r=diametre/2, $fn=detail, center=true);
		cylinder(h=hauteur+epaisseur, r=diametre/2-epaisseur, $fn=detail, center=true);
	}
}

module trous(diametre_trou, longueur){
	rotate([0,90,0]) cylinder(h=longueur, r=diametre_trou/2, $fn=detail, center=true);
	rotate([90,90,0]) cylinder(h=longueur, r=diametre_trou/2, $fn=detail, center=true);
}

module tube_troue(diametre, epaisseur, hauteur, diametre_trou){
	sequence = 4*diametre_trou;
	modulo = hauteur % sequence;
	marge = modulo/2;
	nb_trous = (hauteur-modulo)/sequence;
	hauteur_initiale = (hauteur)/2-marge;
	difference(){
		tube(diametre, epaisseur, hauteur);
		for (i = [0 : nb_trous]) 
		{
    		translate([0,0,hauteur_initiale-i*sequence]) trous(diametre_trou, diametre+epaisseur);
			translate([0,0,hauteur_initiale-(i+0.5)*sequence]) rotate([0,0,45]) trous(diametre_trou, diametre+epaisseur);
		}
		
	}
}

//tube(180,2,115);
tube_troue(50,2,115, 10);