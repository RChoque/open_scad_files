longueur_boite = 188;
largeur_boite = 97;
hauteur_boite = 34;

longueur_carte = 125;
largeur_carte = 82;
hauteur_carte = 15;

longueur_jeton = 39;
largeur_jeton = 21;
hauteur_jeton = 12;

epaisseur = 2;
espace_jeton = 6;

detail=100;


module creux_jeton(){
    cube([longueur_jeton, largeur_jeton, hauteur_jeton]);
}

module creux_jeton_pack(){
    creux_jeton();
    translate([longueur_jeton+espace_jeton,0,0]) 
    creux_jeton();
    translate([0,largeur_jeton+2*espace_jeton,0]) 
    creux_jeton();
    translate([longueur_jeton+espace_jeton,largeur_jeton+2*espace_jeton,0]) 
    creux_jeton();
    translate([0,2*(largeur_jeton+2*espace_jeton),0]) 
    creux_jeton();
    translate([longueur_jeton+espace_jeton,2*(largeur_jeton+2*espace_jeton),0]) 
    creux_jeton();
    translate([longueur_jeton/2,0,hauteur_jeton])
    sphere(r=hauteur_jeton);
    translate([3*longueur_jeton/2+espace_jeton,0,hauteur_jeton])
    sphere(r=hauteur_jeton);
    translate([longueur_jeton/2,(3*largeur_jeton+4*espace_jeton),hauteur_jeton])
    sphere(r=hauteur_jeton);
    translate([3*longueur_jeton/2+espace_jeton,(3*largeur_jeton+4*espace_jeton),hauteur_jeton])
    sphere(r=hauteur_jeton);
    translate([3*longueur_jeton/2+espace_jeton,(3*largeur_jeton+4*espace_jeton),hauteur_jeton])
    rotate([90,0,0])
    cylinder(h=(3*largeur_jeton+4*espace_jeton), r=hauteur_jeton, $fn=detail);
    translate([longueur_jeton/2,(3*largeur_jeton+4*espace_jeton),hauteur_jeton]) 
    rotate([90,0,0])
    cylinder(h=(3*largeur_jeton+4*espace_jeton), r=hauteur_jeton, $fn=detail);
}

module bloc_carte(){
    //hauteur = hauteur_boite-hauteur_carte;
    hauteur = epaisseur+hauteur_jeton;
    difference(){
        translate([0,0,hauteur/2])
        cube([longueur_carte, largeur_boite, hauteur], center=true);
        translate([(3*largeur_jeton+4*espace_jeton)/2,-(2*longueur_jeton+espace_jeton)/2,hauteur-hauteur_jeton]) 
        rotate([0,0,90]) creux_jeton_pack();
    }
}

module bloc_pieces(){
    longueur = longueur_boite-longueur_carte;
    translate([longueur/2,0,hauteur_boite/2])
    difference(){
        cube([longueur, largeur_boite, hauteur_boite], center=true);
        translate([0,largeur_boite/2-(largeur_boite-4*epaisseur)/4-epaisseur,epaisseur/2])
        cube([longueur-2*epaisseur, (largeur_boite-4*epaisseur)/2, hauteur_boite-epaisseur], center=true);
        translate([0,-(largeur_boite-4*epaisseur)/6,epaisseur/2])
        cube([longueur-2*epaisseur, 2*(largeur_boite-4*epaisseur)/6, hauteur_boite-epaisseur], center=true);
        translate([0,-5*(largeur_boite-4*epaisseur)/12-epaisseur,epaisseur/2])
        cube([longueur-2*epaisseur, (largeur_boite-4*epaisseur)/6, hauteur_boite-epaisseur], center=true);
    }
    

}

//bloc_carte();
//translate([longueur_carte/2,0,0])
bloc_pieces();