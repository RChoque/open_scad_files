diametre = 14;
diametre_voulu = 10;


module pepite(){
    difference(){
        import("Garland.stl");
        translate([0,0,13.925]) 
            cylinder(h=10, r=5, $fn=40);
    }
    cylinder(h=12, r=4, $fn=40);
}

scale(diametre_voulu/diametre) pepite();


