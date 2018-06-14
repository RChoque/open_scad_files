diametre_couvercle = 85.5;
hauteur_couvercle = 11;
hauteur_support_batterie = 20;
longueur_support_batterie = 76.5;
largeur_support_batterie = 21;
epaisseur = 2;
longueur_ci_charge = 28;
largeur_ci_charge = 17;

largeur_usb=8;
hauteur_usb=3;
longueur_switch=16;
longueur_max_switch=24;
largeur_switch=7.5;
profondeur_switch=7.5;
longueur_switch_btn = 10;
largeur_switch_btn=4;

module couvercle() {
    difference(){
        cylinder(d=diametre_couvercle+2*epaisseur, h=hauteur_couvercle+hauteur_support_batterie+epaisseur, $fn=100);
        translate([0,0,hauteur_support_batterie+epaisseur+0.01])
        cylinder(d=diametre_couvercle, h=hauteur_couvercle, $fn=100);
        translate([0,0,hauteur_support_batterie+epaisseur-hauteur_couvercle+0.01])
        cylinder(d=diametre_couvercle-25, h=hauteur_couvercle, $fn=100);
    
    translate([0,0,hauteur_support_batterie/2+epaisseur+0.01])
    cube([longueur_support_batterie,largeur_support_batterie,hauteur_support_batterie], center=true);
        
    translate([0,(diametre_couvercle-longueur_ci_charge)/2,hauteur_support_batterie/2+2*epaisseur+0.01])
    union(){
        cube([largeur_ci_charge,longueur_ci_charge,hauteur_support_batterie], center=true);
        translate([0,longueur_ci_charge/2,1-(hauteur_support_batterie-hauteur_usb)/2])
        #cube([largeur_usb,20,hauteur_usb], center=true);
    }
    
    translate([0,(diametre_couvercle-longueur_ci_charge),10/2+2*epaisseur+0.01])    cube([largeur_ci_charge,longueur_ci_charge,10], center=true);
    }
}

module switch(){
    
}

couvercle();
