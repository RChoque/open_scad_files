detail = 20;
marge = 0.5;
hauteur_socle = 9.8;
hauteur_cylindre_base = 4.9;
rayon_cylindre_base = 10.4;
hauteur_cylindre_haut = 14;
rayon_cylindre_haut = 3.4;
rayon_cylindre_creux = 5;
rayon_mini_cylindre = 1.5;
hauteur_mini_cylindre = 33.85;
rayon_cone = 2;
hauteur_cone = 10;
cote_triangle = 9.4;
hauteur_triangle = 5.3;
largeur_cube = 9.34;
longueur_cube = 11.94;
hauteur_cube = 9.9;
largeur_cube_inner = 6.23;
longueur_cube_inner = 8.34;


module cylindre_creux(){
	difference(){
		cylinder(h=100, r=2*rayon_cylindre_base, $fn=detail, center=true);
		cylinder(h=100, r=rayon_cylindre_base, $fn=detail, center=true);
	}
}

module vis(){
	cylinder (r1=2, r2=2, h=20, $fn=100);
	cylinder (r1=4, r2=2, h=2, $fn=100);
}

module socle(){
	translate([0,0,(hauteur_cylindre_base/2)]) color("blue") cylinder(h=hauteur_cylindre_base, r=rayon_cylindre_base, $fn=detail, center=true);
	difference(){
		translate([-10.2,-10.2,0]) linear_extrude(height=hauteur_socle) scale([0.58,0.58,1]) import("piece_enguerran_nb.dxf");
		translate([0,0,((3*hauteur_cylindre_base+marge)/2)]) color("blue") cylinder(h=hauteur_cylindre_base+marge, r=rayon_cylindre_base, $fn=detail, center=true);
		translate([0,17.05,0]) color("pink") vis();
	}
}

module trapeze(){
	difference(){
		translate([-cote_triangle/2,0,0]) rotate([90,0,0]) linear_extrude(height=2*rayon_cylindre_base, center=true) polygon(points=[[0,0],[cote_triangle,0],[cote_triangle/2,hauteur_triangle]], paths=[[0,1,2]]);
		cylindre_creux();
	}
}

module pointe(){
	translate([0,0,(hauteur_cylindre_base)]) cylinder(h=hauteur_cylindre_haut, r=rayon_cylindre_haut, $fn=detail, center=true);
	translate([0,0,(hauteur_cylindre_base + hauteur_cylindre_haut/2 + hauteur_cone/2)]) color("red") cylinder(h=hauteur_cone, r1=rayon_cylindre_haut, r2=rayon_cone, $fn=detail, center=true);
	translate([0,0,(hauteur_mini_cylindre-hauteur_cylindre_haut)/2]) color("green") cylinder(h=hauteur_mini_cylindre, r=rayon_mini_cylindre, $fn=detail, center=true);
}

socle();
translate([0,0,hauteur_cylindre_base]) trapeze();
translate([0,0,hauteur_cylindre_haut/2]) pointe();

translate([0,5+rayon_cylindre_base,hauteur_socle+hauteur_cube/2]) 
difference(){
	translate([0,longueur_cube/2,0]) cube([largeur_cube,longueur_cube,hauteur_cube], center=true);
	translate([0,longueur_cube_inner/2,0]) cube([largeur_cube_inner,longueur_cube_inner,hauteur_cube], center=true);
}


