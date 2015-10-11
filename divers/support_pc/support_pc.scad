epaisseur_flycase = 14.5;
hauteur_flycase = 65;
epaisseur = 4;
epaisseur_minkowski = 2;
epaisseur_triangle = epaisseur/2;
longueur_support = 180;
largeur_support = 20;
longueur_PC = 180;
hauteur_PC = 20;
detail = 100;
angle = 30;
nb_triangles = 7;
cote_grand_triangle = longueur_PC/nb_triangles;
cote_triangle = cote_grand_triangle - 2*epaisseur_triangle/tan(angle);
hauteur_grand_triangle = cos(angle)*cote_grand_triangle;
hauteur_triangle = cos(angle)*cote_triangle;
echo(hauteur_grand_triangle);

    
module fente_flycase(){
    difference(){
        cube([epaisseur_flycase + 2*epaisseur, hauteur_flycase + epaisseur, largeur_support]);
        translate([epaisseur, 0 ,-0.5])
        cube([epaisseur_flycase, hauteur_flycase, largeur_support+1]);
    }
}

module plateau_PC(){
    minkowski (){
        union(){
            cube([longueur_PC, epaisseur, largeur_support - epaisseur_minkowski]);
            translate([0,2*(epaisseur-epaisseur_minkowski),0])
            cube([epaisseur, hauteur_PC,largeur_support - epaisseur_minkowski]);
        }
        cylinder(r=epaisseur_minkowski, h=epaisseur_minkowski, $fn=detail);
    }
}

module triangle(largeur){
    difference(){
        linear_extrude(height=largeur) 
        polygon(points=[[0,0],[cote_grand_triangle,0],[cote_grand_triangle/2,hauteur_grand_triangle]],paths=[ [0,1,2] ]);
        
        translate([epaisseur_triangle/tan(30),epaisseur_triangle,-0.5])
        linear_extrude(height=largeur+1) 
        polygon(points=[[0,0],[cote_triangle,0],[cote_triangle/2,hauteur_triangle]],paths=[ [0,1,2] ]);
    }
}

module pattern_triangle(largeur, n, x){
    for ( j = [0 : n-x] ){   
        for ( i = [1 : n-j] ){   
            translate([(j*1/2+i-1)*cote_grand_triangle,j*hauteur_grand_triangle,0])
            triangle(largeur);
            if(i<(n-j)){
                translate([(i+(1+j)/2)*cote_grand_triangle,(j+1)*hauteur_grand_triangle,0])
                rotate([0,0,180])
                triangle(largeur);
            }
        }
    }
}

module support_triangles(){
    difference(){
        union(){
            translate([longueur_PC+epaisseur/2,0,0])
            rotate([0,0,180])
            pattern_triangle(largeur_support, nb_triangles,4);
            plateau_PC();
        }
        
        translate([longueur_PC,0,0])
        rotate([0,0,1.25*angle])
        translate([-6*hauteur_grand_triangle-1,-2*cote_grand_triangle,-0.5])
        cube([6*hauteur_grand_triangle+epaisseur, 2*cote_grand_triangle, largeur_support+1]);
    }
    rotate([0,0,-2*angle])
    translate([0,-epaisseur/2,0])
    cube([4*cote_grand_triangle+2*epaisseur_minkowski, epaisseur, largeur_support]);
    
    translate([longueur_PC-1,0,0])
    rotate([0,0,1.25*angle])
    translate([-nb_triangles*hauteur_grand_triangle-epaisseur/2,-epaisseur/2,0])
    cube([nb_triangles*hauteur_grand_triangle+epaisseur, epaisseur, largeur_support]);
}

module support_1(){
    difference(){
        translate([epaisseur/4,cote_grand_triangle,0])
        rotate([0,0,angle])
        translate([-3*cote_grand_triangle,0,0])
        support_triangles();
        translate([hauteur_grand_triangle+epaisseur/2,-(hauteur_flycase+2*epaisseur),-0.5])
        cube([epaisseur_flycase + 2*epaisseur, hauteur_flycase + 2*epaisseur, largeur_support+1]);
    }
    translate([hauteur_grand_triangle+epaisseur/2,-(hauteur_flycase+epaisseur),0])
    fente_flycase();

}


module barre(longueur_barre){
    rotate([90,0,0])
    difference(){
        linear_extrude(height=longueur_barre+2*largeur_support) 
        polygon(points=[[0,0],[cote_grand_triangle,0],[cote_grand_triangle/2,hauteur_grand_triangle]],paths=[ [0,1,2] ]);
        triangle(largeur_support);
        translate([0,0,longueur_barre+largeur_support]) triangle(largeur_support);
    }
    translate([0,-longueur_barre-largeur_support,-(epaisseur+epaisseur_minkowski)])
        cube([cote_grand_triangle, longueur_barre, epaisseur+epaisseur_minkowski]);
}

module support_2(){
        translate([0,0,epaisseur_minkowski])
        minkowski (){
            cube([longueur_PC, 3*largeur_support, epaisseur], center=true);
            rotate([90,0,0]) cylinder(r=epaisseur_minkowski, h=epaisseur_minkowski, $fn=detail);
        }
        translate([longueur_PC/2,3*largeur_support/2,0])
                rotate([-90,0,180])
                pattern_triangle(3*largeur_support+epaisseur_minkowski, nb_triangles,nb_triangles);
}

module support_3(){
    translate([epaisseur/2+0.9,0,-0.5])
    union(){
        support_2();
        rotate([0,180,0])
        translate([0.5*cote_grand_triangle,largeur_support+longueur_support/2,0])barre(longueur_support);
            

        translate([-2.5*cote_grand_triangle,0,0])
        rotate([0,180,0])
        translate([0,largeur_support+longueur_support/2,0])
            barre(longueur_support);
    }
}

module support_complet(){
    support_1();
    translate([0,0,longueur_support+largeur_support])
    support_1();
    translate([2*hauteur_grand_triangle,2*cote_grand_triangle,longueur_support/2+largeur_support])
    rotate([-90,0,angle])
    support_3();

}
//barre(longueur_support);
//barre((longueur_support-3*largeur_support)/2);
support_1();
//support_2();
//support_complet();


