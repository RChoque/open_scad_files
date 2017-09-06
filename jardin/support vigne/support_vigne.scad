longueur = 80;
largeur = 10;
epaisseur = 2;
diametre_fil = 3;
diam_cylindre_fil = diametre_fil+2*epaisseur;
arrondi = (largeur-epaisseur)/2;
hauteur = longueur/2+diam_cylindre_fil;
diam_vis_head = 8;
diam_vis = 4;

module equerre1() {
difference(){

    cube([longueur, hauteur, largeur], center = true);
    
    translate([epaisseur+arrondi/2,epaisseur+arrondi/2,(largeur+epaisseur)/2+arrondi])
    minkowski() {
	cube([longueur-arrondi, hauteur-arrondi, largeur], center = true);
	sphere(r=arrondi, $fn=100);
    }
    translate([epaisseur+arrondi/2,epaisseur+arrondi/2,-((largeur+epaisseur)/2+arrondi)])
    minkowski() {
	cube([longueur-arrondi, hauteur-arrondi, largeur], center = true);
	sphere(r=arrondi, $fn=100);
    }
}
translate([0,hauteur/3-hauteur/2,0])
rotate([0,-90,0])
cylinder(d=largeur, h=longueur, $fn=100, center=true);

translate([0,hauteur/2-hauteur/4,0])
rotate([0,-90,0])
cylinder(d=largeur, h=longueur, $fn=100, center=true);
}
module equerre() {
difference(){

    equerre1();
    
    translate([longueur/2+epaisseur, longueur/4+epaisseur, 0])
    scale([1,0.5,1])
    cylinder(r=longueur, h=largeur, $fn=100, center=true);
}
}

module vis(){
    cylinder(d=diam_vis, h=20, $fn=50);
    cylinder(d1=diam_vis_head, d2=diam_vis, h=3, $fn=50);
    translate([0,0,0.1-40])
    cylinder(d=diam_vis_head, h=40, $fn=50);
}

difference(){
union(){
equerre();
translate([longueur/2, diam_cylindre_fil/2-hauteur/2, 0])
cylinder(d=diam_cylindre_fil, h= largeur, $fn=100, center= true);
translate([longueur/2-longueur/3, diam_cylindre_fil/2-hauteur/2, 0])
cylinder(d=diam_cylindre_fil, h= largeur, $fn=100, center= true);
translate([longueur/2-2*longueur/3, diam_cylindre_fil/2-hauteur/2, 0])
cylinder(d=diam_cylindre_fil, h= largeur, $fn=100, center= true);
}
translate([3-longueur/2,hauteur/3-hauteur/2,0])
rotate([0,-90,0])
vis();
translate([3-longueur/2,hauteur/2-hauteur/4,0])
rotate([0,-90,0])
vis();
}
