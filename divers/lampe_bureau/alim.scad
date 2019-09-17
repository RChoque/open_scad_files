epaisseur=2;
longueur=100;
largeur=50;
hauteur=42;
largeur_prise=20;
hauteur_prise=12.5;
hauteur_fil=3.5;
largeur_fil=6;
largeur_fix=6;

module vis(){
    cylinder(d1=5.5, d2=3, h=epaisseur, $fn=50);
    cylinder(d=3, h=10, $fn=20);
}

module insert_vis() {
    cylinder(d=4, h=3, $fn=20);
    cylinder(d=3, h=15, $fn=20);
}

module boite(){
    difference(){
        cube([longueur+2*epaisseur, largeur+2*epaisseur, hauteur+2*epaisseur], center=true);
        cube([longueur, largeur, hauteur], center=true);
        translate([longueur/2,0,0])
        cube([longueur, largeur_prise, hauteur_prise], center=true);
        translate([-longueur/2,0,-hauteur/4])
        cube([longueur, largeur_fil, hauteur_fil], center=true);
    }
    
}

module haut(){
    difference(){
        translate([0,0,hauteur/4])
        boite();
        translate([0,0,-(hauteur+2*epaisseur)/4])
        cube([longueur+3*epaisseur, largeur+3*epaisseur, (hauteur+2*epaisseur)/2], center=true);
    }
    translate([(longueur-largeur_fix)/2,(largeur-largeur_fix)/2,hauteur/4])
    difference(){
        cube([largeur_fix,largeur_fix,hauteur], center=true);
        translate([0,0,-hauteur/2])
        #insert_vis();
    }
    translate([-(longueur-largeur_fix)/2,(largeur-largeur_fix)/2,hauteur/4])
    difference(){
        cube([largeur_fix,largeur_fix,hauteur], center=true);
        translate([0,0,-hauteur/2])
        #insert_vis();
    }
    translate([-(longueur-largeur_fix)/2,-(largeur-largeur_fix)/2,hauteur/4])
    difference(){
        cube([largeur_fix,largeur_fix,hauteur], center=true);
        translate([0,0,-hauteur/2])
        #insert_vis();
    }
    translate([(longueur-largeur_fix)/2,-(largeur-largeur_fix)/2,hauteur/4])
    difference(){
        cube([largeur_fix,largeur_fix,hauteur], center=true);
        translate([0,0,-hauteur/2])
        #insert_vis();
    }
}

module bas(){
    difference(){
        translate([0,0,hauteur/4])
        boite();
        translate([0,0,(hauteur+2*epaisseur)/2])
        cube([longueur+3*epaisseur, largeur+3*epaisseur, (hauteur+2*epaisseur)], center=true);
        translate([(longueur-largeur_fix)/2,(largeur-largeur_fix)/2,-(hauteur/4+epaisseur)])
        #vis();
        translate([-(longueur-largeur_fix)/2,(largeur-largeur_fix)/2,-(hauteur/4+epaisseur)])
    #vis();
    translate([-(longueur-largeur_fix)/2,-(largeur-largeur_fix)/2,-(hauteur/4+epaisseur)])
    #vis();
    translate([(longueur-largeur_fix)/2,-(largeur-largeur_fix)/2,-(hauteur/4+epaisseur)])
    #vis();
    }
}
//haut();
bas();