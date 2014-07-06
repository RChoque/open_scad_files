detail = 20;
hauteur_cylindre_base = 4.9;
rayon_cylindre_base = 10.4;
hauteur_cylindre_haut = 14;
rayon_cylindre_haut = 3.4;
rayon_cylindre_creux = 5;
rayon_cone = 2;
hauteur_cone = 10;
cote_triangle = 94;
hauteur_triangle = 53;
rayon_mini_cylindre = 2;
hauteur_mini_cylindre = 10;

translate([0,0,(hauteur_cylindre_base/2)]) color("blue") cylinder(h=hauteur_cylindre_base, r=rayon_cylindre_base, $fn=detail, center=true);

//translate([20,0,20]) color("green")
polyhedron(
  points=[[0,0,0],[0,cote_triangle,0],[0,cote_triangle/2,hauteur_triangle],[2*rayon_cylindre_base,0,0],[2*rayon_cylindre_base,cote_triangle,0],[2*rayon_cylindre_base,cote_triangle/2,hauteur_triangle]],        
  faces=[[0,2,1],[3,4,5],[1,2,5,4],[3,5,2,0],[1,0,3,4]]
 );

translate([0,0,(hauteur_cylindre_base + hauteur_cylindre_haut/2)]) cylinder(h=hauteur_cylindre_haut, r=rayon_cylindre_haut, $fn=detail, center=true);

translate([0,0,(hauteur_cylindre_base + hauteur_cylindre_haut + hauteur_cone/2)]) color("red") cylinder(h=hauteur_cone, r1=rayon_cylindre_haut, r2=rayon_cone, $fn=detail, center=true);

translate([0,2*rayon_cylindre_creux,0]) cube([12.4,10,9.9], center=true);

