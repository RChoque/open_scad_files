diametre_cable=5;
diam_vis = 2.5;
epaisseur = 2;

difference() {
    cube([diametre_cable+2*epaisseur,diametre_cable+2*epaisseur,10], center=true);
    union(){
    cylinder(d=diametre_cable, h=11, $fn=20, center=true);
        translate([diametre_cable/2,0,0])
    cube([diametre_cable,diametre_cable,11], center=true);
    }
}
translate([(diametre_cable+2*epaisseur),(diametre_cable+2*epaisseur-10)/2,0])
rotate([90,0,0])
difference(){
cylinder(d1=10, d2=diam_vis+epaisseur, h=10, $fn=20, center=true);
    translate([0,0,-epaisseur])
    cylinder(d=diam_vis, h=10, $fn=20, center=true);
}
translate([3*(diametre_cable+2*epaisseur)/4,(diametre_cable+epaisseur)/2,0])
cube([(diametre_cable+2*epaisseur)/2, epaisseur, 10], center=true);