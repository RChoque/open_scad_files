longueur = 190;
epaisseur = 7;
largeur = 22;
longueur_ouverture = 150;
angle = 55;
rayon = 40;
diametre = 13;
diametre_vis = 11;
diametre_tige_vis = 3.5;
ecartement_vis = 148+diametre_tige_vis;
profondeur_vis = 3.5;
longueur_crochet = (longueur - longueur_ouverture)/2;

translate([0,largeur/2,-rayon])
difference(){
union(){
cube([longueur, largeur, epaisseur], center=true);
translate([(longueur-longueur_crochet)/2,-largeur/2,rayon-epaisseur/2])
rotate([0,90,0])crochet();
translate([-(longueur-longueur_crochet)/2,-largeur/2,rayon-epaisseur/2])
rotate([0,90,0])crochet();
}
translate([ecartement_vis/2,0,-epaisseur/2])
#vis();
translate([-ecartement_vis/2,0,-epaisseur/2])
#vis();
}
rotate([-angle,0,0])
translate([0,0,-rayon+epaisseur/4])
rotate([0,90,0])
scale([0.7,1,1])
cylinder(d=diametre, h=longueur, center=true, $fn=100);



module crochet(){
    difference(){
        cylinder(r=rayon, h=longueur_crochet, center=true, $fn=100);
        cylinder(r=rayon-epaisseur, h=longueur_crochet+1, center=true, $fn=100);
        translate([0, rayon/2,0])
        cube([2*rayon,rayon,longueur_crochet+1], center=true);
        translate([-rayon/2, 0,0])
        cube([rayon,2*rayon,longueur_crochet+1], center=true);
        rotate([0,0,90-angle])
        translate([-rayon/2, -rayon/2,0])
        #cube([rayon,rayon,longueur_crochet+1], center=true);
    }
}

module vis(){
    cylinder(d=diametre_vis, h=profondeur_vis, $fn=100);
    cylinder(d=diametre_tige_vis, h=2*epaisseur, $fn=100);
}

