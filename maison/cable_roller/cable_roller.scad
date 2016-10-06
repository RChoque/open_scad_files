epaisseur = 3;
longueur = 50;
largeur = 18;
hauteur = 50;
nb_cables = 3;
hauteur_empreinte = (hauteur-(nb_cables+2)*epaisseur)/nb_cables;
em=epaisseur;

module empreinte(){
    
    difference(){
    minkowski (){
		cube([longueur, largeur, hauteur_empreinte], center=true);
		sphere (em, $fn=100);
	}
        translate([0,0,largeur/2+hauteur_empreinte/2])
        rotate([0,90,0])
        scale([1,2])
        cylinder(d=largeur, h=2*em+longueur, $fn=100, center=true);
    translate([0,0,-(largeur/2+hauteur_empreinte/2)])
        rotate([0,90,0])
        scale([1,2])
        cylinder(d=largeur, h=2*em+longueur, $fn=100, center=true);
    }
}

module half(){
    difference(){
        minkowski (){
            translate([0,0,-em/2])
            cube([longueur-2*em,largeur-2*em/2,hauteur-em], center=true);
            cylinder(r=em, h=em, $fn=100);
        }
        
        for(cables =[0 : 1 : nb_cables-1]){
		translate([0,0,cables*(hauteur_empreinte+epaisseur/2)+(hauteur_empreinte-hauteur)/2+(cables+1)*epaisseur])
		empreinte();
    }
    }
}

module piece(){
difference(){
    union(){
        translate([longueur/2,0,0])
        half();
        translate([-longueur/2,0,0])
        half();
        translate([0,0,-hauteur/2])
        color("blue")
        scale([2,1])
    cylinder(d=largeur+em, h=hauteur, $fn=100);
    }
    translate([0,0,epaisseur-hauteur/2])
        color("blue")
        scale([2,1])
    cylinder(d=largeur+em-epaisseur, h=hauteur-em, $fn=100);

}
}

piece();