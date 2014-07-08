detail = 20;
hauteur_cylindre_base = 4.9;
rayon_cylindre_base = 10.4;
hauteur_cylindre_haut = 14;
rayon_cylindre_haut = 3.4;
rayon_cylindre_creux = 5;
rayon_cone = 2;
hauteur_cone = 10;
cote_triangle = 9.4;
hauteur_triangle = 5.3;
rayon_mini_cylindre = 2;
hauteur_mini_cylindre = 10;

translate([0,0,(hauteur_cylindre_base/2)]) color("blue") cylinder(h=hauteur_cylindre_base, r=rayon_cylindre_base, $fn=detail, center=true);


module cylindre_creux(){
	difference(){
		cylinder(h=100, r=2*rayon_cylindre_base, $fn=detail, center=true);
		cylinder(h=100, r=rayon_cylindre_base, $fn=detail, center=true);
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
}

translate([0,0,hauteur_cylindre_base]) trapeze();
translate([0,0,hauteur_cylindre_haut/2]) pointe();


translate([0,2*rayon_cylindre_creux,0]) cube([12.4,10,9.9], center=true);

