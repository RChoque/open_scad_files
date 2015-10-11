detail = 100;
diametre_roulement = 22;
hauteur_couche = 3;
hauteur_roulement = 7;
couches = [[30,0],[26.5,1],[25.75,2],[20,3],[15,4]];


module 608zz(){
    translate([0,0,hauteur_roulement/2])
    difference(){
        cylinder(h=hauteur_roulement, d=diametre_roulement, $fn=detail, center=true);
        cylinder(h=8, d=8, $fn=detail/2, center=true);
    }
}

module cross(longueur, largeur, hauteur){
    nb_branche = 3;
    angle = 360/nb_branche;
    difference(){
        for (i=[0:nb_branche-1]){
			rotate([0,0,angle*i])
            translate([0,-largeur/2,0])
            cube([longueur, largeur, hauteur]);
		}
        difference(){
            cylinder(h=hauteur+1, r=1.5*longueur, $fn=detail);
            cylinder(h=hauteur, r=longueur, $fn=detail/2);
        }
    }
        
    cylinder(h=hauteur, r=couches[4][0], $fn=detail/2);
}

module rounded_cross(longueur, largeur, hauteur){
    minkowski(){
        cross(longueur, largeur, hauteur/2);
        cylinder(r=3, h=hauteur/2, $fn=detail/2);
    }
}

module pyramid(){
    for(i = couches){
        echo(i[0]);
        translate([0,0, i[1]*hauteur_couche]) cross(i[0],17,hauteur_couche);
    }

}

module support(){
    difference(){
        pyramid();
        cylinder(h=6*hauteur_couche, d=diametre_roulement-2, $fn=detail);
        608zz();
        translate([0,0,5*hauteur_couche-hauteur_roulement]) 608zz(); 
    }
}

support();
