angle = 70;
epaisseur = 2;
marge = 10;

hauteur_alim = 80;
longueur_alim = 140;
largeur_alim = 150;

hauteur_poignee = 50;

hauteur_totale = hauteur_alim + hauteur_poignee;

largeur = largeur_alim;
bordure = 30;
longueur_prisme = hauteur_totale / tan(angle);

longueur_lcd = 22;
longueur_lcd_pcb = 30;
hauteur_lcd = 10;
epaisseur_lcd = 5;

diam_ext_banana = 10;
diam_int_banana = 5;

diam_ext_bnc = 10;
diam_int_bnc = 5;

diam_ext_potentiometre = 12;
diam_int_potentiometre = 5;

diam_int_power_btn = 10;

epaisseur_pcb = 1.5;
espace = 15;

ecart_europlug = 19;
largeur_banana_pair = ecart_europlug+2*diam_ext_banana;
hauteur_tension = 21;

longueur_usb = 15;
hauteur_usb = 8;

diam_vis = 2.5;

module alim(){
    color("grey")
    translate([-longueur_alim/2,0,hauteur_alim/2])
    cube([longueur_alim,largeur_alim,hauteur_alim],center=true);
}

module accroche(long){
    rotate([0,90,0])
    difference(){
        cylinder(r=diam_vis, h=long, $fn=50);
        translate([0,0,-2])
        cylinder(d=diam_vis, h=long, $fn=50);
    }
}

module prisme(x,y,z){
    rotate([0,-90,-90])
    linear_extrude(height = y, center = true) {
    polygon(points = [[0, 0], [z, 0],[0, x]], paths = [[0, 1, 2]]);
    }
}

module lcd_screen(){
    translate([-hauteur_lcd/2,0,-epaisseur_lcd])
    union(){
        color("White")
        cube([hauteur_lcd, longueur_lcd, epaisseur_lcd]);
        translate([0,-(longueur_lcd_pcb-longueur_lcd)/2,-epaisseur_pcb])
        color("Green")
        cube([hauteur_lcd, longueur_lcd_pcb, epaisseur_pcb]);
    }
}

module accroche_lcd(){
    translate([0,marge-largeur_alim/2,0])
    union(){
        difference(){
            cylinder(r1=2, r2=3, h=hauteur_lcd, $fn=25);
            cylinder(d=2, h=hauteur_lcd, $fn=25);
        }
        translate([0,longueur_lcd_pcb,0])
        difference(){
            cylinder(r1=2, r2=3, h=hauteur_lcd, $fn=25);
            cylinder(d=2, h=hauteur_lcd, $fn=25);
        }
    }
}

module bnc(){
    color("Grey")
    union(){
        cylinder(d=diam_ext_bnc, h=10, $fn=50);
        translate([0,0,-10])
        cylinder(d=diam_int_bnc, h=10, $fn=50);
    }
}

module banana(){
    cylinder(d=diam_ext_banana, h=10, $fn=50);
    translate([0,0,-10])
    cylinder(d=diam_int_banana, h=10, $fn=50);
}

module banana_pair(){
    color("Red")
    banana();
    translate([0,ecart_europlug,0])
    color("Black")
    banana();
}

module potentiometre(){
    color("Black")
    cylinder(d=diam_ext_potentiometre, h=10, $fn=50);
    color("White")
    translate([-diam_ext_potentiometre/2,0,5])
    rotate([0,0,45])
    cube([2,2,10], center=true);
    translate([0,0,-10])
    cylinder(d=diam_int_potentiometre, h=10, $fn=50);
}

module power_btn(){
    cylinder(d=diam_int_power_btn, h=10, $fn=50, center=true);
}

module usb(){
    cube([longueur_usb, 10, hauteur_usb]);
}

module tension(adjustable){    
    translate([0,-largeur_alim/2,0])
    rotate([0,angle,0])
    union(){
        translate([0,marge,0])
        lcd_screen();
        if(adjustable){
        translate([0,marge+longueur_lcd_pcb+espace,0])
        potentiometre();
        }
        translate([0,marge+longueur_lcd_pcb+diam_ext_potentiometre+2*espace,0])
        banana_pair();
        translate([0,marge+longueur_lcd_pcb+largeur_banana_pair+3*espace,0])
        bnc();
        //translate([-hauteur_tension/2,0,-epaisseur])
        //cube([hauteur_tension,largeur_alim,epaisseur]);
    }
}

module tension_position(rang, adjustable){
    tension_x = cos(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    tension_z = sin(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    translate([bordure+tension_x, 0, hauteur_totale-tension_z])
    tension(adjustable);
}

module boitier_prisme(){
    difference(){
        prisme(longueur_prisme, largeur, hauteur_totale);
        translate([-epaisseur, 0, epaisseur])
        prisme(longueur_prisme-epaisseur, largeur-2*epaisseur, hauteur_totale);
    }
}

module boitier_base(){
    translate([bordure,0,0])
    boitier_prisme();
    translate([0,-largeur/2,0])
    difference(){
        cube([bordure, largeur, hauteur_totale]);
        translate([0,epaisseur,epaisseur])
        cube([2*bordure, largeur-2*epaisseur, hauteur_alim-epaisseur]);
        translate([epaisseur,epaisseur,hauteur_alim])
        cube([2*bordure, largeur-2*epaisseur, hauteur_poignee-epaisseur]);
        translate([-epaisseur,-epaisseur,hauteur_alim])
        cube([2*epaisseur, largeur+2*epaisseur, hauteur_poignee+epaisseur]);
    }
}

module boitier_perce(){
    difference(){
        boitier_base();
        tension_position(1);
        tension_position(2);
        tension_position(3);
        tension_position(4, true);
        tension_position(5, true);
        
        btn_z = hauteur_totale-20;
        btn_x = btn_z/tan(angle);

        translate([bordure+btn_x, 0, hauteur_totale-btn_z])
        rotate([0,angle,0])
        power_btn();
    }
    
    
    translate([0, largeur_alim/2-diam_vis-epaisseur/2, diam_vis+epaisseur/2])
    accroche(20);
    translate([0, -(largeur_alim/2-diam_vis-epaisseur/2), diam_vis+epaisseur/2])
    accroche(20);
    translate([0, 0, diam_vis+epaisseur/2])
    accroche(20);
    translate([0, largeur_alim/2-diam_vis-epaisseur/2,  hauteur_alim-diam_vis])
    accroche(20);
    translate([0, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_alim-diam_vis])
    accroche(20);
    
    translate([epaisseur, largeur_alim/2-diam_vis-epaisseur/2, hauteur_alim+diam_vis+epaisseur/2])
    accroche(20);
    translate([epaisseur, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_alim+diam_vis+epaisseur/2])
    accroche(20);
    translate([epaisseur, largeur_alim/2-diam_vis-epaisseur/2, hauteur_totale-(diam_vis+epaisseur/2)])
    accroche(20);
    translate([epaisseur, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_totale-(diam_vis+epaisseur/2)])
    accroche(20);
}

module poignee(){
    
}

rotate([0,angle,0]) accroche_lcd();
boitier_perce();
//alim();
