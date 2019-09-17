longueur_batterie=53;
largeur_batterie=34;
longueur_boite = 28;
epaisseur_batterie=5.5;
epaisseur=2;
epaisseur_ci=1.5;
longueur_ci_charge = 28;
largeur_ci_charge = 17;
largeur_usb=8;
hauteur_usb = 3;
longueur_ci_pwm = 30;
largeur_ci_pwm = 21;
longueur_ci_step_up = 37;
largeur_ci_step_up = 17.5;
epaisseur_ci_step_up = 6;
longueur_led = 18;
largeur_led = 15;
longueur_bloc_led = 23.6;
largeur_bloc_led = 22.8;
epaisseur_bloc_led = 14.5;
longueur_couvercle = epaisseur_bloc_led+epaisseur+1;
longeur_hotshoe = 17.5;
epaisseur_rad = 1.6;


module boite_bas(){
    difference(){
        cube([longueur_batterie+2*epaisseur, largeur_batterie+2*epaisseur, longueur_boite], center=true);
        translate([0,0,epaisseur])
        cube([longueur_batterie, largeur_batterie, longueur_boite], center=true);
        translate([(largeur_ci_charge-longueur_batterie)/2,0,epaisseur_batterie+epaisseur-longueur_boite/2])
        rotate([0,0,180])
        #charge_ci();
        translate([-(longueur_ci_pwm-longueur_batterie+0.5)/2,0,epaisseur_batterie+epaisseur_ci/2+epaisseur-longueur_boite/2])
        #pwm();
        translate([0,0,epaisseur_batterie+epaisseur-longueur_boite/2+epaisseur_ci_step_up/2+epaisseur_ci/2+12])
        #step_up();
        
        translate([0,5-largeur_batterie/2,4*epaisseur-longueur_boite/2])
        rotate([90,0,0])
        cylinder(d=3, h=10, $fn=20);
        translate([0,5-largeur_batterie/2,4*epaisseur-longueur_boite/2+longeur_hotshoe/2])
        rotate([90,0,0])
        cylinder(d=3, h=10, $fn=20);
        
        translate([longueur_batterie/4,largeur_batterie/2+epaisseur+1,(longueur_boite-(4+epaisseur))/2])
        rotate([90,0,0])
        #cylinder(d=4, h=largeur_batterie+10, $fn=20);
        translate([-longueur_batterie/4,largeur_batterie/2+epaisseur+1,(longueur_boite-(4+epaisseur))/2])
        rotate([90,0,0])
        #cylinder(d=4, h=largeur_batterie+10, $fn=20);
        translate([-longueur_batterie/2-epaisseur-1,0,(longueur_boite-(4+epaisseur))/2])
        rotate([0,90,0])
        #cylinder(d=4, h=longueur_batterie+10, $fn=20);
    }
}

module couvercle(){
    difference(){
        union(){
            difference(){
                cube([longueur_batterie+4*epaisseur, largeur_batterie+4*epaisseur, longueur_couvercle], center=true);
                translate([0,0,-2*epaisseur])
                cube([longueur_batterie+2*epaisseur, largeur_batterie+2*epaisseur, longueur_couvercle], center=true);
                translate([0,0,longueur_couvercle/2])
                cube([longueur_led,largeur_led,10], center=true);
            
                translate([longueur_batterie/4,largeur_batterie/2+2*epaisseur+1,-(longueur_couvercle-(2+epaisseur))/2])
                rotate([90,0,0])
                cylinder(d=3, h=largeur_batterie+10, $fn=20);
                translate([-longueur_batterie/4,largeur_batterie/2+2*epaisseur+1,-(longueur_couvercle-(2+epaisseur))/2])
                rotate([90,0,0])
                cylinder(d=3, h=largeur_batterie+10, $fn=20);
                translate([-longueur_batterie/2-2*epaisseur-1,0,-(longueur_couvercle-(2+epaisseur))/2])
                rotate([0,90,0])
                cylinder(d=3, h=longueur_batterie+4*epaisseur+2, $fn=20);
        
                translate([0,0,(longueur_couvercle-epaisseur-epaisseur_bloc_led-epaisseur)/2+epaisseur/2])
                rotate([180,0,90])
                #led();
            }
            translate([(6+largeur_bloc_led)/2,0,(longueur_couvercle-epaisseur-4-epaisseur)/2+epaisseur/2])
            #cube([6,longueur_bloc_led,4],center=true);
            translate([-(3+largeur_bloc_led/2),0,(longueur_couvercle-epaisseur-4-epaisseur)/2+epaisseur/2])
            #cube([6,longueur_bloc_led,4],center=true);
        }
        translate([(largeur_bloc_led+6)/2,(longueur_bloc_led-4)/2-epaisseur_rad,(epaisseur_bloc_led-4)/2])
        cylinder(d=4, h=4, $fn=20, center=true);
        translate([-(largeur_bloc_led+6)/2,(longueur_bloc_led-4)/2-epaisseur_rad,(epaisseur_bloc_led-4)/2])
        cylinder(d=4, h=4, $fn=20, center=true);
        translate([(largeur_bloc_led+6)/2,-(longueur_bloc_led-4)/2+epaisseur_rad,(epaisseur_bloc_led-4)/2])
        cylinder(d=4, h=4, $fn=20, center=true);
        translate([-(largeur_bloc_led+6)/2,-(longueur_bloc_led-4)/2+epaisseur_rad,(epaisseur_bloc_led-4)/2])
        cylinder(d=4, h=4, $fn=20, center=true);
        
        translate([-(longueur_batterie-epaisseur)/2,-(largeur_batterie-epaisseur)/2,(longueur_couvercle-6)/2])
        cylinder(d=4, h=6, $fn=20, center=true);
        translate([-(longueur_batterie-epaisseur)/2,(largeur_batterie-epaisseur)/2,(longueur_couvercle-6)/2])
        cylinder(d=4, h=6, $fn=20, center=true);
        translate([(longueur_batterie-epaisseur)/2,-(largeur_batterie-epaisseur)/2,(longueur_couvercle-6)/2])
        cylinder(d=4, h=6, $fn=20, center=true);
        translate([(longueur_batterie-epaisseur)/2,(largeur_batterie-epaisseur)/2,(longueur_couvercle-6)/2])
        cylinder(d=4, h=6, $fn=20, center=true);
    }
}

module hotshoe(){
    epaisseur_plateau = 1.8;
    epaisseur_sup = 5;
    translate([0,0,-(epaisseur_sup+epaisseur_plateau)])
    difference(){
    union(){
        translate([0,0,epaisseur_plateau/2])
        cube([18.5,longeur_hotshoe,epaisseur_plateau], center=true);
        translate([0,0,epaisseur_sup/2+epaisseur_plateau])
        cube([11.5,longeur_hotshoe,epaisseur_sup], center=true);
    }
        translate([0,(longeur_hotshoe-4)/2-1.5*epaisseur-longeur_hotshoe/2,epaisseur_sup+epaisseur_plateau-3])
        cylinder(d=4, h=10, $fn=20);
        translate([0,(longeur_hotshoe-4)/2-1.5*epaisseur,epaisseur_sup+epaisseur_plateau-3])
        cylinder(d=4, h=10, $fn=20);
    }
}

module charge_ci(){
    translate([0,0,epaisseur_ci/2])
    union(){
        cube([largeur_ci_charge,longueur_ci_charge,epaisseur_ci], center=true);
        translate([0,longueur_ci_charge/2,(epaisseur_ci+hauteur_usb)/2])
        cube([largeur_usb,20,hauteur_usb], center=true);
    }
}

module pwm(){
    union(){
        cube([longueur_ci_pwm,largeur_ci_pwm,epaisseur_ci], center=true);
        translate([(8-longueur_ci_pwm)/2,0,5])
        cube([8,largeur_ci_pwm,10], center=true);
        translate([-(12-longueur_ci_pwm)/2,0,6])
        cube([12,10,12], center=true);
        translate([longueur_ci_pwm/2,0,(epaisseur_ci+12)/2])
        rotate([0,90,0])
        cylinder(d=7, h=10, $fn=420);
    }
}

module step_up(){
    cube([longueur_ci_step_up,largeur_ci_step_up,epaisseur_ci_step_up], center=true);
}

module led(){
    vide_rad = 4;    
    difference(){
    cube([longueur_bloc_led, largeur_bloc_led, epaisseur_bloc_led], center=true);
        
    translate([(longueur_bloc_led-vide_rad)/2-epaisseur_rad,0,(epaisseur_bloc_led-10)/2])
    cube([vide_rad, largeur_bloc_led+1, 10],center=true);
    translate([epaisseur_rad-(longueur_bloc_led-vide_rad)/2,0,(epaisseur_bloc_led-10)/2])
    cube([vide_rad, largeur_bloc_led+1, 10],center=true);
    translate([(longueur_bloc_led-vide_rad)/2-vide_rad-2*epaisseur_rad,0,(epaisseur_bloc_led-10)/2])
    cube([vide_rad, largeur_bloc_led+1, 10],center=true);
    translate([vide_rad+2*epaisseur_rad-(longueur_bloc_led-vide_rad)/2,0,(epaisseur_bloc_led-10)/2])
    cube([vide_rad, largeur_bloc_led+1, 10],center=true);
    }
}

module barre(){
    difference(){
        union(){
        cube([largeur_bloc_led+6,3.5,3.5], center=true);
        translate([(largeur_bloc_led+6)/2,0,0])
        cylinder(d=4.5, h=3.50, $fn=20, center=true);
        translate([-(largeur_bloc_led+6)/2,0,0])
        cylinder(d=4.5, h=3.5, $fn=20, center=true);    
        }
        translate([(largeur_bloc_led+6)/2,0,0])
        cylinder(d=3, h=10, $fn=20, center=true);
        translate([-(largeur_bloc_led+6)/2,0,0])
        cylinder(d=3, h=10, $fn=20, center=true);
    }
}

//boite_bas();
//translate([0,0,longueur_couvercle/2])
//couvercle();

//translate([0,-(largeur_batterie/2+epaisseur),1.5*epaisseur+(17.5-longueur_boite)/2])
//rotate([-90,0,0])
//hotshoe();

barre();
