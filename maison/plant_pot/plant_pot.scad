largeur_max = 185;
epaisseur = 2.5;
detail = 100;
//sphere_diam = sqrt(2*pow(largeur_max,2));

//rotate([0,0,45])
//cube([largeur_max,largeur_max,epaisseur],center=true);


module hemisphere(rayon){
    difference(){
        sphere(rayon, $fn=detail);
        translate([0,-rayon,-rayon])
        cube([rayon,2*rayon,2*rayon]);
        translate([-rayon,-rayon,-rayon])
        cube([2*rayon,2*rayon,rayon]);
    }
}

module cache(){
    difference(){
        hemisphere(200);
        hemisphere(largeur_max/2+epaisseur);
    }
}

difference(){
    union(){
        hemisphere(largeur_max/2);
        translate([0,-70,-45])
        rotate([0,-90,0]) linear_extrude(150) scale(2) import("motif.dxf");
    }
    cache();
    translate([-epaisseur,0,0])
    hemisphere(largeur_max/2-2*epaisseur);
}



