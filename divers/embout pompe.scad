detail = 50;
marge = 0.1;
diametre_interieur_pompe = 7.5;
hauteur_embout_pompe = 10;
diametre_interieur_matelas = 8.5;
hauteur_embout_matelas = 10;
epaisseur = 1.5;

difference(){
union(){
cylinder(h=hauteur_embout_pompe, r=diametre_interieur_pompe/2, $fn=detail);
translate([0,0,hauteur_embout_pompe-marge]) cylinder(h=hauteur_embout_matelas, r1=diametre_interieur_pompe/2+epaisseur, r2=diametre_interieur_matelas/2, $fn=detail);
translate([0,0,hauteur_embout_pompe+hauteur_embout_matelas-marge]) cylinder(h=hauteur_embout_matelas, r1=diametre_interieur_matelas/2, r2=diametre_interieur_matelas/2-epaisseur, $fn=detail);
}
cylinder(h=hauteur_embout_pompe+2*hauteur_embout_matelas+marge, r1=diametre_interieur_pompe/2-epaisseur, r2=diametre_interieur_matelas/2-epaisseur, $fn=detail);
}
