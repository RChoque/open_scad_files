hauteur = 60;
longueur_max = 50;
longueur_min = 20;
rayon = 7;
epaisseur = 18;
diametre = 14.5;
diametre_tige = 5.4;

module step1 ()
{
	
  polyhedron
  (
		points=[[0,0,0], [longueur_min,0,0], [longueur_max,0,hauteur], [00,00,hauteur], 
[0,epaisseur,0], [longueur_min,epaisseur,0], [longueur_max,epaisseur,hauteur], [0,epaisseur,hauteur]],  
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
	difference ()
	{
		translate ([0,-epaisseur/2,0]) step1 ();
		union(){
			translate ([-5,0,hauteur-rayon]) rotate ([90,0,90]) cylinder (r=diametre/2, h=longueur_max*1.5, $fn=100);
			translate ([-5,-diametre/2,hauteur-rayon]) cube([longueur_max*1.5,diametre,diametre]);
		}
	}
	translate ([15,0,hauteur-2*rayon-1]) cylinder (r=5.4/2, h=diametre+2, $fn=100);
}



step2 ();




