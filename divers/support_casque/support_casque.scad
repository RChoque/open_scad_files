detail = 100;
largeur = 50;
hauteur = 30;
largeur_encoche = 4;
largeur_bordure = 4;
profondeur_encoche = 8;
largeur_casque = 30;
diametre = 140;
epaisseur = 2;

module crochet(){
    cube([largeur_encoche,profondeur_encoche,largeur]);
    translate([0,-2*epaisseur,0])
    cube([largeur_encoche+largeur_bordure+epaisseur,2*epaisseur,largeur]);
}

module tube(diam_ext, diam_int, longueur){
    difference(){
        cylinder(d=diam_ext, h=longueur, $fn=detail);
        translate([0,0,-0.5])
        cylinder(d=diam_int, h=longueur+1, $fn=detail);
    }
}

module prisme(hauteur_arc){
    linear_extrude(height=largeur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,largeur_casque+2*epaisseur],
                    [-hauteur_arc,0],
                    ], paths=[[0,1,2]]);
}

module tube_bordure(diametre, epaisseur, longueur){
    difference(){
        tube(diametre+2*epaisseur,diametre-2*epaisseur,longueur+epaisseur);
        translate([0,0,-1])
        tube(diametre+2*epaisseur+1,diametre,longueur+1);
    }
}

module arc(){
    largeur_bloc = diametre/2+epaisseur+1;
    difference(){
        tube_bordure(diametre, epaisseur, largeur_casque);
    
        translate([0,0,-0.5])
        cube([largeur_bloc,largeur_bloc,largeur_casque+epaisseur+1]);
        translate([-largeur_bloc+0.5,0,-0.5])
        cube([largeur_bloc,largeur_bloc,largeur_casque+epaisseur+1]);
        translate([-largeur_bloc+0.5,-largeur_bloc+0.5,-0.5])
        cube([largeur_bloc,largeur_bloc,largeur_casque+epaisseur+1]);
    }
}

module support(){
    rayon = diametre/2;
    hauteur_arc = rayon - rayon*sqrt(1-pow((largeur/2)/rayon,2));

    translate([0,0,-largeur/2])
    union(){
        cube([epaisseur,hauteur,largeur]);
        translate([-(largeur_encoche+largeur_bordure),0,0]) crochet();
    }
    difference(){
    translate([epaisseur,rayon+hauteur-epaisseur-hauteur_arc,0])
    rotate([-45,0,0])
    rotate([0,90,0])
    arc();
        translate([largeur_casque,hauteur,50+largeur/2])
        cube([2*largeur_casque, 2*hauteur, 100], center=true);
        translate([largeur_casque,hauteur,-(50+largeur/2)])
        cube([2*largeur_casque, 2*hauteur, 100], center=true);
    }
    translate([0,hauteur-hauteur_arc,0])
    difference(){
        rotate([0,0,-90])
        prisme(hauteur_arc);
        translate([0,rayon,0])
        rotate([0,90,0])
        tube(2*diametre,diametre+epaisseur/2,largeur_casque+2*epaisseur);
    }
}

support();

