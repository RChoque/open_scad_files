largeur_max = 185;
epaisseur = 3;
detail = 100;
//sphere_diam = sqrt(2*pow(largeur_max,2));

//rotate([0,0,45])
//cube([largeur_max,largeur_max,epaisseur],center=true);

grand_rayon_vis = 4;
petit_rayon_vis = 1.5;

module vis(){
	cylinder (r1=petit_rayon_vis, r2=petit_rayon_vis, h=10, $fn=detail/2);
	cylinder (r1=grand_rayon_vis, r2=petit_rayon_vis, h=3, $fn=detail/2);
}

module hemisphere(rayon){
    difference(){
        sphere(rayon, $fn=detail);
        translate([0,-rayon,-rayon])
        cube([rayon,2*rayon,2*rayon]);
        translate([-rayon,-rayon,-rayon])
        cube([2*rayon,2*rayon,rayon]);
    }
}

module cache(){
    difference(){
        hemisphere(200);
        hemisphere(largeur_max/2+0.6);
    }
}

module support(){
    translate([0,-largeur_max/2,0])
    cube([20, largeur_max, epaisseur]);
}

module motif1(){
    difference(){
        translate([-140,-70,-105])
        rotate([90,0,90]) linear_extrude(largeur_max/2) scale(0.7) import("motif1.dxf");
        cache();    
    }
}

module motif2(){
    difference(){
        translate([-1,-100,160])
        rotate([-90,-10,90]) linear_extrude(largeur_max/2) scale(0.73) import("motif2.dxf");
        cache();    
    }
}

module pot(){
    difference(){
    union(){
        hemisphere(largeur_max/2);
        color("blue") support();        
        
        minkowski(){        
            motif2();            
            sphere(d=0.8, $fn=5);
        }
    }
    translate([-epaisseur,0,0])
    scale([1,(largeur_max/2-epaisseur)/(largeur_max/2-2*epaisseur),1]) hemisphere(largeur_max/2-2*epaisseur);
    translate([10,0,0])
    vis();
    translate([10,largeur_max/3,0])
    vis();
    translate([10,-largeur_max/3,0])
    vis();
}
}

pot();


