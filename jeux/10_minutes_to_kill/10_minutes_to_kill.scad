largeur_boite = 190;
longueur_boite = 190;
longueur_tuile = 88;
largeur_tuile = 88;
longueur_carte_perso = 41;
largeur_carte_perso = 41;
nb_cartes_perso = 28;
longueur_aide_jeu = 180;
largeur_aide_jeu = 42;
nb_aide_jeu = 5;
nb_tuiles = 30;
epaisseur_tuile = 2.4;
epaisseur = 2;
longueur_socle_pion = 15;
largeur_socle_pion = 10;
nb_pions = 20;
longueur_rangement_tuiles = largeur_boite;
largeur_rangement_tuiles = largeur_tuile+4*epaisseur;
longueur_rangement_pion = longueur_boite-largeur_rangement_tuiles;
nb_lignes = floor((longueur_rangement_pion-epaisseur)/(longueur_socle_pion+epaisseur));
nb_pions_par_ligne = nb_pions/nb_lignes;
largeur_rangement_pion = nb_pions_par_ligne*(largeur_socle_pion+epaisseur) + epaisseur;

module triangle_decoupe(longueur, largeur, hauteur){
	translate([-largeur/2,0,hauteur/2]) rotate([-90,0,0]) linear_extrude(height=longueur, center=true) polygon(points=[[0,0],[largeur,0],[largeur/2,5*hauteur/4]], paths=[[0,1,2]]);
}

module bloc_carte(longueur_carte, largeur_carte, hauteur_bloc, epaisseur){
	difference(){
		cube([longueur_carte+2*epaisseur, largeur_carte+2*epaisseur, hauteur_bloc], center=true);
		cube([longueur_carte, largeur_carte, 2*hauteur_bloc], center=true);
		triangle_decoupe(largeur_carte+3*epaisseur, longueur_carte, 2*hauteur_bloc);
		rotate([0,0,90]) triangle_decoupe(longueur_carte+3*epaisseur, largeur_carte+2*epaisseur, 2*hauteur_bloc);
	}
}

module rangement_tuiles(){
    hauteur_bloc = (nb_tuiles/2)*epaisseur_tuile;
	union(){
		translate([0,0,-epaisseur/2]) 
        cube([longueur_rangement_tuiles, largeur_rangement_tuiles, epaisseur],center=true);
		translate([(longueur_tuile+2*epaisseur)/2,0,hauteur_bloc/2]) bloc_carte(longueur_tuile, largeur_tuile, hauteur_bloc, epaisseur);
		translate([-(longueur_tuile+2*epaisseur)/2,0,hauteur_bloc/2]) bloc_carte(longueur_tuile, largeur_tuile, hauteur_bloc, epaisseur);
	}
}

module rangement_cartes(){
    translate([0,0,-epaisseur/2]) 
        cube([longueur_rangement_tuiles, largeur_rangement_tuiles, epaisseur],center=true);
    translate([0,2*epaisseur-(largeur_rangement_tuiles-largeur_aide_jeu)/2,(epaisseur+nb_aide_jeu*epaisseur_tuile)/2])
    bloc_carte(longueur_aide_jeu, largeur_aide_jeu, epaisseur+nb_aide_jeu*epaisseur_tuile, epaisseur);
    for(cartes =[0 : 1 :3]){
    translate([2.5*epaisseur-longueur_rangement_tuiles/2+(0.5+cartes)*(largeur_carte_perso+2*epaisseur),(largeur_rangement_tuiles-largeur_carte_perso)/2-2*epaisseur,(epaisseur+nb_cartes_perso/4*epaisseur_tuile)/2])
    bloc_carte(longueur_carte_perso, largeur_carte_perso, epaisseur+nb_cartes_perso/4*epaisseur_tuile, epaisseur);
    }
}

module support_rangement_cartes(){
    difference(){
        cube([longueur_rangement_tuiles, largeur_rangement_tuiles, 3*epaisseur],center=true);
        cube([longueur_rangement_tuiles-2*epaisseur, largeur_rangement_tuiles-2*epaisseur, 4*epaisseur],center=true);
    }
}

module rangement_pion_1(){
    longueur = 100;
    largeur = 80;
    difference(){
        cube([longueur_rangement_pion, largeur_rangement_pion, 3*epaisseur]);
        for(lignes =[0 : 1 : nb_lignes-1]){
        for(pions =[0 : 1 : nb_pions_par_ligne-1]){
        translate([epaisseur+lignes*(longueur_socle_pion+epaisseur),epaisseur+pions*(largeur_socle_pion+epaisseur),0.1+1.5*epaisseur])
        cube([longueur_socle_pion,largeur_socle_pion,2*epaisseur]);
        }
    }
    }
}


rangement_tuiles();
translate([0,0,40])
rangement_cartes();
translate([0,0,40-(5/2)*epaisseur])
support_rangement_cartes();