difference(){
union(){
    translate([0,0,-4.5])
    cube([29,39,9], center = true);
    translate([0,0,4.5])
    cube([43,46,9], center = true);
}
translate([0,(39-4)/2+0.1,4-9+4/2])
cube([15,4,3], center=true);
translate([0,-(39-4)/2-0.1,4-9+4/2])
cube([15,4,3], center=true);
}