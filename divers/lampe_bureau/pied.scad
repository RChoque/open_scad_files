diametre = 13;
longueur = 33;
diam_vis = 5;
longueur_vis = 25;

module ecrou(){
    cylinder(d=9.5, h=4.5, $fn=6);
}
    

difference(){
    cylinder(d=diametre, h=longueur-diametre/2, $fn=100);
    cylinder(d=diam_vis, h=longueur_vis, $fn=100);
    ecrou();
}
translate([0,0, longueur-diametre/2])
sphere(d=diametre, $fn=100);