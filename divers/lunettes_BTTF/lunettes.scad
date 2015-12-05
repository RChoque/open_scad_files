rayon_courbure = 60;
longueur = 150 + rayon_courbure;
largeur = 145;
hauteur = 45;
largeur_nez = 15;
hauteur_nez = hauteur/3;
hauteur_branche = hauteur/3;
epaisseur = 1.5;


module rectangle(longueur, largeur, hauteur, rayon){
    minkowski(){
        translate([0,0,hauteur/2])
        cube([longueur-2*rayon, largeur-2*rayon, hauteur-rayon/2], center=true);
        cylinder(r=rayon, h=hauteur, $fn=100);
    }
}

module contour_rectangle(longueur, largeur, hauteur, rayon, epaisseur){
    difference(){
        rectangle(longueur+2*epaisseur, largeur+2*epaisseur, hauteur, rayon);
        translate([0,0,-0.5])
        rectangle(longueur, largeur, hauteur+1, rayon);
    }
}

module branche(){
    rayon = 2*hauteur;
    h = hauteur-hauteur_branche;
    petit_rayon = 5;
    position_arrondi = sqrt(pow(rayon, 2)-pow(rayon-h,2));
    ratio = position_arrondi/rayon;
    echo(ratio);
    difference(){
        cube([2*longueur/3, 4*epaisseur, h], center = true);    
        translate([longueur/3,0,2*hauteur-h/2])
        rotate([90,0,0])
        cylinder(r=rayon, h=4*epaisseur, $fn=200, center=true);
        translate([longueur/3-position_arrondi+ratio*petit_rayon/2-(1-ratio)*petit_rayon-0.1,0,(h-ratio*petit_rayon)/2])
        cube([ratio*petit_rayon, 4*epaisseur, ratio*petit_rayon], center = true);    
    }
    translate([longueur/3-position_arrondi-(1-ratio)*petit_rayon,0,h/2-petit_rayon])
    difference(){
        rotate([90,0,0])
        cylinder(r=petit_rayon, h=4*epaisseur, center=true);
        translate([petit_rayon/2+sqrt(pow(petit_rayon, 2)-pow(petit_rayon-h,2)), 0, 0])
        color("red")
        cube([petit_rayon, 4*epaisseur, petit_rayon], center = true);   
    }
}

module nez(coef){
    petit_rayon = 5;
    difference(){
        union(){
            hull(){
                cylinder(d=largeur_nez, h=hauteur, $fn=100);
                translate([hauteur_nez-petit_rayon/2,0,hauteur/2])
                cube([petit_rayon,coef*largeur_nez,hauteur], center=true);
            }
            translate([hauteur_nez-petit_rayon/2,0,hauteur/2])
                cube([petit_rayon,coef*largeur_nez+2*petit_rayon,hauteur], center=true);
    }
    translate([hauteur_nez-petit_rayon,coef*largeur_nez/2+petit_rayon,0])
    cylinder(r=petit_rayon, h=hauteur, $fn=100);
    translate([hauteur_nez-petit_rayon,-coef*largeur_nez/2-petit_rayon,0])
    cylinder(r=petit_rayon, h=hauteur, $fn=100);
}
}

module lunettes(){
    difference(){
        translate([0,0,-rayon_courbure/2])
        contour_rectangle(longueur, largeur, hauteur, rayon_courbure, epaisseur);
        translate([-(longueur-rayon_courbure)/2,0,hauteur/2])
        cube([rayon_courbure+3*epaisseur, largeur+2*rayon_courbure+1, 2*hauteur], center = true);
        translate([0,0,-hauteur/2])
        cube([longueur+3*epaisseur, largeur+3*epaisseur, hauteur], center = true);
        translate([longueur/2-epaisseur,0,hauteur_nez-0.05])
        rotate([0,90,0])
        nez(1.35);
        translate([0,largeur/2,(hauteur-hauteur_branche)/2-0.1])
        branche();
        translate([0,-(largeur+epaisseur)/2,(hauteur-hauteur_branche)/2-0.1])
        branche();
    }
    
}


lunettes();
