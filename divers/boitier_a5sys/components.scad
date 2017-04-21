longueur_nodemcu = 57.75;
largeur_nodemcu = 31.25;
longueur_rfid = 60;
largeur_rfid = 40;
epaisseur_pcb = 1.5;
longueur_support_batterie = 76;
largeur_support_batterie = 21.5;
hauteur_support_batterie = 21;
diam_vis = 2.75;
diam_vis_head = 6.5;
longueur_alim_5V_2 = 34;
largeur_alim_5V_2 = 16;
longueur_alim_5V = 37.5;
largeur_alim_5V = 18;
longueur_charging_circuit = 28;
largeur_charging_circuit = 17.5;
longueur_circuit_buttons = 70;
largeur_circuit_buttons = 25;
longueur_switch = 8.5;
largeur_switch = 4.5;
hauteur_switch = 3.8;
diam_int_btn = 12.5;
diam_ext_btn = 17.5;

module push_button(color){
    translate([0,0,5.5])
    scale([1,1,0.5])
    color(color)
    sphere(d=diam_int_btn, $fn=50);
    color("black")
    union(){
        cylinder(d=diam_ext_btn, h=2, $fn=50);
        translate([0,0,2])
        cylinder(d1=diam_ext_btn, d2=diam_ext_btn-3, h=3.5, $fn=50);
        translate([0,0,-hauteur_btn])
        cylinder(d=diam_int_btn, h=hauteur_btn, $fn=50);
    }
}

module support_batterie(){
    epaisseur=1.5;
    translate([0,0,hauteur_support_batterie/2])
    union(){
        difference(){
            cube([longueur_support_batterie,largeur_support_batterie,hauteur_support_batterie], center=true);
            translate([0,0,1.5])
            cube([longueur_support_batterie-2*epaisseur,largeur_support_batterie-2*epaisseur,hauteur_support_batterie], center=true);
            cylinder(d=2, h=2*hauteur_support_batterie, $fn=20, center=true);
        }
        //translate([0,0,3])
        //rotate([0,90,0])
        //cylinder(d=18, h=65, $fn=50, center=true);
    }
}

module node_mcu(){
    nb_pins = 15;
    diam_hole = 3;
    difference(){
        cube([longueur_nodemcu, largeur_nodemcu, epaisseur_pcb], center=true);
        translate([(longueur_nodemcu-diam_hole)/2-0.5, (largeur_nodemcu-diam_hole)/2-0.5,0])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([(longueur_nodemcu-diam_hole)/2-0.5, -(largeur_nodemcu-diam_hole)/2+0.5,0])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([-(longueur_nodemcu-diam_hole)/2+0.5, (largeur_nodemcu-diam_hole)/2-0.5,0])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([-(longueur_nodemcu-diam_hole)/2+0.5, -(largeur_nodemcu-diam_hole)/2+0.5,0])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
    }
    translate([0,largeur_nodemcu/2-1,epaisseur_pcb/2+1])
     color("black")
     cube([38, 2, 2], center=true);
    for(pin = [1 : nb_pins]){
        translate([-38/2+pin*2.5-1,largeur_nodemcu/2-1,epaisseur_pcb/2+2])
        cylinder(d=0.5, h=5, $fn=10);
    }
    translate([0,-largeur_nodemcu/2+1,epaisseur_pcb/2+1])
     color("black")
     cube([38, 2, 2], center=true);
    
    for(pin = [1 : nb_pins]){
        translate([-38/2+pin*2.5-1,-largeur_nodemcu/2+1,epaisseur_pcb/2+2])
        cylinder(d=0.5, h=5, $fn=10);
    }
}

module rfid(){
    difference(){
        cube([longueur_rfid, largeur_rfid, epaisseur_pcb]);
        translate([7,7.5,-1])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([7,largeur_rfid-7.5,-1])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([44,2.5,-1])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([44,largeur_rfid-2.5,-1])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
    }
}

module charging_circuit() {
    difference(){
    cube([longueur_charging_circuit,largeur_charging_circuit,epaisseur_pcb]);
        translate([longueur_charging_circuit-1,3,-1])
    cube([2,largeur_charging_circuit-6,epaisseur_pcb+2]);
    }
    translate([0,(largeur_charging_circuit-8)/2,epaisseur_pcb])
    cube([5.5,8,3]);
}

module alim_5V_2() {
    difference(){
    cube([longueur_alim_5V_2,largeur_alim_5V_2,epaisseur_pcb]);
    translate([23.5,1.5,-1])
    cylinder(d=2, h=3*epaisseur_pcb, $fn=20);
    translate([23.5,largeur_alim_5V_2-1.5,-1])
    cylinder(d=2, h=3*epaisseur_pcb, $fn=20);
    }
}

module alim_5V() {
    cube([longueur_alim_5V,largeur_alim_5V,epaisseur_pcb]);
}


module switch(){
    nb_pins = 3;
    cube([longueur_switch,hauteur_switch,largeur_switch]);
    translate([2,-3,(hauteur_switch-1.5)/2])
    cube([1.5,3,1.5]);
    for(pin = [1 : nb_pins]){
        translate([pin*2.5-1,10,hauteur_switch/2])
        rotate([90,0,0])
        cylinder(d=0.5, h=6.2, $fn=10);
    }
}

module circuit_buttons(){
    cube([longueur_circuit_buttons,largeur_circuit_buttons,epaisseur_pcb], center=true);
}

module vis(){
    cylinder(d=diam_vis, h=20, $fn=50);
    cylinder(d1=diam_vis_head, d2=diam_vis, h=2, $fn=50);
}

module prisme(x,y,z){
    rotate([0,-90,-90])
    linear_extrude(height = y, center = true) {
    polygon(points = [[0, 0], [z, 0],[0, x]], paths = [[0, 1, 2]]);
    }
}
