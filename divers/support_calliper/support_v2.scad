diam_vis_head = 8;
diam_vis = 4;

difference(){
    union(){
    import("schieblehre_halter.stl");
    translate([-4.5,-8,0])
    #cube([55,36,4]);
    }
    translate([23,20,4.1])
    rotate([0,180,0])
    #vis();
    translate([23,0,4.1])
    rotate([0,180,0])
    #vis();
}

module vis(){
    cylinder(d=diam_vis, h=20, $fn=50);
    cylinder(d1=diam_vis_head, d2=diam_vis, h=3, $fn=50);
}