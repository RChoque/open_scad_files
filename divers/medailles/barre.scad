difference(){
    minkowski (){
        cube([30,8,2]);
        sphere (2, $fn=50);
    }
    translate([3,0.5,3])
    linear_extrude(2) scale([0.10,0.3]) import("alex.dxf");
    translate([-2,-2,-3]) cube([50,30,3]);
}