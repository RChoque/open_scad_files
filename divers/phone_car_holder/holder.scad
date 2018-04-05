cylinder(d=7.5, h=3, $fn=100);
translate([0,0,3])
cylinder(d=3.5, h=2.5, $fn=100);
translate([0,0,5.5])
cylinder(d=9, h=5, $fn=100);
translate([0,0,30/2+10.5])
difference(){
cube([9.5,9.5,30], center=true);
translate([0,0,2.5])
cube([4.5,10,30], center=true);
}