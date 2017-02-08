rayon_accroche = 4;
marge = 10;
rayon_vis = 1.5;
epaisseur = 2;
longueur_rpi = 93;
largeur_rpi = 56;
longueur_k8200 = 115;
largeur_k8200 = 68;
longueur_relais = 51;
largeur_relais = 39;
longueur_transfo = 48;
largeur_transfo = 36;
hauteur_boite = longueur_transfo+marge;
longueur_boite = largeur_rpi+largeur_k8200+4*marge-2*rayon_accroche;
largeur_boite = longueur_k8200+3*marge;


module cube_arrondi(longueur, largeur, hauteur){
    minkowski(){
        cube([longueur, largeur, hauteur], center=true);
        cylinder(r=rayon_accroche, $fn=50, center=true);
    }
}

module boite_arrondie(longueur, largeur, hauteur){
    difference(){
        cube_arrondi(longueur+2*epaisseur, largeur+2*epaisseur, hauteur+epaisseur);
        translate([0,0,epaisseur/2+0.1])
        cube_arrondi(longueur, largeur, hauteur);
    }
}

module accroche(r1, r2, hauteur_accroche){
    difference(){
        cylinder (r=r1, h=hauteur_accroche, $fn=50);
        cylinder (r=r2, h=hauteur_accroche+1, $fn=50);
    }
}

module accroche2(r1, r2, hauteur_accroche){
    difference(){
        cylinder (r2=r1, r1=2*r1,  h=hauteur_accroche, $fn=50);
        cylinder (r=r2, h=hauteur_accroche+1, $fn=50);
    }
}

module accroche45(r1, r2, hauteur_accroche){
    difference(){
        cylinder (r1=r1+hauteur_accroche, r2=r1, h=hauteur_accroche, $fn=100);
        cylinder (r=r2, h=hauteur_accroche+1, $fn=50);
    }
}

module support_raspberry_pi(){
    //#cube([longueur_rpi,largeur_rpi,epaisseur]);
    //#translate([-17,(largeur_rpi-24)/2,0])cube([17,24,epaisseur]);
    translate([35.5, 18, 0])
    accroche2(2.5, 1, 8);
    translate([longueur_rpi-5, largeur_rpi-12.5, 0])
    accroche2(2.5, 1, 8);
}

module support_carte_k8200(){
    //#cube([longueur_k8200,largeur_k8200,epaisseur]);
    translate([5, 5, 0])
    accroche2(2.5, 1, 8);
    translate([longueur_k8200-5, 5, 0])
    accroche2(2.5, 1, 8);
    translate([5, largeur_k8200-5, 0])
    accroche2(2.5, 1, 8);
    translate([longueur_k8200-5, largeur_k8200-5, 0])
    accroche2(2.5, 1, 8);
}

module support_carte_relais(){
    union(){
    //#cube([longueur_relais,largeur_relais,epaisseur]);
    translate([2.5, 2.5, 0])
    accroche45(2.5, 1, 5);
    translate([longueur_relais-2.5, 2.5, 0])
    accroche45(2.5, 1, 5);
    translate([2.5, largeur_relais-2.5, 0])
    accroche45(2.5, 1, 5);
    translate([longueur_relais-2.5, largeur_relais-2.5, 0])
    accroche45(2.5, 1, 5);
    }
}

module support_carte_transfo(){
    rotate([0,0,90])
    union(){
    //#cube([longueur_transfo,largeur_transfo,epaisseur]);
    translate([2.5, 2.5, 0])
    accroche45(2.5, 1, 5);
    translate([longueur_transfo-2.5, 2.5, 0])
    accroche45(2.5, 1, 5);
    translate([2.5, largeur_transfo-2.5, 0])
    accroche45(2.5, 1, 5);
    translate([longueur_transfo-2.5, largeur_transfo-2.5, 0])
    accroche45(2.5, 1, 5);
    }
}

module prise_extruder(){
    cube([11,19,20], center=true);
    translate([0,25/2,0])
    cylinder(d=3, h=20, $fn=30, center=true);
    translate([0,-25/2,0])
    cylinder(d=3, h=20, $fn=30, center=true);
}

module prise_axe_xyz(){
    cylinder(d=15, h=20, $fn=30, center=true);
    translate([0,11,0])
    cylinder(d=3, h=20, $fn=30, center=true);
    translate([0,-11,0])
    cylinder(d=3, h=20, $fn=30, center=true);
}

module prise_alim(){
    translate([4.5-11.5/2,0,0])
    union(){
        translate([3.5,0,0])
        cube([7,9,20], center=true);
        cylinder(d=9, h=20, $fn=30, center=true);
    }
    translate([16.5/2,0,0])
    cylinder(d=3, h=20, $fn=30, center=true);
    translate([-16.5/2,0,0])
    cylinder(d=3, h=20, $fn=30, center=true);
}

module bouton_on(){
    cylinder(d=19.5, h=20, $fn=30, center=true);
    translate([10,0,0])
    cube([5,2,20], center=true);
}

module nappe_camera(){
    translate([0,0,-8.5])
    cube([10,1,17]);
}

module ventilateur(diametre){
    cylinder (d=diametre, h=20, $fn=100);
    translate([diametre/2,diametre/2,0])
    cylinder (r=rayon_vis, h=20, $fn=100);
    translate([diametre/2,-diametre/2,0])
    cylinder (r=rayon_vis, h=20, $fn=100);
    translate([-diametre/2,diametre/2,0])
    cylinder (r=rayon_vis, h=20, $fn=100);
    translate([-diametre/2,-diametre/2,0])
    cylinder (r=rayon_vis, h=20, $fn=100);
}

module aeration(nb_lignes, nb_colones, diametre){
    espace = 4*diametre/3;
    for(lignes =[0 : 1 : nb_lignes]){
        for(colones =[0 : 1 : nb_colones]){
		    translate([lignes*espace,(colones+(lignes%2)/2)*espace,0])
    cylinder (d=diametre, h=20, $fn=6);
		}
    }
}

module aeration_principale(){
    difference(){
            aeration(11,18,3);
            translate([(11*3)/2-6, (18*3)/2+2, -5])
            cube([23,23,30]);
        }
}

module usb(){    
    cube([20,12,9.5],center=true);
}

module switch(){
    union(){
        rotate([0,90,0])
        cylinder(r=3, h=10);
        translate([-10,0,0])
        cube([23,13,30],center=true);
    }
}

module boite(){
    boite_arrondie(longueur_boite,largeur_boite,hauteur_boite);
    translate([longueur_boite/2+epaisseur,largeur_boite/2+epaisseur,(epaisseur-hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, hauteur_boite);

    translate([-(longueur_boite/2+epaisseur),largeur_boite/2+epaisseur,-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);

    translate([-(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);

    translate([(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    accroche(rayon_accroche, rayon_vis, epaisseur+hauteur_boite);
    
    translate([-longueur_boite/2-rayon_accroche+largeur_rpi+marge,largeur_boite/2+rayon_accroche-longueur_k8200,-(epaisseur+hauteur_boite)/2])
    rotate([0,0,90])
    color("red") 
    support_raspberry_pi();
    
    translate([longueur_boite/2+rayon_accroche-2*marge,largeur_boite/2+rayon_accroche-longueur_k8200-marge,-(epaisseur+hauteur_boite)/2])
    rotate([0,0,90])
    color("green")
    support_carte_k8200();
    
    translate([-longueur_relais-marge,2*epaisseur-largeur_boite/2-2*rayon_accroche,largeur_relais-hauteur_boite/2+epaisseur+marge])
    rotate([-90,0,0])
    color("purple")
    support_carte_relais();
    
    translate([largeur_transfo+2*marge,2*epaisseur-largeur_boite/2-2*rayon_accroche,longueur_transfo-hauteur_boite/2+epaisseur+0.5*marge])
    rotate([-90,0,0])
    support_carte_transfo();
    
    
}

module boite_complete(){
    difference(){
        boite();
        //extrudeur
        translate([-longueur_boite/2-rayon_accroche+largeur_rpi+1.5*marge,largeur_boite/2,-hauteur_boite/2+2*marge])
        rotate([90,90,0])
        #prise_extruder();
        
        translate([longueur_boite/2,11+marge-largeur_boite/2,-hauteur_boite/2+1.5*marge])
        rotate([90,0,-90])
    #prise_alim();
        
        translate([longueur_boite/2,-21+22+2*marge-largeur_boite/2,-hauteur_boite/2+3*marge])
        rotate([0,90,0])
        #prise_axe_xyz();
        
        translate([longueur_boite/2,-21+2*22+3*marge-largeur_boite/2,-hauteur_boite/2+3*marge])
        rotate([0,90,0])
        #prise_axe_xyz();
        
        translate([longueur_boite/2,-21+3*22+4*marge-largeur_boite/2,-hauteur_boite/2+3*marge])
        rotate([0,90,0])
        #prise_axe_xyz();
        
        translate([longueur_boite/2,-21+4*22+5*marge-largeur_boite/2,-hauteur_boite/2+3*marge])
        rotate([0,90,0])
        #prise_axe_xyz();
        
        translate([-(longueur_boite/2+marge),longueur_rpi/4,0])
        #nappe_camera();
        
        translate([-longueur_boite/2,11+marge-largeur_boite/2,0])
        rotate([0,90,0])
        #bouton_on();
        
        translate([5+longueur_boite/2,26+marge-largeur_boite/2,hauteur_boite/2-marge])
        rotate([90,0,0])
        #usb();
        
        translate([2+longueur_boite/2,7+marge-largeur_boite/2,hauteur_boite/2-marge])
        rotate([90,0,0])
        #switch();
        
        translate([-10-longueur_boite/2,-marge,(hauteur_boite-marge)/2])
        rotate([0,90,0])
        #aeration_principale();
        
        translate([-longueur_boite/2-rayon_accroche+largeur_rpi+1.5*marge,longueur_k8200/2-marge,-hauteur_boite/2-5])
        cylinder(r=1.5, h=10, $fn=50);
        
        translate([-longueur_boite/2+3*marge,-longueur_k8200/2,-hauteur_boite/2-5])
        cylinder(r=1.5, h=10, $fn=50);
        
        translate([longueur_boite/2-3*marge,-longueur_k8200/2,-hauteur_boite/2-5])
        cylinder(r=1.5, h=10, $fn=50);
    }
    
    translate([3*epaisseur+longueur_boite/2,22+2*marge-largeur_boite/2,-hauteur_boite/2+5*marge])
    rotate([0,90,0])
    translate([-5,-280,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    import("X.dxf");
    
    translate([3*epaisseur+longueur_boite/2,2*22+3*marge-largeur_boite/2,-hauteur_boite/2+5*marge])
    rotate([0,90,0])
    translate([-25,-273,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    import("Y.dxf");
    
   
    translate([3*epaisseur+longueur_boite/2,3*22+4*marge-largeur_boite/2,-hauteur_boite/2+5*marge])
    rotate([0,90,0])
    translate([-5,-280,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    import("Z.dxf");
    
}

module couvercle_base(){
    difference(){
        cube_arrondi(longueur_boite+2*epaisseur, largeur_boite+2*epaisseur, epaisseur-rayon_accroche/4);
        translate([longueur_boite/2+epaisseur,largeur_boite/2+epaisseur,-(epaisseur+hauteur_boite)/2])
    color("blue")
    cylinder (r=rayon_vis, h=hauteur_boite+1, $fn=100);
        
        translate([-(longueur_boite/2+epaisseur),largeur_boite/2+epaisseur,-(epaisseur+hauteur_boite)/2])
    color("blue")
    cylinder (r=rayon_vis, h=hauteur_boite+1, $fn=100);

    translate([-(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    cylinder (r=rayon_vis, h=hauteur_boite+1, $fn=100);

    translate([(longueur_boite/2+epaisseur),-(largeur_boite/2+epaisseur),-(epaisseur+hauteur_boite)/2])
    color("blue")
    cylinder (r=rayon_vis, h=hauteur_boite+1, $fn=100);
    }
}

module couvercle(){
    difference(){
        couvercle_base();
    
      translate([longueur_boite/2+rayon_accroche-2*marge-largeur_rpi/2,largeur_boite/2+rayon_accroche-longueur_k8200-marge+3*longueur_rpi/4,-10])
        ventilateur(40);
        
      translate([longueur_boite/2+rayon_accroche-2*marge-largeur_rpi/2,largeur_boite/2+rayon_accroche-longueur_k8200-marge+3*longueur_rpi/4-45,-10])
        ventilateur(40);
        
    translate([-80,-90,1])
    linear_extrude(height = 2, center = true, convexity = 10)
    scale(0.55)
    import("OctoPrint_Logo.dxf");
    
    translate([-70,-340,1])
    linear_extrude(height = 2, center = true, convexity = 10)
    import("K8200.dxf");
}
    
}

//boite_complete();

//translate([0,0,10+hauteur_boite/2])
couvercle();