module polygone ()
{
	longueur_base = 35;
	epaisseur = 20;
  polyhedron
  (
		points=[[10,0,0], [longueur_base,0,0], [60,0,60], [00,00,60], 
[10,epaisseur,0], [longueur_base,epaisseur,0], [60,epaisseur,60], [0,epaisseur,60]],  
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
  translate ([0,-10,0]) polygone ();
}

module step3 ()
{
	difference ()
	{
		step2 ();
		translate ([-5,0,54]) rotate ([90,0,90]) cylinder (r1=7.5, r2=7.5, h=80, $fn=100);
	}
}

module step4()
{
	difference ()
	{
		step3 ();
		translate ([0,-7.5,54]) cube([80,15,10]);
	}
}



step4 ();
translate ([20,0,45]) cylinder (r1=2.5, r2=2.5, h=16, $fn=100);



