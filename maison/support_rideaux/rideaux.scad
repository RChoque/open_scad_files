module inner_rideau(rayon, longueur){
	translate([0,rayon,0]) color("orange") cylinder(r=rayon, h=10, $fn=96);
	translate([longueur-(2*rayon),rayon,0]) color("orange") cylinder(r=rayon, h=10, $fn=96);
	color("orange") cube([longueur-(2*rayon),2*rayon,10]);
}

module inner_rideau_small(){
	rayon = 2;
	longueur = 8;
	inner_rideau(rayon, longueur);
}

module inner_rideau_big(){
	rayon = 3;
	longueur = 10;
	inner_rideau(rayon, longueur);
}

module crochet(){
	epaisseur = 2;
	color("blue") cube([epaisseur,20,10]);
	color("red") rotate([0,0,90]) cube([epaisseur,50,10]);
	translate([-50,-7,2]) difference(){	
		minkowski ()
   	{
			cube([10,9,6]);
			sphere (2, $fn=20);
   	}
		translate([-2,9,-2]) cube([14,2,10]);
	}
}

module crochet_big(){
	translate([0,10,0]) 
	difference(){
		crochet();
		translate([-47,-7,3]) inner_rideau_big();
	}
}

module crochet_small(){
	translate([0,-10,10]) 
	difference(){
		rotate([180,0,0]) crochet();
		translate([-47,1.5,-7]) inner_rideau_small();
	}
}

crochet_small();
//crochet_big();