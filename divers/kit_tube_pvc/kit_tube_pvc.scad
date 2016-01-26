diametre_tube = 32;
longueur = 1.5*diametre_tube;
epaisseur = 2.5;
epaisseur_planche = 18;
detail = 100;

module angle_round(angle){
    difference(){
	    union(){
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        rotate([angle,0,0])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        sphere(d=diametre_tube+2*epaisseur, $fn=detail);
	    }
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([angle, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
	}
}

module angle_cross(angle){
    difference(){
	    union(){
            translate([0,0,-diametre_tube/2-epaisseur])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur+diametre_tube/2, $fn=detail);
	        rotate([angle,0,0])
            translate([0,0,-diametre_tube/2-epaisseur])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur+diametre_tube/2, $fn=detail);
	        
	    }
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([angle, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
	}
}

module angle_sharp(angle){
    difference(){
    	union(){
    		cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        rotate([angle,0,0])
            cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        intersection(){
	            translate([0,0,-diametre_tube/2])
		        cylinder(d=diametre_tube+2*epaisseur, h=longueur+diametre_tube/2, $fn=detail);
		        rotate([angle,0,0])
	            translate([0,0,-diametre_tube/2])
		        cylinder(d=diametre_tube+2*epaisseur, h=longueur+diametre_tube/2, $fn=detail);
		        
		    }
    	}
	    
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([angle, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
	}
}

module angle_round_90(){
    angle_round(90);
}

module angle_round_45(){
    angle_round(45);
}

module block_T(){
    difference(){
    	union(){
            rotate([90,0,0])
	        cylinder(d=diametre_tube+2*epaisseur, h=2*longueur, center=true, $fn=detail);
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	    }
	    translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([90, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([270, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
    }
}

module block_Y(angle){
    difference(){
    	union(){
            rotate([angle/2,0,0])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
            rotate([-angle/2,0,0])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
            translate([0,0,-longueur])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	    }
	    translate([0,0,-(longueur+diametre_tube/2)])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([angle/2, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([-angle/2, 0,0])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
    }
}

module block_support_1(angle){
    marge_tuyau = diametre_tube/2;
    cote_support = longueur-marge_tuyau;
    
	difference(){
	    union(){
	    	translate([0,0,-longueur])
	        cylinder(d=diametre_tube+2*epaisseur, h=2*longueur, $fn=detail);
	        rotate([90,0,180-angle])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        rotate([90,0,180])
	        cylinder(d=diametre_tube+2*epaisseur, h=longueur, $fn=detail);
	        translate([0,0,epaisseur+(diametre_tube-epaisseur_planche)/2-epaisseur_planche])
            cube([longueur, longueur, epaisseur_planche/2]);
            translate([0,0,epaisseur+(diametre_tube-epaisseur_planche)/2-epaisseur_planche-longueur])
            rotate([90,0,45])
	        prisme(longueur, longueur, epaisseur_planche/2);
	    }
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
	    translate([0,0,-longueur-diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([90,0,180])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        rotate([90,0,180-angle])
        translate([0,0,diametre_tube/2])
	    cylinder(d=diametre_tube, h=longueur, $fn=detail);
        
	}

}

module prisme(cote1, cote2, longueur){
    linear_extrude(height=longueur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,cote1],
                    [cote2,cote1],
                    ], paths=[[0,1,2]]);
}

block_support_1(90);