epaisseur = 2;
longueur_panneau_led = 150;
largeur_panneau_led = 150;
marge = 10;
longueur_boite = longueur_panneau_led+2*marge;
largeur_boite = largeur_panneau_led+2*marge;
hauteur_boite = 50;

module bouton_pwm(){
    
}

module support_circuit_pwm(){
    
}

module boite() {
    difference(){
        cube([longueur_boite+2*epaisseur, largeur_boite+2*epaisseur, hauteur_boite], center=true);
        translate([0, 0, epaisseur])
        cube([longueur_boite, largeur_boite, hauteur_boite], center=true);
    }
}

module couvercle(){
    difference(){
        cube([longueur_boite+2*epaisseur, largeur_boite+2*epaisseur, hauteur_boite], center=true);
        translate([0, 0, -epaisseur])
        cube([longueur_boite, largeur_boite, hauteur_boite], center=true);
        translate([0, 0, hauteur_boite/2])
        cube([longueur_panneau_led, largeur_panneau_led, 10], center=true);
    }
}

//boite();
couvercle();