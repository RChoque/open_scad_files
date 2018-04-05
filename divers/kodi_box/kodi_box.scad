epaisseur = 2;
marge = 6;
rayon_courbe = 4;

diam_tete_vis = 8;
diam_corps_vis = 4;
cote_support_couvercle = 1.5*diam_tete_vis;
//USB
largeur_usb = 15;
profondeur_usb = 30;
hauteur_usb = 17;
diam_vis = 3;
ecartement_vis_usb = 30;
//HDMI
largeur_hdmi = 15.5;
profondeur_hdmi = 30;
hauteur_hdmi = 6.5;
diam_vis = 3;
ecartement_vis_hdmi = 27;
//RJ45
largeur_rj45 = 16.5;
profondeur_rj45 = 30;
hauteur_rj45 = 13.5;
diam_vis = 3;
ecartement_vis_rj45 = 27.5;
//ALIM
diam_alim = 12;
//PWR_BTN
diam_bouton = 16.5;
//BOITE
longueur_facade_arriere = (ecartement_vis_rj45+diam_corps_vis)+(ecartement_vis_hdmi+diam_corps_vis)+diam_alim+5*marge;
longueur_facade_avant = 2*(ecartement_vis_usb+diam_corps_vis)+3*marge;
hauteur_facade = 25;
longueur_boite = longueur_facade_avant+2*cote_support_couvercle+diam_bouton+5*marge;
largeur_boite = 140;
hauteur_boite = 50;


module dual_usb() {
    cube([largeur_usb, profondeur_usb, hauteur_usb], center = true);
    translate([-ecartement_vis_usb/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_usb, $fn=100, center=true);
    translate([ecartement_vis_usb/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_usb, $fn=100, center=true);
}

module facade_usb() {
    difference(){
        cube([longueur_facade_avant, epaisseur, hauteur_facade], center=true);
        translate([-ecartement_vis_usb/2-marge, 0, 0])
        dual_usb();
        translate([ecartement_vis_usb/2+marge, 0, 0])
        dual_usb();
    }
}

module rj45() {
    cube([largeur_rj45, profondeur_rj45, hauteur_rj45], center = true);
    translate([-ecartement_vis_rj45/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_rj45, $fn=100, center=true);
    translate([ecartement_vis_rj45/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_rj45, $fn=100, center=true);
}

module hdmi() {
    cube([largeur_hdmi, profondeur_hdmi, hauteur_hdmi], center = true);
    translate([-ecartement_vis_hdmi/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_hdmi, $fn=100, center=true);
    translate([ecartement_vis_hdmi/2, 0, 0])
    rotate([90,0,0])
    cylinder(d=diam_vis, h=profondeur_hdmi, $fn=100, center=true);
}

module facade_arriere() {
    difference(){
        cube([longueur_facade_arriere, epaisseur, hauteur_facade], center=true);
        translate([-longueur_facade_arriere/2+ecartement_vis_rj45/2+marge, 0, 0])
        rj45();
        translate([-longueur_facade_arriere/2+ecartement_vis_rj45+ecartement_vis_hdmi/2+3*marge, 0, 0])
        hdmi();
        translate([-longueur_facade_arriere/2+ecartement_vis_rj45+ecartement_vis_hdmi+diam_alim/2+5*marge, 0, 0])
        #alim();
    }
}

module bouton_power() {
    cylinder(d=diam_bouton, h=10, $fn=100, center=true);
}

module alim() {
    rotate([90,0,0])
    difference(){
        cylinder(d=diam_alim, h=10, $fn=100, center=true);
        translate([0,(diam_alim+10.5)/2,0])
        cube([diam_alim,diam_alim,10],center = true);
        translate([0,-(diam_alim+10.5)/2,0])
        cube([diam_alim,diam_alim,10],center = true);
    }
}

module support_raspberry() {
    
} 

module boite() {
    difference(){
        cube([longueur_boite+2*epaisseur, largeur_boite+2*epaisseur, hauteur_boite], center=true);
        translate([0, 0, epaisseur])
        cube([longueur_boite, largeur_boite, hauteur_boite], center=true);
        //ARRIERE
        translate([-(longueur_boite-longueur_facade_arriere)/2+epaisseur+cote_support_couvercle+marge, -largeur_boite/2, 0])
        rotate([90,0,0])
        trou_facade(longueur_facade_arriere, 20);
        //AVANT
        translate([(longueur_boite-diam_bouton)/2-epaisseur-cote_support_couvercle-marge, largeur_boite/2, 0])
        rotate([90,0,0])
        bouton_power();
        translate([-(longueur_boite-longueur_facade_avant)/2+epaisseur+cote_support_couvercle+marge, largeur_boite/2, 0])
        rotate([90,0,0])
        trou_facade(longueur_facade_avant, 20);
    }
    translate([(longueur_boite-cote_support_couvercle)/2,(largeur_boite-cote_support_couvercle)/2,0])
    support_couvercle();
    translate([-(longueur_boite-cote_support_couvercle)/2,(largeur_boite-cote_support_couvercle)/2,0])
    support_couvercle();
    translate([(longueur_boite-cote_support_couvercle)/2,-(largeur_boite-cote_support_couvercle)/2,0])
    support_couvercle();
    translate([-(longueur_boite-cote_support_couvercle)/2,-(largeur_boite-cote_support_couvercle)/2,0])
    support_couvercle();
}

module couvercle() {
    difference(){
        cube([longueur_boite, largeur_boite, epaisseur], center=true);
        
    }
}

module trou_facade(longueur, largeur) {
    minkowski(){
        cube([longueur-2*rayon_courbe, largeur-2*rayon_courbe, 10], center=true);
        cylinder(r=rayon_courbe, $fn=100, center=true);
    }
}

module support_couvercle() {
    difference(){
        cube([cote_support_couvercle, cote_support_couvercle, hauteur_boite-epaisseur], center=true);
        cylinder(d=diam_corps_vis, h=hauteur_boite, $fn=100, center=true);
    }
}

boite();
translate([-(longueur_boite-longueur_facade_avant)/2+epaisseur+cote_support_couvercle+marge, largeur_boite/2, 0])
facade_usb();
translate([-(longueur_boite-longueur_facade_arriere)/2+epaisseur+cote_support_couvercle+marge, -largeur_boite/2, 0])
facade_arriere();

translate([0, 0, (hauteur_boite+epaisseur)/2])
#couvercle();

