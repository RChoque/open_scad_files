import("Z-axis_plate_TOP.stl");
translate([1,0,0]) 
difference(){
import("Z-axis_plate_TOP.stl");
translate([0,-0.09,20]) cube([70,50.2,50], center=true);
}
