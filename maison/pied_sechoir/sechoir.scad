hauteur = 50;
longueur_max = 50;
rayon = 7;
epaisseur = 18;

module step1 ()
{
	longueur_base = 25;
  polyhedron
  (
		points=[[0,0,0], [longueur_base,0,0], [longueur_max,0,hauteur], [00,00,hauteur], 
[0,epaisseur,0], [longueur_base,epaisseur,0], [longueur_max,epaisseur,hauteur], [0,epaisseur,hauteur]],  
		triangles=[[0,3,1],[1,3,2],  // face avant
             [0,4,3],[4,7,3],  // face gauche
             [1,2,6],[1,6,5],  // face droite
             [4,5,7],[5,6,7],  // face arrière
             [0,1,4],[1,5,4],  // bas
             [3,7,6],[3,6,2]]  // haut
  		);
}

module step2 ()
{
  translate ([0,-epaisseur/2,0]) step1 ();
}

module step3 ()
{
	difference ()
	{
		step2 ();
		translate ([-5,0,hauteur-rayon/2]) rotate ([90,0,90]) cylinder (r=7, h=80, $fn=100);
	}
	translate ([15,0,hauteur-3*rayon/2]) cylinder (r=2.5, h=16, $fn=100);
}



step3 ();




