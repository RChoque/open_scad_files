epaisseur = 2;
largeur = 85;
hauteur = 50;
longueur = 10;
largeur_fente = 44;

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
    
    translate([2-(largeur_fente)/2,(hauteur-11)/2-(5.5+epaisseur),0])
    cube([4,epaisseur,longueur],center=true);
    
    translate([4.25-(largeur_fente)/2,(hauteur-8)/2-(5.5+epaisseur),0])
    cube([epaisseur/2,5,longueur],center=true);
    
    translate([(largeur_fente+epaisseur)/2,(hauteur-5)/2-epaisseur,0])
    cube([epaisseur, 5, longueur],center=true);
    translate([largeur_fente/2,(hauteur-4)/2-(5.5+epaisseur),0])
    difference(){
        cylinder(d=9, h=longueur, $fn=100, center=true);
        cylinder(d=5, h=longueur+1, $fn=100, center=true);
        translate([-2.5, 0, 0])
        cube([5, 10, longueur+1],center=true);
    }
    
    translate([-2+(largeur_fente)/2,(hauteur-11)/2-(5.5+epaisseur),0])
    cube([4,epaisseur,longueur],center=true);
    translate([-4.25+(largeur_fente)/2,(hauteur-8)/2-(5.5+epaisseur),0])
    cube([epaisseur/2,5,longueur],center=true);
}

module cache(){
    translate([0, (hauteur-epaisseur)/2,0])
    cube([largeur_fente, epaisseur, longueur],center=true);
    
    translate([7.5-(largeur_fente+epaisseur)/2,(hauteur-10)/2-epaisseur,0])
    cube([epaisseur, 10, longueur],center=true);
    
    translate([7.5+3.2-(largeur_fente+epaisseur)/2,(hauteur-8.5)/2-(10+epaisseur),0])
    rotate([0,0,35])
    translate([0,3,0])
    cube([epaisseur, 6, longueur],center=true);
    
    translate([7.5-2.5-(largeur_fente+epaisseur)/2,(hauteur-10.5)/2-epaisseur,0])
    cube([5, epaisseur/2, longueur],center=true);
    
    translate([7.5-5-(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-epaisseur,0])
    cube([epaisseur/2, 3, longueur],center=true);
    
    //other side
    translate([-7.5+(largeur_fente+epaisseur)/2,(hauteur-10)/2-epaisseur,0])
    cube([epaisseur, 10, longueur],center=true);
    
    translate([-7.5-3.2+(largeur_fente+epaisseur)/2,(hauteur-8.5)/2-(10+epaisseur),0])
    rotate([0,0,-35])
    translate([0,3,0])
    cube([epaisseur, 6, longueur],center=true);
    
    translate([-7.5+2.5+(largeur_fente+epaisseur)/2,(hauteur-10.5)/2-epaisseur,0])
    cube([5, epaisseur/2, longueur],center=true);
    
    translate([-7.5+5+(largeur_fente+epaisseur)/2,(hauteur-12.5)/2-epaisseur,0])
    cube([epaisseur/2, 3, longueur],center=true);
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


//reglette();
cache();