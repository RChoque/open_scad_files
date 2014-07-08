epaisseur = 30;
petite_largeur = 31;
grande_largeur = 32.5;
hauteur = 30;

difference(){
	color("red") support();
	translate([hauteur*2/3,grande_largeur/4+grande_largeur/2,epaisseur/2]) rotate([0,0,90]) color("cyan") profile();
	translate([-hauteur*1/3,grande_largeur/4-4,0]) color("green") cube([hauteur,2.5,epaisseur*2]);
translate([24,4,-0.1]) creux();
translate([24,4,epaisseur*2/3]) creux();
}

module profile(){
	translate([0,5.5,0]) cube([grande_largeur,11,epaisseur*2], center=true);
	translate([0,14.5,0]) cube([petite_largeur,20,epaisseur*2], center=true);
}

module support ()
{
	demie_longueur = grande_largeur;
	longueur = demie_longueur*2;
	
  polyhedron
  (
		points=[[0,0,0], [0,longueur,0], [longueur,0,0], [longueur,0,epaisseur], 
[0,0,epaisseur], [0,longueur,epaisseur], [longueur,0,epaisseur]],  
		triangles=[[0,2,1],  // face avant
             [0,4,2],[4,3,2],  // face gauche
             [0,1,4],[4,1,5],  // face droite
             [3,4,5],  // face arrière
             [1,2,5],[2,3,5]]  // bas
  		);
}

module creux ()
{
	demie_longueur = 17;
	longueur = demie_longueur*2;
	
  polyhedron
  (
		points=[[0,0,0], [0,longueur,0], [longueur,0,0], [longueur,0,epaisseur/3], 
[0,0,epaisseur/3], [0,longueur,epaisseur/3], [longueur,0,epaisseur/3]],  
		triangles=[[0,2,1],  // face avant
             [0,4,2],[4,3,2],  // face gauche
             [0,1,4],[4,1,5],  // face droite
             [3,4,5],  // face arrière
             [1,2,5],[2,3,5]]  // bas
  		);
}