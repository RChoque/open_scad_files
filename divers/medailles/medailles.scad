detail = 100;

module medaille(){
    difference(){
        union(){
    color("blue") cylinder(r=70, h=5, $fn=detail);
    translate([0,75,2.5]) color("blue") 
    difference(){
        cube([70,28,5], center=true);
        cube([52,12,6], center=true);
    }
}
    translate([0,0,3]) cylinder(r=62, h=5, $fn=detail);
}

}

module medaille_reduite(){
    scale([0.36,0.36,0.85]) medaille();
}

module medaille_evg(){
    medaille_reduite();
    translate([-35.5,-31.5,0.1])
    linear_extrude(4.5) 
    scale(0.75) import("evg.dxf");
}

module medaille_futur_marie(){
    medaille_reduite();
    translate([-77,-105,0.1])
    linear_extrude(4.5) 
    scale(0.72) import("futur_marie.dxf");
}

medaille_futur_marie();