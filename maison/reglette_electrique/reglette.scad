epaisseur = 2;
largeur = 85;
hauteur = 55;
hauteur_max = 35;
longueur = 164;
largeur_fente = 44;
largeur_fente_2 = 40.5;
diametre_vis = 3;
marge = (largeur-largeur_fente)/2;
diff = hauteur - hauteur_max;
longueur_interrupteur = 30;
largeur_interrupteur = 22;


module tube(longueur, largeur, hauteur){
    difference(){
        cube([largeur, hauteur, longueur], center=true);
        cube([largeur-2*epaisseur, hauteur-2*epaisseur, longueur+2], center=true);
    }
}

module reglette(){
    difference(){
        tube(longueur, largeur, hauteur);
        translate([0,(hauteur-epaisseur)/2,0])
        cube([largeur_fente, 2*epaisseur, longueur+2], center=true);
    }
    
    goulotte2();
}

module goulotte1(){
    translate([-largeur_fente/2-epaisseur,(hauteur-3)/2-epaisseur,0])
    cube([2*epaisseur, 3, longueur],center=true);
    translate([-largeur_fente/2-1.5*epaisseur,(hauteur-13)/2-epaisseur,0])
    cube([1.5*epaisseur, 13, longueur],center=true);
    translate([-largeur_fente/2,(hauteur+epaisseur)/2-13-epaisseur,0])
    cube([4, epaisseur, longueur],center=true);
    translate([-largeur_fente/2+1.7,(hauteur+epaisseur)/2-12.45-epaisseur,0])
    cube([epaisseur/2, 5, longueur],center=true);
    
    translate([largeur_fente/2+epaisseur,(hauteur-3)/2-epaisseur,0])
    cube([2*epaisseur, 3, longueur],center=true);
    translate([largeur_fente/2+1.5*epaisseur,(hauteur-13)/2-epaisseur,0])
    cube([1.5*epaisseur, 13, longueur],center=true);
    translate([largeur_fente/2,(hauteur+epaisseur)/2-13-epaisseur,0])
    cube([4, epaisseur, longueur],center=true);
    translate([largeur_fente/2-1.7,(hauteur+epaisseur)/2-12.45-epaisseur,0])
    cube([epaisseur/2, 5, longueur],center=true);
}

module goulotte2(){
    translate([-(largeur_fente+epaisseur)/2,(hauteur-5)/2-epaisseur,0])
    cube([epaisseur, 5, longueur],center=true);
    
    translate([-(largeur_fente)/2,(hauteur-4)/2-(5.5+epaisseur),0])
    difference(){
        cylinder(d=9, h=longueur, $fn=100, center=true);
        cylinder(d=5, h=longueur+1, $fn=100, center=true);
        translate([2.5, 0, 0])
        cube([5, 10, longueur+1],center=true);
    }
    
    translate([0.5-(largeur_fente)/2,(hauteur-11)/2-(5.5+epaisseur),0])
    cube([2,epaisseur,longueur],center=true);
    
    translate([-0.5-largeur_fente_2/2,(hauteur-8)/2-(6+epaisseur),0])
    cube([epaisseur/2,4,longueur],center=true);
    
    translate([(largeur_fente+epaisseur)/2,(hauteur-5)/2-epaisseur,0])
    cube([epaisseur, 5, longueur],center=true);
    translate([largeur_fente/2,(hauteur-4)/2-(5.5+epaisseur),0])
    difference(){
        cylinder(d=9, h=longueur, $fn=100, center=true);
        cylinder(d=5, h=longueur+1, $fn=100, center=true);
        translate([-2.5, 0, 0])
        cube([5, 10, longueur+1],center=true);
    }
    
    translate([-0.5+(largeur_fente)/2,(hauteur-11)/2-(5.5+epaisseur),0])
    cube([2,epaisseur,longueur],center=true);
    translate([largeur_fente_2/2+0.5,(hauteur-8)/2-(6+epaisseur),0])
    cube([epaisseur/2,4,longueur],center=true);
}

module cache(){
    translate([0, (hauteur-epaisseur)/2,0])
    cube([largeur_fente, epaisseur, longueur],center=true);
    
    translate([5.5-(largeur_fente+epaisseur)/2,(hauteur-11)/2-epaisseur,0])
    rotate([0,0,-15])
    cube([epaisseur, 14, longueur],center=true);
    
    translate([5.5+1.5-(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-(10+epaisseur),0])
    rotate([0,0,35])
    translate([0,3,0])
    cube([epaisseur, 6, longueur],center=true);
    
    translate([5.5-2.5-(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-epaisseur,0])
    cube([5, epaisseur/2, longueur],center=true);
    
    translate([5.5-5-(largeur_fente+epaisseur)/2,(hauteur-14.5)/2-epaisseur,0])
    rotate([0,0,-15])
    cube([epaisseur/2, 3, longueur],center=true);
    
    //other side
    translate([-5.5+(largeur_fente+epaisseur)/2,(hauteur-11)/2-epaisseur,0])
    rotate([0,0,15])
    cube([epaisseur, 14, longueur],center=true);
    
    translate([-5.5-1.5+(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-(10+epaisseur),0])
    rotate([0,0,-35])
    translate([0,3,0])
    cube([epaisseur, 6, longueur],center=true);
    
    translate([-5.5+2.5+(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-epaisseur,0])
    cube([5, epaisseur/2, longueur],center=true);
    
    translate([-5.5+5+(largeur_fente+epaisseur)/2,(hauteur-14.5)/2-epaisseur,0])
    rotate([0,0,15])
    cube([epaisseur/2, 3, longueur],center=true);
}

module cache_interrupteur(){
    difference(){
        cache();
        translate([0,(hauteur-epaisseur)/2, 4*epaisseur+(largeur_interrupteur-longueur)/2])
        rotate([90,0,0])
        #cube([longueur_interrupteur,largeur_interrupteur,2*epaisseur], center=true);
        translate([0,(hauteur-epaisseur)/2, largeur_interrupteur+8*epaisseur+(largeur_interrupteur-longueur)/2])
        rotate([90,0,0])
        #cube([longueur_interrupteur,largeur_interrupteur,2*epaisseur], center=true);
    }
}

module reglette_percee(){
    nb_trous = 6;
    increment = longueur/nb_trous;
    start_position = (increment-longueur)/2;
    end_position = longueur/2;
    
    
    difference(){
        reglette();
        for(position =[start_position : increment : end_position]){
        translate([marge-(largeur-diametre_vis)/2,-(hauteur-epaisseur)/2, position])
        rotate([90,0,0])
        #cylinder(d=diametre_vis, h=2*epaisseur, $fn=100, center=true);
            translate([-marge+(largeur-diametre_vis)/2,-(hauteur-epaisseur)/2, position])
        rotate([90,0,0])
        #cylinder(d=diametre_vis, h=2*epaisseur, $fn=100, center=true);
        }
     
        translate([0,-(hauteur-epaisseur)/2, longueur/4])
        rainure();
     
        translate([0,-(hauteur-epaisseur)/2, -longueur/4])
        rainure();
    }
    
}

module rainure(){
    hauteur_rainure = longueur/2.5-marge;
    #cube([marge, 2*epaisseur, hauteur_rainure],center = true);
            translate([0,0,hauteur_rainure/2])
        rotate([90,0,0])
        #cylinder(d=marge, h=2*epaisseur, $fn=100, center=true);
         
            translate([0,0,-hauteur_rainure/2])
        rotate([90,0,0])
        #cylinder(d=marge, h=2*epaisseur, $fn=100, center=true);
}

module extremite(){
    
    difference(){
        union(){
            cube([largeur, hauteur_max, diff], center=true);
            translate([0,hauteur_max/2,diff/2])
            rotate([0,90,0])
            cylinder(r=diff, h=largeur, $fn=100, center=true);
        }
        translate([0,epaisseur/2,epaisseur])
        cube([largeur-2*epaisseur, hauteur_max-epaisseur, diff], center=true);
        translate([0,hauteur_max/2,diff/2])
            rotate([0,90,0])
            cylinder(r=diff-epaisseur, h=largeur-2*epaisseur, $fn=100, center=true);
        translate([0,diff/2,diff])
        cube([largeur, hauteur, diff], center=true);
    }
}

module reglette_extremite(){
    translate([0,-diff/2,-(diff+longueur)/2])
    extremite();
    reglette_percee();
    translate([3+marge-1,hauteur/2-diff,-longueur/2])
    color("red")support_complement();
    translate([1-(3+marge),hauteur/2-diff,-longueur/2])
    color("red")support_complement();
}

module support_complement(){
    rayon = diff-epaisseur;
    difference(){
        rotate([0,90,0])
        cylinder(r=rayon, h=7, $fn=100, center=true);
        translate([0,0,rayon/2])
        cube([8,2*rayon,rayon],center=true);
        translate([0,-rayon/2,-rayon/2])
        cube([8,rayon+1,rayon+1],center=true);
    }
    translate([0,-0.5,-rayon/2])
    cube([7, 2, rayon],center=true);
}

module reference(){
color("red")
linear_extrude(10) 
scale(1.05)
import("reglette_1.dxf");
translate([47,14,0])
 #color("blue")
#cube([10,44,44]);
}

module reference2(){
translate([248.5,-259.19,0])
rotate([0,0,90])
color("red")
linear_extrude(10) 
scale(1.46)
import("reglette_3a.dxf");
//    translate([-22,15,0])
//    #cube([44,10,44]);
}

module reference2_cache(){
translate([248.5,-259.45,0])
rotate([0,0,90])
color("red")
linear_extrude(10) 
scale(1.46)
import("reglette_3b.dxf");
//    translate([-22,15,0])
//    #cube([44,10,44]);
}

//reglette_percee();
//color("red") 
cache_interrupteur();