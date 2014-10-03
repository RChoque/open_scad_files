detail = 30;
rayon_sphere = 2;
hauteur = 30;
diametre= 10;
rayon = 50;

module tore(diametre, petit_rayon){
	rotate_extrude(convexity = 10, $fn = 2*detail)
		translate([petit_rayon, 0, 0])
		circle(r = diametre/2, $fn = detail);
	
}

module support_tore(diametre, petit_rayon, hauteur){
	angle = -(90-atan(1.5*petit_rayon/hauteur));
	minkowski(){
		union(){
		difference(){
		rotate_extrude($fn = 2*detail) translate([petit_rayon+rayon_sphere-diametre/2, 0, 0]) square([diametre-2*rayon_sphere, hauteur]);	
		rotate([0, angle, 0]) translate([0,0, -hauteur/2]) cube([3*petit_rayon, 3*petit_rayon, 2*hauteur], center=true);
					}
		translate([0,0,(hauteur+diametre/2-rayon_sphere)/2]) difference(){
	translate([-petit_rayon,0,0]) cube([3*diametre/2, petit_rayon,hauteur+(diametre/2)-rayon_sphere], center = true);
	cylinder(r=petit_rayon, h=2*hauteur, $fn=2*detail, center=true);
}
}
		sphere (rayon_sphere, $fn=detail);
	}
}

module vis(){
	cylinder (r1=2, r2=2, h=50, $fn=detail);
	cylinder (r1=4, r2=2, h=2, $fn=detail);
	translate([0, 0, -10]) color("red") cylinder (r1=4, r2=4, h=10, $fn=detail);
}

module support_complet(){
	difference(){
		union(){
			translate([0,0,hauteur]) tore(diametre,rayon);
			support_tore(diametre, rayon, hauteur);
		}
		translate([-sqrt(pow((rayon-diametre/2),2)-pow((rayon/4),2)),rayon/4,hauteur/2]) rotate([0,-90,0]) vis();
		translate([-sqrt(pow((rayon-diametre/2),2)-pow((rayon/4),2)),-rayon/4,hauteur/2]) rotate([0,-90,0]) vis();
		linear_extrude(height=2*hauteur) polygon(points=[[0,0],[rayon+diametre/2,rayon/2],[rayon+diametre/2,-rayon/2]], paths=[[0,1,2]]);
	}
	rotate([0,0,atan((rayon/2)/(rayon+diametre/2))]) translate([rayon, 0, hauteur]) sphere (diametre/2, $fn=detail);
	rotate([0,0,-atan((rayon/2)/(rayon+diametre/2))]) translate([rayon, 0, hauteur]) sphere (diametre/2, $fn=detail);
}



support_complet();