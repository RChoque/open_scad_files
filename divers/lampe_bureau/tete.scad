diam_tete=55;
diam_vis_haut=1.5;
diam_bulb = 38;
diam_bolle = 122;
hauteur_base_ampoule=10;
support_vis_haut=2.5;
hauteur_tete = 12;
epaisseur_cache = 3;
epaisseur=2;
ecart_vis = 48;
diam_vis_2 = 2;

//rotate([0,180,0])
//color("blue")
//import("tete_base.stl");

difference(){
union(){
difference(){
    cylinder(d=diam_tete, h=hauteur_tete, $fn=150);
    translate([0,0,epaisseur/2])
    cylinder(d=diam_tete-2*epaisseur, h=hauteur_tete+epaisseur, $fn=100);
    translate([0,0,-0.1])
    cylinder(d=diam_bulb+1.5*epaisseur, h=hauteur_tete+epaisseur, $fn=100);
    translate([ecart_vis/2,0,0])
    cylinder(d=diam_vis_2, h=50, $fn=10);
    translate([-ecart_vis/2,0,0])
    #cylinder(d=diam_vis_2, h=50, $fn=10);
    
}
translate([0,(diam_tete-support_vis_haut)/2-epaisseur+0.5,0])
rotate([0,0,180])
fixation_haute();
translate([0,-((diam_tete-support_vis_haut)/2-epaisseur+0.5),0])
fixation_haute();
}
translate([0,0,50+hauteur_tete])
    #sphere(d=diam_bolle, $fn=200);
}


module fixation_haute(){
    difference(){
        union(){
            cylinder(d=support_vis_haut, h=hauteur_tete, $fn=100);
            translate([0,-support_vis_haut/2,hauteur_tete/2])
            cube([support_vis_haut,support_vis_haut, hauteur_tete],center=true);
        }
        translate([0,0,-1])
        cylinder(d=diam_vis_haut, h=hauteur_tete+epaisseur, $fn=100);
    }
}



