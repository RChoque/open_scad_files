diam_bulb = 38;
epaisseur = 2;
diam_tete = 55;
ecart_vis = 48;
diam_vis_2 = 2;
diam_vis_3 = 3;

difference() {
    cylinder(d=diam_bulb+1.5*epaisseur, h=diam_bulb/2, $fn=100);
    bulb_base();
    translate([0, 0, diam_bulb/8])
    rotate([90, 0, 0])
    cylinder(d=diam_vis_3, h=diam_bulb+3*epaisseur, $fn=100, center=true);
}
difference() {
    union(){
    cylinder(d=diam_tete, h=epaisseur/2, $fn=100);
        translate([0,0,epaisseur/2])
    cylinder(d=50.5, h=epaisseur/2, $fn=100);
    }
    cylinder(d=diam_bulb+1.5*epaisseur, h=diam_bulb/2, $fn=100, center=true);
    translate([ecart_vis/2,0,-0.1])
    cylinder(d=diam_vis_2, h=3, $fn=100);
    translate([-ecart_vis/2,0,-0.1])
    cylinder(d=diam_vis_2, h=3, $fn=100);
}
translate([0,diam_tete/2+26-18/2,epaisseur/2])
difference(){
union(){
    cylinder(d=18, h=epaisseur, $fn=50, center=true);
    translate([0,0,-epaisseur/4])
    cylinder(d=22, h=epaisseur/2, $fn=50, center=true);
    translate([0,-(30-18)/2-18/4,0])
    cube([18,30-18/2,epaisseur], center=true);
    translate([0,-(35-22)/2-22/4,-epaisseur/4])
    cube([22,35-22/2,epaisseur/2], center=true);
    translate([0,0,-epaisseur/2])
    
    cylinder(d=8, h=15, $fn=20);
    translate([-8,0,-epaisseur/2])
    cube([16,1,15]);
}
translate([0,0,-epaisseur])
#cylinder(d=4, h=15, $fn=20);
#cylinder(d=2.5, h=15, $fn=20);
}


module bulb_base() {
    scale([1, 1, 0.75])
    sphere(d=diam_bulb, $fn=100);
    cylinder(d=27, h=100, $fn=100);
}