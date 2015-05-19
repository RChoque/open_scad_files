//rotate([0,10,0])
//import("K8200_GT2_Belt_Wedge.stl");

tooth_angle=40;
tooth_height=1.2;
tooth_top_width=1.8;
pitch=5;
decalage = tan(tooth_angle/2)*tooth_height;

module socle(){
linear_extrude(height=6, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[0,0],
					[0,-1.8],
					[9.14,-3.42],
                    [9.14,0]
					], paths=[[0,1,2,3]]);
}

module dent(){
    
    linear_extrude(height=6, center=true, convexity = 0, twist = 0) 
				polygon(points=[
					[0,0],
					[decalage,tooth_height],
					[decalage+tooth_top_width,tooth_height],
                    [2*decalage+tooth_top_width,0]
					], paths=[[0,1,2,3]]);
}

module dents(){
    dent();
    translate([pitch,0,0]) dent();
    translate([2*pitch,0,0]) dent();
}

module wedge1(){
	difference(){
		union(){
	    	rotate([90,0,0])
			color("blue")
			socle();
			translate([-(tooth_top_width/2+2*decalage),0,0])
			rotate([90,0,0])
			color("red")
			dents();
    	}
        translate([-3,0,0])
    	cube([6,7,6],center=true);
        translate([9.14+3,0,0])
    	cube([6,7,6],center=true);
	}
}

module wedge2(){
	difference(){
		union(){
	    	rotate([90,0,0])
			color("blue")
			socle();
			translate([2*decalage,0,0])
			rotate([90,0,0])
			color("red")
			dents();
    	}
        translate([-3,0,0])
    	cube([6,7,6],center=true);
        translate([9.14+3,0,0])
    	cube([6,7,6],center=true);
	}
}

rotate([0,-10,0])
wedge1();
