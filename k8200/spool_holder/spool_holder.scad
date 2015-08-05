detail = 100;
diametre_roulement = 22;
hauteur_couche = 4;
hauteur_roulement = 7;
couches = [[30,0],[25,1],[20,2],[15,3]];


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
        
    cylinder(h=hauteur, r=couches[3][0], $fn=detail/2);
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
        translate([0,0, i[1]*4]) cross(i[0],17,4);
    }

}

module support(){
    difference(){
        pyramid();
        cylinder(h=4*hauteur_couche, d=diametre_roulement-2, $fn=detail);
        608zz();
        translate([0,0,4*hauteur_couche-hauteur_roulement]) 608zz(); 
    }
}

support();
