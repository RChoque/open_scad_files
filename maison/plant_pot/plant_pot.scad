largeur_max = 185;
epaisseur = 2.5;
sphere_diam = sqrt(2*pow(largeur_max,2));

rotate([0,0,45])
cube([largeur_max,largeur_max,epaisseur],center=true);
difference(){
    sphere(sphere_diam/2);
    translate([0,-sphere_diam/2,-sphere_diam/2])
    cube([sphere_diam,sphere_diam,sphere_diam]);

}

