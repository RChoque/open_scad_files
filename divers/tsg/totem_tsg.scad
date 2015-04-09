difference(){
    linear_extrude(height=150, center=true, convexity=0) scale(0.5) import("logo_tsg_hollow_perspective.dxf");
translate([-1,-1,75]) rotate([0,90,0]) linear_extrude(height=100, center=false, convexity=0) polygon(points=[[0,62],[0,0],[62,0]], path=[[0,1,2]]);
}

translate([0,0,-2]) color("blue")
difference(){
    linear_extrude(height=149, center=true, convexity=0) scale(0.5) import("logo_tsg_plein_perspective.dxf");
translate([-1,-1,75]) rotate([0,90,0]) linear_extrude(height=100, center=false, convexity=0) polygon(points=[[0,62],[0,0],[62,0]], path=[[0,1,2]]);
}