angle = 75;
epaisseur = 2;
marge = 10;

hauteur_alim = 80;
longueur_alim = 140;
largeur_alim = 150;

hauteur_poignee = 50;

hauteur_totale = hauteur_alim + hauteur_poignee;

largeur = largeur_alim;
bordure = 30;
longueur_prisme = hauteur_totale / tan(angle);

longueur_lcd = 23;
longueur_lcd_pcb = 30.2;
hauteur_lcd = 10.5;
epaisseur_lcd = 6.5;

diam_ext_banana = 11;
diam_int_banana = 5.2;

diam_ext_bnc = 12;
diam_int_bnc = 9.5;

diam_ext_potentiometre = 15;
diam_int_potentiometre = 7.5;

diam_int_power_btn = 16.5;

epaisseur_pcb = 1.5;
espace = 15;

ecart_europlug = 19;
largeur_banana_pair = ecart_europlug+2*diam_ext_banana;
hauteur_tension = 21;

longueur_usb = 15.5;
hauteur_usb = 8;

diam_vis = 2.5;

longueur_poignee = 140;
epaisseur_poignee = 20;

module alim(){
    color("grey")
    translate([-longueur_alim/2,0,hauteur_alim/2])
    cube([longueur_alim,largeur_alim,hauteur_alim],center=true);
}

module accroche(long){
    rotate([0,90,0])
    difference(){
        cylinder(r=diam_vis, h=long, $fn=50);
        translate([0,0,-2])
        cylinder(d=diam_vis, h=long, $fn=50);
    }
}

module prisme(x,y,z){
    rotate([0,-90,-90])
    linear_extrude(height = y, center = true) {
    polygon(points = [[0, 0], [z, 0],[0, x]], paths = [[0, 1, 2]]);
    }
}

module lcd_screen(){
    translate([-hauteur_lcd/2,0,-epaisseur_lcd])
    union(){
        color("White")
        cube([hauteur_lcd, longueur_lcd, epaisseur_lcd]);
        translate([0,-(longueur_lcd_pcb-longueur_lcd)/2,-epaisseur_pcb])
        color("Green")
        cube([hauteur_lcd, longueur_lcd_pcb, epaisseur_pcb]);
    }
}

module accroche_lcd(){
    diam = (longueur_lcd_pcb-longueur_lcd)/2;
    translate([0,marge-largeur_alim/2,-epaisseur_lcd])
    difference(){
    union(){
        translate([0,-diam/2,0])
        difference(){
            cylinder(d1=diam, d2=1.5*diam, h=epaisseur_lcd, $fn=25);
            cylinder(d=2, h=epaisseur_lcd, $fn=25);
        }
        translate([0,longueur_lcd+diam/2,0])
        difference(){
            cylinder(r1=2, r2=3, h=epaisseur_lcd, $fn=25);
            cylinder(d=2, h=epaisseur_lcd, $fn=25);
        }
    }
    translate([0,0,epaisseur_lcd])
    lcd_screen();
    }
}

module aeration(nb_lignes, nb_colones, diametre){
    espace = 4*diametre/3;
    for(lignes =[0 : 1 : nb_lignes]){
        for(colones =[0 : 1 : nb_colones]){
		    translate([lignes*espace,(colones+(lignes%2)/2)*espace,0])
    cylinder (d=diametre, h=20, $fn=15);
		}
    }
}

module bnc(){
    color("Grey")
    union(){
        cylinder(d=diam_ext_bnc, h=15, $fn=50);
        translate([0,0,-10])
        difference(){
            cylinder(d=diam_int_bnc, h=15, $fn=50);
            translate([0,-6,2.5])
            #cube([diam_int_bnc,4,15], center=true);
            translate([0,6,2.5])
            #cube([diam_int_bnc,4,15], center=true);
        }
    }
}

module banana(){
    cylinder(d=diam_ext_banana, h=20, $fn=50);
    translate([0,0,-10])
    cylinder(d=diam_int_banana, h=20, $fn=50);
}

module banana_pair(){
    color("Red")
    banana();
    translate([0,ecart_europlug,0])
    color("Black")
    banana();
}

module potentiometre(){
    color("Black")
    cylinder(d=diam_ext_potentiometre, h=10, $fn=50);
    color("White")
    translate([-diam_ext_potentiometre/2,0,5])
    rotate([0,0,45])
    cube([2,2,10], center=true);
    translate([0,0,-10])
    cylinder(d=diam_int_potentiometre, h=10, $fn=50);
}

module power_btn(){
    cylinder(d=diam_int_power_btn, h=37, $fn=50, center=true);
}

module usb(){
    rotate([0,0,90])
    union(){
      cube([longueur_usb, 10, hauteur_usb], center=true);
      translate([15,0,0])
      rotate([90,0,0])
      cylinder(d=3, h=10, $fn=50, center=true);
      translate([-15,0,0])
      rotate([90,0,0])
      cylinder(d=3, h=10, $fn=50, center=true);
    }
}

module tension(adjustable){    
    translate([0,-largeur_alim/2,0])
    rotate([0,angle,0])
    union(){
        translate([0,marge,0])
        lcd_screen();
        if(adjustable){
        translate([0,marge+longueur_lcd_pcb+espace,0])
        potentiometre();
        }
        translate([0,marge+longueur_lcd_pcb+diam_ext_potentiometre+2*espace,0])
        banana_pair();
        translate([0,marge+longueur_lcd_pcb+largeur_banana_pair+3*espace,0])
        bnc();
        //translate([-hauteur_tension/2,0,-epaisseur])
        //cube([hauteur_tension,largeur_alim,epaisseur]);
    }
}

module tension_position(rang, adjustable){
    tension_x = cos(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    tension_z = sin(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    translate([bordure+tension_x, 0, hauteur_totale-tension_z])
    tension(adjustable);
}

module accroche_lcd_position(rang){
    tension_x = cos(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    tension_z = sin(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2);
    translate([bordure+tension_x, 0, hauteur_totale-tension_z])
    rotate([0,angle,0]) 
   #accroche_lcd();
}

module support_lm2596(rang){
    support_x = cos(angle)*(hauteur_tension*(rang-1)+hauteur_tension/2)-20;
    support_z = sin(angle)*(hauteur_tension*(rang-1)+1.5*hauteur_lcd+hauteur_tension/2);
    translate([bordure+support_x, marge/2+longueur_lcd_pcb-largeur/2, hauteur_totale-support_z])
    cube([20, 45,epaisseur]);
}

module boitier_prisme(){
    difference(){
        prisme(longueur_prisme, largeur, hauteur_totale);
        translate([-epaisseur, 0, epaisseur])
        prisme(longueur_prisme-epaisseur, largeur-2*epaisseur, hauteur_totale);
    }
}

module boitier_base(){
    translate([bordure,0,0])
    boitier_prisme();
    translate([0,-largeur/2,0])
    difference(){
        cube([bordure, largeur, hauteur_totale]);
        translate([0,epaisseur,epaisseur])
        cube([2*bordure, largeur-2*epaisseur, hauteur_alim-epaisseur]);
        translate([epaisseur,epaisseur,hauteur_alim])
        cube([2*bordure, largeur-2*epaisseur, hauteur_poignee-epaisseur]);
        translate([-epaisseur,-epaisseur,hauteur_alim])
        cube([2*epaisseur, largeur+2*epaisseur, hauteur_poignee+epaisseur]);
    }
}

module boitier_perce(){
    difference(){
        boitier_base();
        tension_position(1);
        tension_position(2);
        tension_position(3);
        tension_position(4, true);
        tension_position(5, true);
        
        btn_z = hauteur_totale-15;
        btn_x = btn_z/tan(angle);

        translate([bordure+btn_x-18, (largeur_alim/2-2*epaisseur-diam_int_power_btn), hauteur_totale-btn_z])
        rotate([0,angle,0])
        #power_btn();
        
        usb_z = hauteur_totale-20;
        usb_x = usb_z/tan(angle);
        
        translate([bordure+usb_x, -2*longueur_usb, hauteur_totale-usb_z])
        rotate([0,angle-90,0])
        #usb();
        
        translate([bordure+usb_x, longueur_usb, hauteur_totale-usb_z])
        rotate([0,angle-90,0])
        #usb();
        
        translate([epaisseur+marge/2,largeur/2+10,epaisseur+marge
])
        rotate([90,0,0])
        aeration(8, 14, 3);
        translate([epaisseur+marge/2,-largeur/2+10,epaisseur+marge
])
        rotate([90,0,0])
        aeration(8, 14, 3);
    }
    accroche_lcd_position(1);
    accroche_lcd_position(2);
    accroche_lcd_position(3);
    accroche_lcd_position(4);
    accroche_lcd_position(5);
    
    lng_accroche_1 = bordure+longueur_prisme-epaisseur;
    translate([0, largeur_alim/2-diam_vis-epaisseur/2, diam_vis+epaisseur/2])
    difference(){
        accroche(lng_accroche_1);
        translate([lng_accroche_1+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([0, -(largeur_alim/2-diam_vis-epaisseur/2), diam_vis+epaisseur/2])
    difference(){
        accroche(lng_accroche_1);
        translate([lng_accroche_1+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([0, 0, diam_vis+epaisseur/2])
    difference(){
        accroche(lng_accroche_1);
        translate([lng_accroche_1+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    
    lng_accroche_2 = bordure+hauteur_poignee/tan(angle);
    translate([0, largeur_alim/2-diam_vis-epaisseur/2,  hauteur_alim-diam_vis])
    difference(){
        accroche(lng_accroche_2);
        translate([lng_accroche_2+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([0, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_alim-diam_vis])
    difference(){
        accroche(lng_accroche_2);
        translate([lng_accroche_2+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([0, 0, hauteur_alim-diam_vis])
    difference(){
        accroche(lng_accroche_2);
        translate([lng_accroche_2+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    
    lng_accroche_3 = bordure+(hauteur_poignee-diam_vis-epaisseur/2)/tan(angle)-epaisseur;
    translate([epaisseur, largeur_alim/2-diam_vis-epaisseur/2, hauteur_alim+diam_vis+epaisseur/2])
    difference(){
        accroche(lng_accroche_3);
        translate([lng_accroche_3+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([epaisseur, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_alim+diam_vis+epaisseur/2])
    difference(){
        accroche(lng_accroche_3);
        translate([lng_accroche_3+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    
    lng_accroche_4 = bordure-epaisseur;
    translate([epaisseur, largeur_alim/2-diam_vis-epaisseur/2, hauteur_totale-(diam_vis+epaisseur/2)])
    difference(){
        accroche(lng_accroche_4);
        translate([lng_accroche_4+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    translate([epaisseur, -(largeur_alim/2-diam_vis-epaisseur/2), hauteur_totale-(diam_vis+epaisseur/2)])
    difference(){
        accroche(lng_accroche_4);
        translate([lng_accroche_4+5, 0, 0])
        rotate([0,angle-90,0])
        cube([10,10,10], center=true);
    }
    
    //support_lm2596(1);
    //support_lm2596(2);
    //support_lm2596(3);
    support_lm2596(4);
    support_lm2596(5);
    
}

module poignee(){
    difference(){
        cube([longueur_poignee, epaisseur_poignee, hauteur_poignee], center=true);
 
    translate([0,0,hauteur_poignee/2-epaisseur_poignee/2-2*longueur_poignee])
    rotate([90,0,0])
    difference(){
        cylinder(r=2*longueur_poignee, h=epaisseur_poignee+0.5, center=true, $fn=100);
        rotate_extrude(angle = 360, convexity = 20, $fn=100)
        translate([2*longueur_poignee, 0, 0])
        scale([.5,1.5])circle(d=epaisseur_poignee/1.5);
        
        translate([longueur_poignee+(longueur_poignee-2*epaisseur_poignee)/2,0,0])
        cube([2*longueur_poignee,4*longueur_poignee,2*epaisseur_poignee], center=true);
        translate([-longueur_poignee-(longueur_poignee-2*epaisseur_poignee)/2,0,0])
        cube([2*longueur_poignee,4*longueur_poignee,2*epaisseur_poignee], center=true);
    }
    translate([longueur_poignee/2-epaisseur_poignee/2,0,-1-hauteur_poignee/2])
    cylinder(d=3, h=25, $fn=50);
    translate([-longueur_poignee/2+epaisseur_poignee/2,0,-1-hauteur_poignee/2])
    cylinder(d=3, h=25, $fn=50);
}
}

module couvercle(){
    difference(){
        translate([0,-largeur/2,0])
        cube([hauteur_poignee, largeur, epaisseur]);
        
        translate([(diam_vis+epaisseur/2),largeur_alim/2-diam_vis-epaisseur/2,-0.1])
        union(){
            cylinder(d1=2*diam_vis, d2=diam_vis, h=2, $fn=50);
            cylinder(d=diam_vis, h=20, $fn=50);
        }
        translate([(diam_vis+epaisseur/2),-(largeur_alim/2-diam_vis-epaisseur/2),-0.1])
        #union(){
            cylinder(d1=2*diam_vis, d2=diam_vis, h=2, $fn=50);
            cylinder(d=diam_vis, h=20, $fn=50);
        }
        
        translate([hauteur_poignee-(diam_vis+epaisseur/2),largeur_alim/2-diam_vis-epaisseur/2,-0.1])
        union(){
            cylinder(d1=2*diam_vis, d2=diam_vis, h=2, $fn=50);
            cylinder(d=diam_vis, h=20, $fn=50);
        }
        translate([hauteur_poignee-(diam_vis+epaisseur/2),-(largeur_alim/2-diam_vis-epaisseur/2),-0.1])
        #union(){
            cylinder(d1=2*diam_vis, d2=diam_vis, h=2, $fn=50);
            cylinder(d=diam_vis, h=20, $fn=50);
        }
    }
}


translate([0,0,hauteur_totale])
rotate([0,90,0])
color("blue")
couvercle();

boitier_perce();
alim();
translate([-longueur_poignee/2,0,hauteur_alim+hauteur_poignee/2])
poignee();

