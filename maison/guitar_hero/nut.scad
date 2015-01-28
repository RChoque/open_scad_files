diametre = 25.9;
hauteur_cylindre = 12.15;
epaisseur_minkowski = 2;
detail = 100;
hauteur_rectangle = 10.15;
longueur_rectangle = 18.2;
largeur_rectangle = 5.5;

// Create a list of metric standard measures
// From left to right: 
// Name, Thread spacing, outer Ã˜, inner Ã¸, nut flat to flat measure, torx index

M_std = [
	["M2", 0.40,  2,  1.6,  5, "T8"],
	["M3", 0.50,  3,  2.5,  6, "T15"],
	["M4", 0.70,  4,  3.3,  7, "T25"],
	["M5", 0.80,  5,  4.2,  8, "T30"],
	["M6", 1.00,  6,  5.0, 10, "T40"],
	["M7", 1.00,  7,  6.0, 12, "T45"],
	["M8", 1.25,  8,  6.8, 13, "T50"],
	["M10",1.50, 10,  8.5, 17, "T55"],
	["M12",1.75, 12, 10.2, 22, "T60"],
	["M14",2.00, 14, 12.0, 27, "T70"]
];



/**************************************************************************

N U T subs

**************************************************************************/

// Create a solid 6 sided nut body specified in mm and length and given fillet
// Called by screw_head, nut_body
module nut_body(mm, nh) {
	em = epaisseur_minkowski;
	difference(){
		minkowski() {
			cylinder (r=mm, h=nh, $fn=detail);
			sphere (em, $fn=detail);
		}
		translate([0,0,-em/2]) cube([2*(mm+em),2*(mm+em),em], center=true);
	}
	translate([0,0,nh+(hauteur_rectangle+em)/2])
	minkowski() {
		cube([largeur_rectangle-2*em, longueur_rectangle-2*em, hauteur_rectangle-em], center=true);
		sphere (em, $fn=detail);
	}
}

module nut_thread(tout, tinn, tl, ts, print, debug) {
	if(debug) {
		echo (str("nut_thread(",tout,", ",tinn,", ",tl,", ",ts,", ",fi,")"));
	}
	screw_body(tout, tinn, 2*tl, ts, true, print);
}

/**************************************************************************

S C R E W subs

**************************************************************************/

module screw_body(tout, tinn, tl, ts, nut=false, print) {
	intersection() {
		union() {
			if(print) {
				cylinder(r=tinn, h=tl);
				screw_thread(tout, tinn, tl, ts, nut, print);
			}
			else {
				cylinder(r=tout, h=tl);
			}
		}
		union() {
			translate([0,0,tl-(1.2*tout)]) 
				cylinder(h=2*tout, r1=2*tout, r2=0);
			translate([0,0,-tout]) 
				cylinder(h=tl, r=tout);
		}
	}
}

module screw_thread(tout, tinn, tl, ts, nut=false, print) {
	turns = (tl / ts) * 360;
	echo(str("Turns = ", turns/360));

	intersection() {
		linear_extrude(height=tl, twist=-turns) {
			translate([tout-tinn,0,0]) {
				if(nut==true) {
	 				circle(1.10*(tinn+tout)/2);
				}
				else {
 					circle(0.90*(tinn+tout)/2);
				}
			}
		}
		cylinder(tl, tout, tout);
	}
}



/**************************************************************************

C A L L A B L E   M O D U L E S

**************************************************************************/

module nut(standard, height=0, debug=false, print=true) {
	if(debug) {
		echo(str("nut(",standard,",",height,");"));
	}
	
	m = M_std[search([standard],M_std)[0]];
	ts = m[1];
	// increase nut inner dimension a bit
	tout  = m[2] / 1.95;
	tinn = m[3] / 1.95;
	nw = diametre/2-epaisseur_minkowski;
	nh = hauteur_cylindre-epaisseur_minkowski;
	union() {
		difference() {
			nut_body(nw, nh);
			translate([0,0,-nh]) nut_thread(tout, tinn, nh, ts, print, true, debug);
		}
	}

	if(debug) {
		% translate([0,0,0]) cube([1, nw*1.2, nh]);
		% translate([-m[4]/2,0,0]) cube([m[4], 1, nh*1.2]);
		% translate([-tout,0,nh/2]) cube([2*tout, nw*1.2, 1]);
		% translate([-tinn,0,nh/2]) cube([2*tinn, nw*1.3, 1]);
	}  
}



nut("M12", 6, print=true);
