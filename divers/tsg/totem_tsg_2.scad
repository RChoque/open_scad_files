angle = 60;
echelle_totem = 2;
hauteur_totem = echelle_totem*100;
largeur_totem = echelle_totem*33;
longueur_totem = echelle_totem*85.5;
profondeur_creux = 2;
echelle_sqli = echelle_totem*0.75;
hauteur_sqli = echelle_sqli*13;
largeur_sqli = echelle_sqli*201;
hauteur_chapeau = 20;
rayon_chapeau = longueur_totem/2.4;

epaisseur = 3;

detail = 50;


module biseau(){
	hauteur = largeur_totem*tan(angle);
	rotate([0,90,0]) 
		linear_extrude(height=longueur_totem, center=false, convexity=0) 
		polygon(points=[
			[0,largeur_totem],
			[0,0],
			[hauteur,0]
		], path=[[0,1,2]]);
}

module totem_creux(){
	translate([-longueur_totem/2,0,0])
	difference(){
		translate([0,0,hauteur_totem/2]) 
	    linear_extrude(height=hauteur_totem, center=true, convexity=0) 
	    	scale(echelle_totem) 
	    	import("logo_tsg_hollow_2_60.dxf");
		translate([-1,-1,hauteur_totem+0.1]) 
			#biseau();
	}
}

module totem_plein(){
	hauteur = hauteur_totem-profondeur_creux;
    translate([-longueur_totem/2,0,0])
    difference(){
		translate([0,0,hauteur/2]) 
	    linear_extrude(height=hauteur, center=true, convexity=0) 
	    	scale(echelle_totem) 
	    	import("logo_tsg_2_60.dxf");
		translate([-1,-1,hauteur+0.1]) 
			#biseau();
	}
}

module sqli(){
    translate([-largeur_sqli/2,-largeur_totem/1.7,-hauteur_sqli/2])
	rotate([angle,0,0]) 
    linear_extrude(height=hauteur_sqli, center=true, convexity=0) 
	    	scale(echelle_sqli) 
	    	import("logo-sqli.dxf");
}

module chapeau(){
	difference() {
		cylinder(h=hauteur_chapeau, r=rayon_chapeau, $fn=detail);
    	cylinder(h=hauteur_chapeau/3, r=rayon_chapeau-epaisseur, $fn=detail);
        translate([0,0,4]) scale([1,1,0.4]) sphere(r=rayon_chapeau-epaisseur);
	}
	rotate([0,0,45])
	translate([0,0,hauteur_chapeau+epaisseur/2])
	cube([2.5*rayon_chapeau,2.5*rayon_chapeau,epaisseur], center = true);
    translate([1*rayon_chapeau+5,-4,4]) 
    rotate([90-angle,0,0])
    union(){
    	translate([0,0,-1*hauteur_chapeau])
    	cylinder(h=2*hauteur_chapeau, r=2, $fn=detail);
    	translate([0,0,-1*hauteur_chapeau])
    	sphere(5);
    	translate([0,0,-1.75*hauteur_chapeau])
    	cylinder(h=0.75*hauteur_chapeau, r2=2, r1=5, $fn=detail);
        translate([0,0,-1.75*hauteur_chapeau]) sphere(5);
    }
    
}

module partie_1(){
	difference(){
		union(){
            color("green") sqli();
			color("red") totem_creux();
			color("blue") totem_plein();
        }
		translate([0,50,hauteur_totem+5])
		rotate([-(90-angle),0,0])       chapeau();
        translate([0,0,-10])
        #cube([350,350,20], center=true);
	}
}

module partie_2(){
	rotate([180,0,0]) chapeau();
}

module complet(){
	partie_1();
	translate([0,50,hauteur_totem+5])
	rotate([-(90-angle),0,0]) chapeau();
}

complet();


