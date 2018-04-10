longueur_switch = 20;
largeur_switch = 5;
hauteur_switch = 10;
epaisseur = 2;
diam_ecrou = 6;
diam_vis = 4;
hauteur_barre= 40;

module glissiere_switch() {
    difference(){
        union(){
            cube([longueur_switch+2*epaisseur, largeur_switch+epaisseur, hauteur_switch], center=true);
            cube([longueur_switch+4*epaisseur, epaisseur, hauteur_switch],center=true);
        }
        translate([0,epaisseur/2,0])
        cube([longueur_switch, largeur_switch+0.1, hauteur_switch+0.1],center=true);
        translate([-5,0,0])
        rotate([90,0,0])
        cylinder(d=4, h=largeur_switch+2*epaisseur, $fn=20);
        translate([5,0,0])
        rotate([90,0,0])
        cylinder(d=4, h=largeur_switch+2*epaisseur, $fn=20);
    }
    translate([0,-(largeur_switch+epaisseur)/2-(diam_ecrou+2*epaisseur)/2,hauteur_switch])
    difference(){
        union(){
            cylinder(d=diam_ecrou+2*epaisseur, h=10, $fn=40, center=true);
            translate([0,(diam_ecrou+2*epaisseur)/4,0])
            cube([diam_ecrou+2*epaisseur,(diam_ecrou+2*epaisseur)/2,10], center=true);
        }
        translate([0,0,-epaisseur])
            cylinder(d=diam_ecrou, h=10, $fn=6, center=true);
        cylinder(d=diam_vis, h=20, $fn=20, center=true);
    }
}

module support_glissiere() {
    translate([0,(largeur_switch+epaisseur)/2,-25])
    difference(){
        cube([longueur_switch+10*epaisseur, largeur_switch+epaisseur, 50], center=true);
        cube([longueur_switch+2*epaisseur+0.5, largeur_switch+epaisseur+0.1, 51], center=true);
        cube([longueur_switch+4*epaisseur+0.5, epaisseur+0.5, 51], center=true);
    }
    translate([-(longueur_switch+10*epaisseur)/2,0,0])
    cube([longueur_switch+10*epaisseur, hauteur_barre, 10]);
    translate([0,-(diam_ecrou+2*epaisseur)/2,5])
    difference(){
        union(){
            cylinder(d=diam_ecrou+2*epaisseur, h=10, $fn=40, center=true);
            translate([0,(diam_ecrou+2*epaisseur)/4,0])
            cube([diam_ecrou+2*epaisseur,(diam_ecrou+2*epaisseur)/2,10], center=true);
        }
        
        cylinder(d=diam_vis, h=20, $fn=20, center=true);
    }
}

support_glissiere();
translate([0,(largeur_switch+epaisseur)/2,-30])
glissiere_switch();