diametre_balance = 21;

difference(){
union(){
minkowski() {
    difference(){
        cylinder(d=diametre_balance-2*2, h= 2, $fn=100);
        translate([diametre_balance/2-2,0,diametre_balance/4])
        cube([diametre_balance,diametre_balance,diametre_balance], center=true);
    }
sphere(2, $fn=20);
}
difference(){
    cylinder(d=diametre_balance-6, h=15, $fn=100);
    translate([diametre_balance/2,0,diametre_balance/4])
    cube([diametre_balance,diametre_balance,diametre_balance], center=true);
}
}
translate([-3.5,0,-2])
 vis(7,3.5);
}

module vis(diam_tete, diam_tige){
	cylinder (r1=diam_tige/2, r2=diam_tige/2, h=20, $fn=100);
	cylinder (r1=diam_tete/2, r2=diam_tige/2, h=3, $fn=100);
}