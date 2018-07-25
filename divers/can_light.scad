diametre_couvercle = 85.5;
hauteur_couvercle = 11;
hauteur_support_batterie = 22;
longueur_support_batterie = 76.5;
largeur_support_batterie = 21;
epaisseur = 2;
longueur_ci_charge = 28;
largeur_ci_charge = 17;

largeur_usb=8;
hauteur_usb = 3;
longueur_switch = 16;
longueur_max_switch = 24;
largeur_switch = 7.5;
profondeur_switch = 7.5;
longueur_switch_btn = 10;
largeur_switch_btn = 4;

module couvercle() {
    hauteur_totale = hauteur_couvercle+hauteur_support_batterie+epaisseur;
    difference(){
        cylinder(d=diametre_couvercle+2*epaisseur, h=hauteur_totale, $fn=100);
        translate([0,0,hauteur_support_batterie+epaisseur+0.01])
        cylinder(d=diametre_couvercle, h=hauteur_couvercle, $fn=100);
        translate([0,0,hauteur_support_batterie+epaisseur-hauteur_couvercle+0.01])
        cylinder(d=diametre_couvercle-25, h=hauteur_couvercle, $fn=100);
    
    translate([0,0,hauteur_support_batterie/2+epaisseur+0.01])
    cube([longueur_support_batterie,largeur_support_batterie,hauteur_support_batterie], center=true);
        
    translate([0,(diametre_couvercle-epaisseur-longueur_ci_charge)/2,(hauteur_usb+2*epaisseur)/2+2*epaisseur+0.01])
    charge_ci();
    
    translate([0,(diametre_couvercle+epaisseur+longueur_ci_charge)/2-0.5,(hauteur_usb+largeur_switch_btn+3*epaisseur)/2+2*epaisseur])    #cube([longueur_max_switch,longueur_ci_charge,hauteur_usb+largeur_switch_btn+3*epaisseur], center=true);
    
    translate([0,(diametre_couvercle-epaisseur)/2,largeur_switch/2+3*epaisseur+hauteur_usb])
        union(){
    switch();
            translate([0,-longueur_ci_charge/2,(hauteur_support_batterie-2*epaisseur-hauteur_usb-largeur_switch)/2+0.01])
            #cube([longueur_max_switch,longueur_ci_charge,hauteur_support_batterie-2*epaisseur-hauteur_usb], center=true);
        }
        for (a =[0:3])
        rotate([0,0,45+a*90])
        translate([0,diametre_couvercle/2-3*epaisseur,hauteur_totale-hauteur_support_batterie-hauteur_couvercle+0.01])
        #cylinder(d=3, h=hauteur_support_batterie, $fn=20);
    }
    
}

module charge_ci(){
    hauteur = hauteur_usb+2*epaisseur;
    union(){
        cube([largeur_ci_charge,longueur_ci_charge,hauteur], center=true);
        translate([0,longueur_ci_charge/2,1-(hauteur-hauteur_usb)/2])
        #cube([largeur_usb,20,hauteur_usb], center=true);
    }
}

module switch(){
    rotate([0,0,180])
    union(){
    translate([0,profondeur_switch/2,0])
    cube([longueur_switch,profondeur_switch,largeur_switch], center=true);
    translate([0,1/2,0])
    cube([longueur_max_switch,1,largeur_switch], center=true);
    translate([0,-profondeur_switch/2,0])
    cube([longueur_switch_btn,profondeur_switch,largeur_switch_btn], center=true);
        translate([longueur_max_switch/2-(longueur_max_switch-longueur_switch)/4,0,0])
        rotate([90,0,0])
        cylinder(d=2, h=20, $fn=20, center=true);
        translate([-(longueur_max_switch/2-(longueur_max_switch-longueur_switch)/4),0,0])
        rotate([90,0,0])
        cylinder(d=2, h=20, $fn=20, center=true);
    }
}

couvercle();
