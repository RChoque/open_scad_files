epaisseur = 0.5;
longueur = 20;
largeur = 20;
hauteur = 10;
detail = 100;

module hollow_cube(x,y,z,epaisseur){
	difference(){
		cube([x,y,z], center=true);
		cube([x-2*epaisseur,y-2*epaisseur,z+epaisseur], center=true);
	}
}

module hollow_cylinder(diametre,hauteur,epaisseur){
	difference(){
        cylinder(h=hauteur, r=diametre/2, $fn=detail);
        translate([0,0,-epaisseur/2])
        cylinder(h=hauteur+epaisseur, r=(diametre-2*epaisseur)/2, $fn=detail);
	}
}

hollow_cube(longueur,largeur,hauteur,epaisseur);
//hollow_cylinder(longueur,hauteur,epaisseur);