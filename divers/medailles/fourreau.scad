longueur_lame = 54;
largeur_lame = 28;
largeur_carre_lame = 21.5;
epaisseur = 3;
epaisseur_ceinture = 4.5;
em = 3;
detail = 50;
hauteur_fourreau = 35;

module lame(){
    translate([0,0,hauteur_fourreau+2*em])
    rotate([0,180,0])
    minkowski (){
    linear_extrude(hauteur_fourreau+2*em, scale=1.10)
    polygon(points=[
        [-largeur_lame/2,-largeur_carre_lame/2],
        [-largeur_lame/2,largeur_carre_lame/2],
        [0,longueur_lame/2],
        [largeur_lame/2,largeur_carre_lame/2],
        [largeur_lame/2,-largeur_carre_lame/2],
        [0,-longueur_lame/2]
    ], paths=[[0,1,2,3,4,5]]);
        sphere (em/2, $fn=detail);
	}
}


module porte_lame(){
    difference(){
        translate([0,0,hauteur_fourreau/2+em])
        minkowski (){
    		cube([longueur_lame+2*epaisseur, largeur_lame+2*epaisseur, hauteur_fourreau], center = true);
    		sphere (em, $fn=detail);
    	}
        rotate([0,0,90]) lame();
    }
}

module fourreau(){
    difference(){
        union(){
            porte_lame();
            translate([0,largeur_lame/2+epaisseur+em+epaisseur_ceinture,-15])
            rotate([0,-30,0])
            union(){
                translate([0,-(epaisseur_ceinture+em),0])cube([30,epaisseur_ceinture+em,25]);
                cube([30,epaisseur,65]);
            }
        }
        translate([0,0,-25])
        cube([100,100,50], center=true);
    }

}

fourreau();