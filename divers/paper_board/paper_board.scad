cote_barre = 20.5+0.5;
angle = 90-atan(7.5);
epaisseur = 3;
diametre_vis = 6;
diametre_vis_fixation = 3.5;
diametre_ecrou = 11.5;
largeur_ecrou = 10;
epaisseur_ecrou = 5;

hauteur_bloc = 20.5;
longueur_bloc = cote_barre+2*epaisseur;
largeur_bloc = cote_barre+3*epaisseur+epaisseur_ecrou;
largeur_fixation = 10;
hauteur_fixation = 15;

supplement = hauteur_bloc*tan(angle);


module barre(){
    cube([cote_barre, cote_barre, 100], center=true);
}

module fixation(){
    cube([cote_barre,largeur_fixation,hauteur_fixation], center=true);
    translate([0,0,-hauteur_fixation]/2)
    rotate([0,270,0])
    translate([0,-largeur_fixation/2,0])
    prisme(largeur_fixation-supplement, -hauteur_bloc, cote_barre);
    translate([-cote_barre/2,(largeur_fixation)/2-supplement,-(hauteur_bloc+hauteur_fixation)/2])
    cube([cote_barre, supplement, hauteur_bloc]);
}

module prisme_angle(base, angle, longueur){
    oppose = base*tan(angle);
    linear_extrude(height=longueur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,base],
                    [-oppose,base],
                    ], paths=[[0,1,2]]);
}

module prisme(cote1, cote2, longueur){
    linear_extrude(height=longueur, center=true, convexity = 0, twist = 0) 
                polygon(points=[
                    [0,0],
                    [0,cote1],
                    [cote2,cote1],
                    ], paths=[[0,1,2]]);
}

module trapeze(){
    
    difference(){
        cube([largeur_bloc,longueur_bloc+supplement, hauteur_bloc], center = true);
        translate([0,-(longueur_bloc-supplement)/2-0.01,hauteur_bloc/2+0.01])
        rotate([0,90,0])
        prisme(-supplement, hauteur_bloc, largeur_bloc+1);
        translate([0,(longueur_bloc-supplement)/2+0.01,-hauteur_bloc/2-0.01])
        rotate([0,270,0])
        prisme(supplement, hauteur_bloc, largeur_bloc+1);
    }
}

module part1(){
    position_ecrou = (cote_barre+epaisseur_ecrou)/2+epaisseur;
    difference(){
        union(){
            translate([-epaisseur+(largeur_bloc-cote_barre)/2,0,0])
            trapeze();
            translate([0,supplement-(longueur_bloc+largeur_fixation)/2,(hauteur_bloc+hauteur_fixation)/2])
            fixation();
        }
        rotate([-angle, 0, 0])
        barre();
        
        rotate([0, 90, 0])
        cylinder(d=diametre_vis, h=largeur_bloc, $fn=100);

        translate([position_ecrou,0,0])
        rotate([-angle, 0, 0])
        rotate([0, 90, 0])
        cylinder(d=diametre_ecrou, h=epaisseur_ecrou, $fn=6, center=true);

        rotate([-angle, 0, 0])
        translate([position_ecrou,0,-hauteur_bloc/4-1])  
        cube([epaisseur_ecrou,largeur_ecrou,hauteur_bloc/2], center=true);
        
        translate([-cote_barre/4,epaisseur-(longueur_bloc+largeur_fixation)/2,(hauteur_bloc+hauteur_fixation)/2]) 
        rotate([0, 90, 0])
        #cylinder(d=diametre_vis_fixation, h=cote_barre, $fn=100, center=true);
    }
}

part1();
