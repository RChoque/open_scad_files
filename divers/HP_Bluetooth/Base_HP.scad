rayon_courbure = 20;
diam = 34;
diam_button = 20;
hauteur = 10;
largeur = 117;
longueur = 142;
epaisseur1 = 5;
epaisseur2 = 10;
ecart_vis_poignee = 55;
longueur_ci_charge = 28;
largeur_ci_charge = 15;
largeur_usb=8;
hauteur_usb = 3;

difference(){
union(){
translate([0,0,-hauteur/2])
cube([longueur, largeur-rayon_courbure, hauteur], center=true);
translate([0,0,hauteur/2])
cube([longueur, largeur, hauteur], center=true);
translate([0,(largeur-rayon_courbure)/2,0])
rotate([0,90,0])
cylinder(d=rayon_courbure, h=longueur, $fn=100, center=true);
translate([0,-(largeur-rayon_courbure)/2,0])
rotate([0,90,0])
cylinder(d=rayon_courbure, h=longueur, $fn=100, center=true);
translate([0,(epaisseur1+epaisseur2)/2-epaisseur1,3*hauteur/2])
cube([longueur-2*epaisseur1, largeur-epaisseur1-epaisseur2, hauteur], center=true);
    translate([0,largeur/2,3*hauteur/2-hauteur/2])
    rotate([90,0,0])
    difference(){
        cylinder(d=diam, h=epaisseur1, $fn=50);
        translate([-diam/2,-diam,0])
        cube([diam,diam,epaisseur1]);
    }
}
translate([1-(longueur-longueur_ci_charge)/2,0,-(hauteur-hauteur_usb-4)/2])
rotate([0,0,90])
#usb_ci();
translate([0,(epaisseur1+epaisseur2)/2-epaisseur1,3*hauteur/2-hauteur/2])
    cube([longueur-4*epaisseur1, largeur-3*epaisseur1-epaisseur2, 3*hauteur], center=true);
    translate([ecart_vis_poignee/2,0,-3*hauteur/2-0.5])
    #cylinder(d=3, h=10, $fn=20);
    translate([-ecart_vis_poignee/2,0,-3*hauteur/2-0.5])
    #cylinder(d=3, h=10, $fn=20);
    translate([0,1+largeur/2,3*hauteur/2-hauteur/2])
    rotate([90,0,0])
    #cylinder(d=diam_button, h=2+2*epaisseur1, $fn=50);

}

module usb_ci(){
    hauteur = hauteur_usb+4;
    union(){
        cube([largeur_ci_charge,longueur_ci_charge,hauteur], center=true);
        translate([0,longueur_ci_charge/2,1-(hauteur-hauteur_usb)/2])
        #cube([largeur_usb,20,hauteur_usb], center=true);
    }
}