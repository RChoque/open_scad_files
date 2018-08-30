epaisseur_plache=18;
epaisseur_ecran=6;
largeur_ecran=245;
longueur_ecran=385;
largeur_fixation=50;
epaisseur_accroche=3;
bordure=15;

module accroche_top(){
    cube([14,10,epaisseur_accroche]);
    translate([3.5,5.5,-5])
    cylinder(d=2.5, h=10, $fn=20);
}

module accroche_bottom(){
    cube([24,20,epaisseur_accroche]);
    translate([9,24-14,-5])
    cylinder(d=2.5, h=10, $fn=20);
}

module screen(){
    cube([longueur_ecran,largeur_ecran,epaisseur_ecran],center=true);
    translate([longueur_ecran/2-9,largeur_ecran/2,0])
    accroche_top();
    translate([-(longueur_ecran/2-14+(14-9)),10+largeur_ecran/2,0])
    rotate([0,0,180])
    accroche_top();
    
    translate([24-longueur_ecran/2,20-largeur_ecran/2-20,0])
    rotate([0,0,180])
    accroche_bottom();
    translate([longueur_ecran/2-24,-largeur_ecran/2-20,0])
    accroche_bottom();
}

module base_fixation(){
    translate([largeur_fixation/2,largeur_fixation/2,epaisseur_plache/2])
    difference(){
    union(){
    cube([largeur_fixation,largeur_fixation,epaisseur_plache],center=true);
        translate([bordure/2, bordure/2, -(epaisseur_ecran+epaisseur_plache)/2])
        cube([largeur_fixation+bordure,largeur_fixation+bordure,epaisseur_ecran],center=true);
    }
    translate([largeur_fixation/4,(largeur_fixation+bordure)/2,-(epaisseur_ecran+0.1+epaisseur_plache/2)])
    vis();
    translate([-largeur_fixation/4,(largeur_fixation+bordure)/2,-(epaisseur_ecran+0.1+epaisseur_plache/2)])
    vis();
    translate([(largeur_fixation+bordure)/2,largeur_fixation/4,-(epaisseur_ecran+0.1+epaisseur_plache/2)])
    vis();
    translate([(largeur_fixation+bordure)/2,-largeur_fixation/4,-(epaisseur_ecran+0.1+epaisseur_plache/2)])
    vis();
    }
}

module fixation_haut_droit(){
    difference(){
        base_fixation();
        translate([largeur_fixation-1.5*bordure, largeur_fixation-1.5*bordure, epaisseur_plache-epaisseur_ecran+0.1])
        translate([-longueur_ecran/2, -largeur_ecran/2, epaisseur_ecran/2])
    #screen();
    }
}

module fixation_haut_gauche(){
    difference(){
        rotate([0,0,90])
        base_fixation();
        translate([-(largeur_fixation-1.5*bordure), largeur_fixation-1.5*bordure, epaisseur_plache-epaisseur_ecran+0.1])
        translate([longueur_ecran/2, -largeur_ecran/2, epaisseur_ecran/2])
    #screen();
    }
}

module fixation_bas_droit(){
    difference(){
        rotate([0,0,-90])
        base_fixation();
        translate([(largeur_fixation-1.5*bordure), -(largeur_fixation-1.5*bordure), epaisseur_plache-epaisseur_ecran+0.1])
        translate([-longueur_ecran/2, largeur_ecran/2, epaisseur_ecran/2])
    #screen();
    }
}

module fixation_bas_gauche(){
    difference(){
        rotate([0,0,180])
        base_fixation();
        translate([-(largeur_fixation-1.5*bordure), -(largeur_fixation-1.5*bordure), epaisseur_plache-epaisseur_ecran+0.1])
        translate([longueur_ecran/2, largeur_ecran/2, epaisseur_ecran/2])
    #screen();
    }
}

module vis(){
    cylinder(d1=8, d2=3.5, h=4, $fn=50);
    cylinder(d=3.5, h=30, $fn=20);
}

fixation_haut_droit();
