longueur_slot = 97;
hauteur_slot = 33;
profondeur_slot = 120;
epaisseur = 2;

largeur_rj45 = 16;
profondeur_rj45 = 30;
hauteur_rj45 = 13.5;

largeur_usb = 13.5;
profondeur_usb = 30;
hauteur_usb = 15;

module advanced_slot() {
difference(){
    simple_slot();
    translate([3*epaisseur-36.86,profondeur_slot/2-126,-2.6])
    #cube([largeur_rj45, profondeur_rj45, hauteur_rj45], center = true);
    
    translate([3*epaisseur-18.15,profondeur_slot/2-126,-1.85])
    #cube([largeur_usb, profondeur_usb, hauteur_usb], center = true);
    
    translate([3*epaisseur-0.15,profondeur_slot/2-126,-1.85])
    #cube([largeur_usb, profondeur_usb, hauteur_usb], center = true);
    
    translate([-longueur_slot/3,epaisseur-profondeur_slot/2,11])
    rotate([0,0,180])
    #switch();
}
//RPI
translate([11.25,146-profondeur_slot,epaisseur-hauteur_slot/2])
support();
translate([11.25-49,146-profondeur_slot,epaisseur-hauteur_slot/2])
support();
translate([11.25,146-58-profondeur_slot,epaisseur-hauteur_slot/2])
support();
translate([11.25-49,146-58-profondeur_slot,epaisseur-hauteur_slot/2])
support();

//LM2596
translate([25,158.5-profondeur_slot,epaisseur-hauteur_slot/2])
support();
translate([25-30.25,158.5+16-profondeur_slot,epaisseur-hauteur_slot/2])
support();

translate([(longueur_slot-60)/2,-60/2,0])
ailette();
translate([(longueur_slot+3)/2,-(profondeur_slot-3)/2,4+(6-hauteur_slot)/2])
cube([3,3,6], center=true);
translate([-(longueur_slot+3)/2,-(profondeur_slot-3)/2,4+(6-hauteur_slot)/2])
cube([3,3,6], center=true);

translate([(longueur_slot-3*1.6)/2, 0, epaisseur-(hauteur_slot-6)/2])
        cube([1.6, profondeur_slot, 6], center=true);
        translate([-(longueur_slot-3*1.6)/2, 0, epaisseur-(hauteur_slot-6)/2])
        cube([1.6, profondeur_slot, 6], center=true);
}

module full_slot() {
    difference(){
        advanced_slot();
        translate([(longueur_slot-30)/2-3*epaisseur/2, epaisseur-(profondeur_slot-10)/2, (hauteur_slot-epaisseur-30)/2])
        rotate([90,0,0])
        fan();    
    
        translate([(longueur_slot-1.6)/2, 3, -(hauteur_slot-6)/2])
        cube([1.6, profondeur_slot, 6], center=true);
        translate([-(longueur_slot-1.6)/2, 3, -(hauteur_slot-6)/2])
        cube([1.6, profondeur_slot, 6], center=true);
        
        translate([-(longueur_slot-20)/2,(100)/2,0])
        #cube([20,profondeur_slot-100,hauteur_slot], center=true);
    }
}

module simple_slot(){
    difference(){
        cube([longueur_slot, profondeur_slot, hauteur_slot], center=true);
    translate([0, epaisseur, epaisseur])
        cube([longueur_slot-2*epaisseur, profondeur_slot, hauteur_slot], center=true);
    }
}

module support() {
    difference(){
        cylinder(d1=9, d2=5, h=3.75, $fn=20);
        cylinder(d=3, h=4, $fn=20);
        translate([0,0,3.75-3])
        cylinder(d=4, h=3, $fn=20);
    }
}

module ailette() {
    scale([1,1.5,1])
    difference() {
        cylinder(d=60, h=hauteur_slot, center=true, $fn=50);
        cylinder(d=56, h=hauteur_slot+1, center=true, $fn=50);
        translate([30,-30,0])
        cube([60,60,hauteur_slot+1], center=true);
        translate([-30,-30,0])
        cube([60,60,hauteur_slot+1], center=true);
        translate([-30,30,0])
        cube([60,60,hauteur_slot+1], center=true);
        translate([30-5,0,5-hauteur_slot/2])
        rotate([90,0,0])
        cylinder(d=2.5, h=50, $fn=10, center=true);
    }
}

module fan(){
    cube([30,30,10], center=true);
    translate([24/2,24/2,0])
    cylinder(d=3, h=20, $fn=20, center=true);
    translate([24/2,-24/2,0])
    cylinder(d=3, h=20, $fn=20, center=true);
    translate([-24/2,-24/2,0])
    cylinder(d=3, h=20, $fn=20, center=true);
    translate([-24/2,24/2,0])
    cylinder(d=3, h=20, $fn=20, center=true);
    difference(){
        cylinder(d=27, h=20, $fn=20, center=true);
        cylinder(d=17, h=20, $fn=20, center=true);
        rotate([0,0,45])
        cube([2, 30, 20], center=true);
        rotate([0,0,-45])
        cube([2, 30, 20], center=true);
    }
}

module switch(){    
    longueur_switch = 16;
    longueur_max_switch = 24;
    largeur_switch = 7.5;
    profondeur_switch = 7.5;
    longueur_switch_btn = 10;
    largeur_switch_btn = 4;
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

full_slot();
//translate([3*epaisseur-longueur_slot/2, -profondeur_slot/2 - 7.75+100, 2*epaisseur-hauteur_slot/2])
//rotate([0,0,-90])
//import("Raspberry_Pi_3_Light_Version.STL");
//translate([40-longueur_slot/2, 52-profondeur_slot/2, 2+2*epaisseur-hauteur_slot/2])
//import("LM2596_DC-DC_Buck_Converter_Board.stl");