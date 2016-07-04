rayon_accroche = 5;
marge = 10;
rayon_vis = 2;
epaisseur = 2;
longueur_rpi = 93;
largeur_rpi = 56;
longueur_k8200 = 115;
largeur_k8200 = 68;
longueur_relais = 51;
largeur_relais = 39;
longueur_transfo = 48;
largeur_transfo = 36;
hauteur_boite = 20;
longueur_boite = largeur_rpi+largeur_k8200+4*marge-2*rayon_accroche;
largeur_boite = longueur_k8200+largeur_relais+4*marge;


module cube_arrondi(longueur, largeur, hauteur){
    minkowski(){
        cube([longueur, largeur, hauteur], center=true);
        cylinder(r=rayon_accroche, $fn=100, center=true);
    }
}

module boite_arrondie(longueur, largeur, hauteur){
    difference(){
        cube_arrondi(longueur+2*epaisseur, largeur+2*epaisseur, hauteur+epaisseur);
        translate([0,0,epaisseur/2+0.1])
        cube_arrondi(longueur, largeur, hauteur);
    }
}

module accroche(r1, r2, hauteur_accroche){
    difference(){
        cylinder (r=r1, h=hauteur_accroche, $fn=100);
        cylinder (r=r2, h=hauteur_accroche+1, $fn=100);
    }
}

module support_raspberry_pi(){
    #cube([longueur_rpi,largeur_rpi,epaisseur]);
    #translate([-17,(largeur_rpi-24)/2,0])cube([17,24,epaisseur]);
    translate([25.5, 18, 0])
    accroche(2.5, 1, 8);
    translate([longueur_rpi-5, largeur_rpi-12.5, 0])
    accroche(2.5, 1, 8);
}

module support_carte_k8200(){
    #cube([longueur_k8200,largeur_k8200,epaisseur]);
    translate([5, 5, 0])
    accroche(2.5, 1, 8);
    translate([longueur_k8200-5, 5, 0])
    accroche(2.5, 1, 8);
    translate([5, largeur_k8200-5, 0])
    accroche(2.5, 1, 8);
    translate([longueur_k8200-5, largeur_k8200-5, 0])
    accroche(2.5, 1, 8);
}

module support_carte_relais(){
    #cube([longueur_relais,largeur_relais,epaisseur]);
    translate([2.5, 2.5, 0])
    accroche(2.5, 1, 6);
    translate([longueur_relais-2.5, 2.5, 0])
    accroche(2.5, 1, 6);
    translate([2.5, largeur_relais-2.5, 0])
    accroche(2.5, 1, 6);
    translate([longueur_relais-2.5, largeur_relais-2.5, 0])
    accroche(2.5, 1, 6);
}

module support_carte_transfo(){
    #cube([longueur_transfo,largeur_transfo,epaisseur]);
    translate([2.5, 2.5, 0])
    accroche(2.5, 1, 6);
    translate([longueur_transfo-2.5, 2.5, 0])
    accroche(2.5, 1, 6);
    translate([2.5, largeur_transfo-2.5, 0])
    accroche(2.5, 1, 6);
    translate([longueur_transfo-2.5, largeur_transfo-2.5, 0])
    accroche(2.5, 1, 6);
}

module boite_complete(){
    boite_arrondie(longueur_boite,largeur_boite,hauteur_boite);
    translate([longueur_boite/2+epaisseur,largeur_boite/2+epaisseur,-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);

    translate([-(longueur_boite/2+epaisseur),largeur_boite/2+epaisseur,-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);

    translate([-(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);

    translate([(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);
    
    translate([-longueur_boite/2-rayon_accroche+largeur_rpi+marge,largeur_boite/2+rayon_accroche-longueur_k8200-marge,-(epaisseur+hauteur_boite)/2])
    rotate([0,0,90])
    color("red") 
    support_raspberry_pi();
    
    translate([longueur_boite/2+rayon_accroche-marge,largeur_boite/2+rayon_accroche-longueur_k8200-marge,-(epaisseur+hauteur_boite)/2])
    rotate([0,0,90])
    color("green")
    support_carte_k8200();
    
    translate([longueur_boite/2+rayon_accroche-4*marge-largeur_transfo-longueur_relais,-rayon_accroche-largeur_boite/2+marge,-(epaisseur+hauteur_boite)/2])
    support_carte_relais();
    
    translate([longueur_boite/2+rayon_accroche-2*marge,-rayon_accroche-largeur_boite/2+marge,-(epaisseur+hauteur_boite)/2])
    rotate([0,0,90])
    support_carte_transfo();
}

boite_complete();
