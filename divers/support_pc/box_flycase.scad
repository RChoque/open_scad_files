detail = 100;
longueur = 150;
largeur = 50;
hauteur = 100;
largeur_encoche = 4;
largeur_bordure = 4;
largeur_rainure = 10;
profondeur_encoche = 8;
epaisseur = 2;

module boite(longueur, largeur, hauteur, epaisseur){
    largeur_biseau = largeur/2;
    translate([0,0,hauteur/2-(hauteur-largeur_biseau)/2])
    difference(){
        cube([longueur, largeur+2*epaisseur, hauteur-largeur_biseau], center=true);
        cube([longueur-2*epaisseur, largeur, hauteur-largeur_biseau+2], center=true);
    }
    translate([0,epaisseur, -hauteur/2+largeur_biseau])
    difference(){
        union(){
            rotate([0,90,0])
            linear_extrude(height=longueur, center=true, convexity = 0, twist = 0) 
            polygon(points=[
                [0,0],
                [0,largeur_biseau],
                [largeur_biseau,0],
                ], paths=[[0,1,2]]);
            translate([0,-epaisseur-largeur_biseau/2, -largeur_biseau/2])
            cube([longueur,largeur_biseau+2*epaisseur,largeur_biseau],center=true);
        }
        translate([0,0,epaisseur])
        union(){
            rotate([0,90,0])
                linear_extrude(height=longueur-2*epaisseur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,largeur_biseau],
                    [largeur_biseau,0],
                    ], paths=[[0,1,2]]);
                translate([0,-epaisseur/2-largeur_biseau/2, -largeur_biseau/2])
                cube([longueur-2*epaisseur,largeur_biseau+epaisseur+0.05,largeur_biseau],center=true);
        }
    }
}

module rainure(){
    cube([4*epaisseur, largeur_rainure,hauteur],center=true);
    translate([-2*epaisseur,0,-hauteur/2])
    rotate([0,90,0])
    cylinder(d=largeur_rainure, h=4*epaisseur, $fn=detail);
}

module crochet(){
    translate([0,0,-profondeur_encoche])
    cube([longueur,largeur_encoche,profondeur_encoche]);
    cube([longueur,largeur_encoche+largeur_bordure,2*epaisseur]);
}

module boite_complete(){
    
    translate([-longueur/2,-epaisseur-largeur/2-largeur_encoche-largeur_bordure,hauteur/2-2*epaisseur])
color("blue")
crochet();
    difference(){
        boite(longueur, largeur, hauteur, epaisseur);
        translate([longueur/2,0,hauteur/2])
        rainure();
        translate([-longueur/2,0,hauteur/2])
        rainure();
    }
    
}
boite_complete();