nb_screwdrivers = 6;
screwdriver_diam_min = 7.5;
screwdriver_diam_max = 12;
screwdriver_height = 70;

support_length = nb_screwdrivers*(screwdriver_diam_max+10);
support_width = screwdriver_diam_max;
support_height = 10;

difference([]){
    cube([support_length, support_width, support_height]);
    for (i=[0:nb_screwdrivers-1]){
        echo(i);
        translate([10+i*(screwdriver_diam_max+10),  screwdriver_diam_min/2,-2])
        cylinder(d1=screwdriver_diam_min, d2=screwdriver_diam_max, h=screwdriver_height, $fn=100);
    }
}