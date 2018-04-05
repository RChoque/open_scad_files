rayon=350;
epaisseur = 4;
hauteur=18;
longueur=110;
largeur=20;

module tuyau(rayon_int, epaisseur, longueur) {
    difference(){
        cylinder(r=rayon_int+epaisseur, h=longueur, $fn=100, center=true);
        cylinder(r=rayon_int, h=longueur+1, $fn=100, center=true);
    }
}

module prisme(x,y,z){
    rotate([0,-90,-90])
    linear_extrude(height = y, center = true) {
    polygon(points = [[0, 0], [z, 0],[0, x]], paths = [[0, 1, 2]]);
    }
}

module vis(){
    cylinder (r=1.5, h=13, $fn=100);
    cylinder (r1=3, r2=1.5, h=2.5, $fn=100);
    translate([0,0,-30])
    cylinder (r=3, h=30, $fn=100);
}

module support(){
    difference(){
        union(){
            tuyau(rayon, 2*epaisseur, hauteur);
            translate([0,-rayon,-hauteur/2])
            rotate([0,0,90])
            prisme(largeur,longueur,hauteur);
        }
        tuyau(rayon+2*epaisseur, 2*epaisseur, hauteur);
        translate([0,0,-epaisseur])
        tuyau(rayon+epaisseur, 2*epaisseur, hauteur);
        translate([-(rayon+epaisseur), 0, -(hauteur+1)/2])
        cube([2*(rayon+epaisseur),2*(rayon+epaisseur),hauteur+1]);
        translate([longueur/2, -(rayon+epaisseur), -(hauteur+1)/2])
        cube([(rayon+epaisseur),2*(rayon+epaisseur),hauteur+1]);
        translate([-longueur/2-(rayon+epaisseur), -(rayon+epaisseur), -(hauteur+1)/2])
        cube([(rayon+epaisseur),2*(rayon+epaisseur),hauteur+1]);
        translate([longueur/4,largeur/2-rayon,epaisseur-hauteur/2])
        rotate([180,0,0])
        #vis();
        translate([-longueur/4,largeur/2-rayon,epaisseur-hauteur/2])
        rotate([180,0,0])
        #vis();
    }
}

support();