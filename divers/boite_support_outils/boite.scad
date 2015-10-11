translate([20,-2,0])
import("PartBin.stl");
longueur = 253;
largeur = 60;
epaisseur = 4;
translate([-largeur/2,-longueur/2,0])
cube([largeur,longueur,epaisseur]);