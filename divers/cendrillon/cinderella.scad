

module chaussure(){
	difference(){
	    import("Womans-Single-Strap-Shoe.STL");
	    translate([-90,-50,117]) 
	    rotate([0,30,0]) 
	    	cube([100,100,60]);
	    translate([-35,30,138]) 
		rotate([90,0,0]) 
			cylinder(r=50, h=60, $fn=100);
	}
}


