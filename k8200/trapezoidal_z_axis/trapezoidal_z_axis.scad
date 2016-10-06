hauteur = 12;
longueur = 45;
largeur = 31;

distance_tige = 15.5;
diametre_tige = 8;
diametre_ecrou = 10.8;
grand_diametre_ecrou = 23;
epaisseur_ecrou = 3.7;

longueur_tete_vis = 20;
longueur_vis = 30-5-3.5;

diametre_petite_vis = 2.5;

em = 2;

difference ()
{
    color ("red")  
    minkowski ()
    {
        translate([0,largeur/2,0])
        cube([longueur,largeur,hauteur],center=true);
        sphere(em, $fn=20);
    }



color ("blue")  
rotate ([0,0,0])
translate ([0,distance_tige+diametre_tige/2,0])
    union(){
cylinder (r=diametre_ecrou/2, h=80, $fn=100, center=true);
        translate([0,0,(hauteur-epaisseur_ecrou)/2+em])
cylinder (r=grand_diametre_ecrou/2, h=epaisseur_ecrou, $fn=100, center=true);
        //translate([0,0,-(hauteur-epaisseur_ecrou)/2-em])
//cylinder (r=grand_diametre_ecrou/2, h=epaisseur_ecrou, $fn=100, center=true);
        translate([-diametre_ecrou/2-(grand_diametre_ecrou-diametre_ecrou)/4,0,0])
        #cylinder (r=diametre_petite_vis/2, h=hauteur, $fn=100, center=true);
        translate([diametre_ecrou/2+(grand_diametre_ecrou-diametre_ecrou)/4,0,0])
        #cylinder (r=diametre_petite_vis/2, h=hauteur, $fn=100, center=true);
        translate([0,diametre_ecrou/2+(grand_diametre_ecrou-diametre_ecrou)/4,0])
        #cylinder (r=diametre_petite_vis/2, h=hauteur, $fn=100, center=true);
        translate([0,-diametre_ecrou/2-(grand_diametre_ecrou-diametre_ecrou)/4,0])
        #cylinder (r=diametre_petite_vis/2, h=hauteur, $fn=100, center=true);
    }

color ("black")  
rotate ([90,0,0])
translate ([15,0,-longueur_vis/2])
cylinder (r=2.25, h=longueur_vis, $fn=100, center=true);

color ("black")  
rotate ([90,0,0])
translate ([-15,0,-longueur_vis/2])
cylinder (r=2.25, h=longueur_vis, $fn=100, center=true);

color ("pink")  
translate ([-15,longueur_vis+longueur_tete_vis/2,0])
rotate ([90,0,0])
cylinder (r=5.5, h=longueur_tete_vis, $fn=100, center=true);

color ("pink")  
translate ([15,longueur_vis+longueur_tete_vis/2,0])
rotate ([90,0,0])
#cylinder (r=5.5, h=longueur_tete_vis, $fn=100, center=true);

translate([0,-em/2,0]) cube([60,em,45],center=true);
}

