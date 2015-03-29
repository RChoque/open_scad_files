epaisseur_mirroir = 3.9;
epaisseur_carton = 1.5;
epaisseur_chauf = 1.7;
epaisseur_metal = 2.5;
epaisseur_clip = 2;

longueur_mirroir = 200;
longueur_carton = 210;
longueur_chauf = 208.5;
longueur_metal = 217;
largeur_metal = 10.5;
longueur_clip = longueur_metal/5;
distance_min_clip = 30;

module plateau(){
    //plaque métal
    translate([0,0,epaisseur_metal/2])
    color("lime")
    cube([longueur_metal,longueur_metal,epaisseur_metal], center=true);
    
    //carton
    translate([0,0,epaisseur_metal+epaisseur_carton/2])
    color("yellow")
    cube([longueur_carton,longueur_carton,epaisseur_carton], center=true);
    
    //plateau chauffant
    translate([0,0,epaisseur_metal+epaisseur_carton+epaisseur_chauf/2])
    color("red")
    cube([longueur_chauf,longueur_chauf,epaisseur_chauf], center=true);
    
    //mirroir
    translate([0,0,epaisseur_metal+epaisseur_carton+epaisseur_chauf+epaisseur_mirroir/2])
    color("blue")
    cube([longueur_mirroir,longueur_mirroir,epaisseur_mirroir+0.2], center=true);
    
}

module clip(){
    epaisseur_totale = epaisseur_mirroir+epaisseur_carton+epaisseur_chauf+epaisseur_metal+epaisseur_clip;
    difference(){
        translate([-(epaisseur_clip+longueur_metal/2),-(epaisseur_clip+longueur_metal/2),-epaisseur_clip])
        cube([longueur_clip,longueur_clip,epaisseur_totale]);
        plateau();
        cube([longueur_metal-2*largeur_metal-2*epaisseur_clip,longueur_metal-2*largeur_metal-2*epaisseur_clip,epaisseur_totale], center = true);
    }
    longueur_cylindre = longueur_clip-(distance_min_clip+epaisseur_clip);
    rayon_cylindre = epaisseur_clip/1.6;
    translate([-(longueur_metal/2+epaisseur_clip) + (distance_min_clip+epaisseur_clip),-(longueur_metal/2-largeur_metal-epaisseur_clip)-rayon_cylindre,0])
        rotate([0,90,0]) cylinder(h=longueur_cylindre, r=rayon_cylindre, $fn=100);
    translate([-(longueur_metal/2-largeur_metal-epaisseur_clip)-rayon_cylindre,-(longueur_metal/2+epaisseur_clip) + (distance_min_clip+epaisseur_clip) + longueur_cylindre,0])
        rotate([90,0,0]) cylinder(h=longueur_cylindre, r=rayon_cylindre, $fn=100);
}


clip();
translate([-longueur_metal/2,-longueur_metal/2,-epaisseur_clip]) color("pink") cube([10,10,1]);