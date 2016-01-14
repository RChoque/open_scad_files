largeur_manche = 15;
longueur_manche = 20;
hauteur_manche = 30;
largeur_fente = 5;
hauteur_fente = 20;
nb_limes = 5;
epaisseur = 3;
largeur_support = 2*epaisseur;
epaisseur_minkowski = (largeur_fente-1)/2;
detail = 100;
longueur_plate = nb_limes*longueur_manche+(nb_limes+1)*2*epaisseur;
largeur_plate = longueur_manche+4*epaisseur;

module vis(){
	cylinder (r1=2, r2=2, h=20, $fn=100);
	cylinder (r1=5, r2=2, h=3, $fn=100);
}

module plate(){
    cube([longueur_plate, largeur_plate, epaisseur]);
    for(limes =[0 : 1 : nb_limes-1]){
		translate([largeur_fente/2+(0.5+limes)*(longueur_manche+2*epaisseur),epaisseur_minkowski+epaisseur,epaisseur_minkowski])
		crochet();
    }
}

module crochet(){
    rotate([0,-90,0])
    minkowski (){
		prisme(hauteur_fente-2*epaisseur_minkowski, largeur_manche-2*epaisseur_minkowski+2*epaisseur+largeur_fente, 1);
		sphere (epaisseur_minkowski, $fn=detail);
	}
    translate([0,hauteur_fente-3*largeur_fente/4, largeur_manche-2*epaisseur_minkowski+2*epaisseur+largeur_fente])
    sphere(d=largeur_fente, $fn=detail);
}

module prisme(cote1, cote2, longueur){
    linear_extrude(height=longueur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,cote1],
                    [cote2,cote1],
                    ], paths=[[0,1,2]]);
}

module support_complet(){
    difference(){
        plate();
        translate([largeur_fente/2+1*(longueur_manche+2*epaisseur),largeur_plate/2,epaisseur+0.1])
        rotate([0,180,0])
        #vis();
        translate([largeur_fente/2+(nb_limes-1)*(longueur_manche+2*epaisseur),largeur_plate/2,epaisseur+0.1])
        rotate([0,180,0])
        #vis();
    }
}

support_complet();
