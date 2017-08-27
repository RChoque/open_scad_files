diam_vis_head = 8;
diam_vis = 4;

difference(){
    translate([-101.5,0,-101])
    rotate([90,0,0])
    import("caliper_mount_v2.stl");
    translate([0,-50,-50])
    #cube([47,50,50]);
    translate([23.5,-10,2.9])
    rotate([0,180,0])
    #vis();
    translate([23.5,-30,2.9])
    rotate([0,180,0])
    #vis();
}

module vis(){
    cylinder(d=diam_vis, h=20, $fn=50);
    cylinder(d1=diam_vis_head, d2=diam_vis, h=3, $fn=50);
}