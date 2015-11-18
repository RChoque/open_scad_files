longueur = 70;
hauteur = 12;
epaisseur = 2;

difference(){
    cube([longueur, longueur, hauteur], center=true);
    translate([longueur/2+epaisseur,longueur/2+epaisseur,0])
    cylinder(r=longueur, h=hauteur+1, $fn=100, center=true);
    translate([longueur/5,2.5-longueur/2,0])
    rotate([90,0,0])
    #vis();
    translate([-longueur/5,2.5-longueur/2,0])
    rotate([90,0,0])
    #vis();
}

module vis(){
	cylinder (r=2, h=13, $fn=100);
	cylinder (r1=4, r2=1.5, h=2.5, $fn=100);
    translate([0,0,-30])
    cylinder (r=4, h=30, $fn=100);
}