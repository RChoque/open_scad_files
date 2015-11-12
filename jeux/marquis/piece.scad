diametre_piece = 25.65;
epaisseur_piece = 2.1;
epaisseur_relief = 0.5;



    
module anneau(){
    difference(){
        cylinder (d=diametre_piece, h=2*epaisseur_relief, $fn=100, center=true);
        cylinder (d=diametre_piece-2*epaisseur_relief, h=2*epaisseur_relief+2, $fn=100, center=true);
    }
}

module pile(){
   anneau();
   translate([-6,-11.7,-epaisseur_relief])
   linear_extrude(2*epaisseur_relief) 
   scale(0.18) import("1.dxf");
}

module face1(){
   anneau();
    difference(){
   translate([-12,-12.5,-epaisseur_relief])
   linear_extrude(2*epaisseur_relief) 
   scale(0.18) import("portrait.dxf");
        difference(){
        cylinder (d=2*diametre_piece, h=4*epaisseur_relief, $fn=100, center=true);
        cylinder (d=diametre_piece-2*epaisseur_relief, h=4*epaisseur_relief+2, $fn=100, center=true);
    }
    }
}

module face2(){
   anneau();
    difference(){
   translate([-15.5,-5.5,-epaisseur_relief])
   rotate([0,0,-25])
    linear_extrude(2*epaisseur_relief) 
   scale(0.185) import("logo.dxf");
        difference(){
        cylinder (d=5*diametre_piece, h=4*epaisseur_relief, $fn=100, center=true);
        cylinder (d=diametre_piece-2*epaisseur_relief, h=4*epaisseur_relief+2, $fn=100, center=true);
    }
    }
}

module piece1(){
    hauteur = epaisseur_piece-2*epaisseur_relief;
    cylinder (d=diametre_piece, h=hauteur+0.1, $fn=100, center=true);
    translate([0,0,hauteur/2])
    pile();
    translate([0,0,-hauteur/2])
    face1();
}

module piece2(){
    hauteur = epaisseur_piece-2*epaisseur_relief;
    cylinder (d=diametre_piece, h=hauteur+0.1, $fn=100, center=true);
    translate([0,0,hauteur/2])
    pile();
    translate([0,0,-hauteur/2])
    face2();
}

piece2();