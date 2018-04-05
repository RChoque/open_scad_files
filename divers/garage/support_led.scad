epaisseur=2;
diametre=46;
diam_vis = 5;

difference(){
    cylinder(d=diametre+2*epaisseur, h=2*epaisseur, $fn=100);
    translate([0,0,0.5*epaisseur+0.1])
    cylinder(d=diametre, h=1.5*epaisseur, $fn=100);
    translate([diam_vis/2,0,-0.1])
    cylinder(d=diam_vis, h=3*epaisseur, $fn=100);
    
    for (a =[0:10])
    rotate([0,0,36*a])
    translate([31/2,0,-0.1])
    cylinder(d=diam_vis, h=3*epaisseur, $fn=100);
}