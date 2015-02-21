epaisseur_bloc = 15;
hauteur_bloc = 80;
longueur_bloc = 100;

module bloc3(marge){
	difference(){
		color("red") cube([hauteur_bloc,longueur_bloc,epaisseur_bloc], center=true);
		translate([0,-longueur_bloc,0]) double_accroche(marge);
	}	
}

module bloc2(marge){
	difference(){
		color("red") cube([hauteur_bloc,longueur_bloc,epaisseur_bloc], center=true);
		translate([0,-longueur_bloc,0]) double_accroche(marge);
	}	
	double_accroche(0);
}

module bloc1(){
	color("red") cube([hauteur_bloc,longueur_bloc,epaisseur_bloc], center=true);
	double_accroche(0);
}

module accroche(marge){
	difference(){
		union(){
			cube([marge+hauteur_bloc/6, marge+longueur_bloc/6, marge+epaisseur_bloc/2], center=true);
			translate([0,longueur_bloc/6,-(marge/2+epaisseur_bloc/4)]) cylinder(h = marge+epaisseur_bloc/2, r=marge+hauteur_bloc/6, $fs=1);
		}
		translate([0,(longueur_bloc/12+hauteur_bloc/6-5),marge/2+epaisseur_bloc/4+0.1]) rotate ([180,0,0]) color("cyan") cylinder (r1=marge+5, r2=marge+3, h=marge+4, $fn=100);
	}
}

module double_accroche(marge){
	translate([-hauteur_bloc/4,longueur_bloc/2,-epaisseur_bloc/4]) color("blue") accroche(marge);
	translate([hauteur_bloc/4,longueur_bloc/2,-epaisseur_bloc/4]) color("blue") accroche(marge);
}



