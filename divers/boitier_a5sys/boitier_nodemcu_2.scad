include <components.scad>;
with_magnet = false;
epaisseur = 1.5;
hauteur_btn = 15;
rayon_accroche = 3.5; 
marge_cablage = 20;
largeur_support_node_mcu = largeur_nodemcu+10;
hauteur_boite = hauteur_btn+largeur_support_node_mcu;
largeur_boite = largeur_rfid+2*epaisseur+4*rayon_accroche;
longueur_boite = longueur_support_batterie+5*epaisseur+2*rayon_accroche+marge_cablage;
epaisseur_aimant = 1;
diam_aimant = 8.5;


module accroche(r1, r2, hauteur_accroche){
    difference(){
        cylinder (r=r1, h=hauteur_accroche, $fn=50);
        cylinder (r=r2, h=hauteur_accroche+1, $fn=50);
    }
}

module cube_arrondi(longueur, largeur, hauteur){
    minkowski(){
        cube([longueur-2*rayon_accroche, largeur-2*rayon_accroche, hauteur-1], center=true);
        cylinder(r=rayon_accroche, h=1, $fn=50, center=true);
    }
}

module boite_arrondie(longueur, largeur, hauteur){
    difference(){
        cube_arrondi(longueur, largeur, hauteur);
        translate([0,0,epaisseur+0.1])
        cube_arrondi(longueur-2*epaisseur, largeur-2*epaisseur, hauteur);
    }
}

module boite_base(longueur_boite, largeur_boite, hauteur_boite){
    boite_arrondie(longueur_boite,largeur_boite,hauteur_boite);
    
    translate([longueur_boite/2-rayon_accroche,largeur_boite/2-rayon_accroche,-hauteur_boite/2])
    color("blue")
    accroche(rayon_accroche, diam_vis/2, hauteur_boite);
    
    translate([-(longueur_boite/2-rayon_accroche),largeur_boite/2-rayon_accroche,-hauteur_boite/2])
    color("blue")
    accroche(rayon_accroche, diam_vis/2, hauteur_boite);

    translate([-(longueur_boite/2-rayon_accroche),-(largeur_boite/2-rayon_accroche),-hauteur_boite/2])
    color("blue")
    accroche(rayon_accroche, diam_vis/2, hauteur_boite);

    translate([(longueur_boite/2-rayon_accroche),-(largeur_boite/2-rayon_accroche),-hauteur_boite/2])
    color("blue")
    accroche(rayon_accroche, diam_vis/2, hauteur_boite);
}

module rainure(profondeur){
    largeur = largeur_boite-2*epaisseur;
    translate([0,-(largeur-epaisseur)/2,0])
    difference(){
        union(){
            cube([3*epaisseur, epaisseur, hauteur_boite], center=true);
            translate([0,largeur-epaisseur,0])
            cube([3*epaisseur, epaisseur, hauteur_boite], center=true);
        }
        translate([0,(largeur-epaisseur)/2,-(hauteur_boite-profondeur)])
        cube([epaisseur,largeur,hauteur_boite], center=true);
    }
}

module support_node_mcu(){
    diam_hole = 2.5;
    difference(){
        cube([largeur_boite-2*epaisseur, largeur_support_node_mcu, epaisseur], center=true);
        translate([0,largeur_nodemcu/2-1,0])
        #cube([39, 3, 3], center=true);
        translate([0,-largeur_nodemcu/2+1,0])
        #cube([39, 3, 3], center=true);
    }
    translate([(longueur_nodemcu-diam_hole)/2-1, (largeur_nodemcu-diam_hole)/2-1,-(epaisseur+2*epaisseur_pcb)/2])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([(longueur_nodemcu-diam_hole)/2-1, -(largeur_nodemcu-diam_hole)/2+1,-(epaisseur+2*epaisseur_pcb)/2])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([-(longueur_nodemcu-diam_hole)/2+1, (largeur_nodemcu-diam_hole)/2-1,-(epaisseur+2*epaisseur_pcb)/2])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
        translate([-(longueur_nodemcu-diam_hole)/2+1, -(largeur_nodemcu-diam_hole)/2+1,-(epaisseur+2*epaisseur_pcb)/2])
        cylinder(d=diam_hole, h=2*epaisseur_pcb, $fn=50, center=true );
    
//    translate([0,0,-epaisseur_pcb])
//    #node_mcu();
}

module support_rfid(){
    translate([0,0,epaisseur])
    #rfid();
    union(){
        cube([longueur_rfid, largeur_rfid, epaisseur_pcb]);
        translate([7,7,epaisseur_pcb])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([7,largeur_rfid-7,epaisseur_pcb])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([44,2,epaisseur_pcb])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
        translate([44,largeur_rfid-2,epaisseur_pcb])
        cylinder(d=2.5, h=2*epaisseur_pcb, $fn=50);
    }
}

module couvercle_base(longueur_couvercle, largeur_couvercle, hauteur_couvercle){
    translate([0, 0, epaisseur/2])
    difference(){
        boite_base(longueur_couvercle, largeur_couvercle, hauteur_couvercle);
        
        translate([longueur_couvercle/2-rayon_accroche,largeur_couvercle/2-rayon_accroche,-hauteur_couvercle/2])
    color("blue")
    vis();
    
    translate([-(longueur_couvercle/2-rayon_accroche),largeur_couvercle/2-rayon_accroche,-hauteur_couvercle/2])
    color("blue")
    vis();

    translate([-(longueur_couvercle/2-rayon_accroche),-(largeur_couvercle/2-rayon_accroche),-hauteur_couvercle/2])
    color("blue")
    vis();

    translate([(longueur_couvercle/2-rayon_accroche),-(largeur_couvercle/2-rayon_accroche),-hauteur_couvercle/2])
    color("blue")
    vis();
    }
}

module push_buttons_pack(){
    diam_button = 12;
    rotate([0,0,45])
    union(){
    translate([diam_button,diam_button,0])
    #push_button("blue");
    translate([diam_button,-diam_button,0])
    #push_button("green");
    translate([-diam_button,diam_button,0])
    #push_button("red");
    translate([-diam_button,-diam_button,0])
    #push_button("yellow");
    }
}

module boite_complete(){
    space_btw_btn = longueur_boite/5;
    difference(){
        union(){
            rotate([180,0,0])
            boite_base(longueur_boite, largeur_boite, hauteur_boite);
            translate([epaisseur+2*rayon_accroche-longueur_boite/2,0,0])
            rainure(largeur_support_node_mcu+1);
            translate([epaisseur+2*rayon_accroche-longueur_boite/2+marge_cablage,0,0])
            rainure(largeur_circuit_buttons/2+hauteur_support_batterie);
            
        translate([longueur_boite/2-longueur_rfid-2*epaisseur,largeur_rfid/2,hauteur_boite/2])
            rotate([180,0,0])
            support_rfid();
        }
        
        translate([30-longueur_boite/2,0,26.51])
        push_buttons_pack();
        
        translate([longueur_boite/2-epaisseur-0.1,-largeur_boite/2+2*rayon_accroche+largeur_support_batterie+3*epaisseur+(largeur_charging_circuit-8)/2,-hauteur_boite/2-0.1])
        cube([5.5,8,3+epaisseur_pcb]);
        
        translate([longueur_boite/2-epaisseur-0.1,-largeur_boite/2+2*rayon_accroche+largeur_support_batterie+5*epaisseur+largeur_charging_circuit+3/2,-hauteur_boite/2-0.1])
        cube([2*epaisseur,longueur_switch-3,hauteur_switch-1]);
    }
    translate([longueur_boite/2-epaisseur-0.1,-largeur_boite/2+2*rayon_accroche+largeur_support_batterie+5*epaisseur+largeur_charging_circuit+longueur_switch/2,-hauteur_boite/2+hauteur_switch])
    rotate([0,0,180])
    prisme(hauteur_switch,longueur_switch,sin(60)*hauteur_switch);
    translate([longueur_boite/2-epaisseur-0.1,-largeur_boite/2+2*rayon_accroche+largeur_support_batterie+3*epaisseur+(largeur_charging_circuit)/2,-hauteur_boite/2+hauteur_switch])
    rotate([0,0,180])
    prisme(5.5,8,sin(60)*5.5);
}

module couvercle_aimant(longueur_couvercle, largeur_couvercle){
    translate([0,0,10/2-epaisseur_aimant])
    difference(){
        cube_arrondi(longueur_boite, largeur_boite, 10);
        translate([0,0,(epaisseur_aimant+0.1)/2])
        cube([longueur_boite+2, largeur_boite+2, 10.1-epaisseur_aimant],center=true);
        
        translate([longueur_couvercle/2-rayon_accroche,largeur_couvercle/2-rayon_accroche,-5.5])
    color("blue")
    cylinder(d=diam_vis_head, h=11, $fn=50);
    
    translate([-(longueur_couvercle/2-rayon_accroche),largeur_couvercle/2-rayon_accroche,-5.5])
    color("blue")
    cylinder(d=diam_vis_head, h=11, $fn=50);

    translate([-(longueur_couvercle/2-rayon_accroche),-(largeur_couvercle/2-rayon_accroche),-5.5])
    color("blue")
    cylinder(d=diam_vis_head, h=11, $fn=50);

    translate([(longueur_couvercle/2-rayon_accroche),-(largeur_couvercle/2-rayon_accroche),-5.5])
    color("blue")
    cylinder(d=diam_vis_head, h=11, $fn=50);
        
        translate([-longueur_boite/4,0,0])
    color("blue")
        cube([20,10,11],center= true);
        translate([longueur_boite/4,0,0])
    color("blue")
        cube([20,10,11],center= true);
        
        translate([longueur_couvercle/2-3*rayon_accroche,largeur_couvercle/2-2*rayon_accroche,-5.5])
    color("blue")
    cylinder(d=diam_aimant, h=11, $fn=50);
    
    translate([-(longueur_couvercle/2-3*rayon_accroche),largeur_couvercle/2-2*rayon_accroche,-5.5])
    color("blue")
    cylinder(d=diam_aimant, h=11, $fn=50);

    translate([-(longueur_couvercle/2-3*rayon_accroche),-(largeur_couvercle/2-2*rayon_accroche),-5.5])
    color("blue")
    cylinder(d=diam_aimant, h=11, $fn=50);

    translate([(longueur_couvercle/2-3*rayon_accroche),-(largeur_couvercle/2-2*rayon_accroche),-5.5])
    color("blue")
    cylinder(d=diam_aimant, h=11, $fn=50);
        
        translate([-longueur_boite/4,0,0])
    color("blue")
        cube([20,10,11],center= true);
        translate([longueur_boite/4,0,0])
    color("blue")
        cube([20,10,11],center= true);
    }
}

module couvercle_complet(){
    if(with_magnet){        
        couvercle_aimant(longueur_boite, largeur_boite);
    }
    couvercle_base(longueur_boite, largeur_boite, epaisseur);
    
    
    translate([(longueur_boite-longueur_support_batterie)/2-2*epaisseur,-((largeur_boite-largeur_support_batterie)/2-epaisseur-2*rayon_accroche),epaisseur])
    union(){
        //#support_batterie();
        cylinder(d=2, h=2*epaisseur, $fn=30);
        translate([0,(largeur_support_batterie+epaisseur)/2,epaisseur/2])
        cube([longueur_support_batterie, epaisseur, epaisseur], center=true);
        translate([0,-(largeur_support_batterie+epaisseur)/2,epaisseur/2])
        cube([longueur_support_batterie, epaisseur, epaisseur], center=true);
    }
    
    translate([epaisseur-longueur_boite/2,-largeur_boite/2+epaisseur+2*rayon_accroche,epaisseur])
    union(){
        #charging_circuit();
        translate([0,-epaisseur,0])
        cube([longueur_charging_circuit, epaisseur, 2*epaisseur]);
        translate([0,largeur_charging_circuit,0])
        cube([longueur_charging_circuit, epaisseur, 2*epaisseur]);
        translate([longueur_charging_circuit-epaisseur,2,0])
        cube([1,largeur_charging_circuit-4,epaisseur]);
        translate([longueur_charging_circuit-epaisseur,0,epaisseur])
        cube([1,largeur_charging_circuit,epaisseur]);
    }
    
    translate([longueur_alim_5V/2,-largeur_boite/2+largeur_support_batterie+3*epaisseur+2*rayon_accroche+largeur_alim_5V,epaisseur])
    rotate([0,0,180])
//    union(){
//        # translate([0,0,epaisseur_pcb]) alim_5V_2();
//        difference(){
//            alim_5V_2();
//            translate([20,0,0])
//            cube([1.5,largeur_alim_5V_2, epaisseur_pcb]);
//            cube([1.5,largeur_alim_5V_2, epaisseur_pcb]);
//        }
//        translate([23.5,1.5,])
//        cylinder(d=2, h=3*epaisseur_pcb, $fn=20);
//        translate([23.5,largeur_alim_5V_2-1.5,])
//        cylinder(d=2, h=3*epaisseur_pcb, $fn=20);
//    }
    union(){
        //#alim_5V();
        difference(){
            translate([-epaisseur, -epaisseur, 0])
        cube([longueur_alim_5V+2*epaisseur, largeur_alim_5V+2*epaisseur, epaisseur]);
            cube([longueur_alim_5V, largeur_alim_5V, 2*epaisseur]);
        }
    }
    
    translate([longueur_boite/2-epaisseur,-largeur_boite/2+largeur_support_batterie+5*epaisseur+2*rayon_accroche+largeur_charging_circuit,epaisseur])
    union(){
        //#rotate([0,0,90]) switch();
        translate([-hauteur_switch,-epaisseur,0])
        cube([hauteur_switch,epaisseur,4]);
        translate([-(epaisseur+hauteur_switch),-epaisseur,0])
        cube([epaisseur,epaisseur+1,4]);
        translate([-hauteur_switch,longueur_switch,0])
        cube([hauteur_switch,epaisseur,4]);
        translate([-(epaisseur+hauteur_switch),longueur_switch-1,0])
        cube([epaisseur,epaisseur+1,4]);
    }
}

translate([0,0,hauteur_boite/2])
boite_complete();

//translate([epaisseur+2*rayon_accroche-longueur_boite/2+marge_cablage,0,hauteur_boite-(largeur_circuit_buttons/2+hauteur_support_batterie)])
//rotate([90,0,90])
//#circuit_buttons();

translate([0,100,-5])
couvercle_complet();

//translate([epaisseur+2*rayon_accroche-longueur_boite/2,0,largeur_support_node_mcu/2])
//rotate([90,0,90])
//support_node_mcu();


