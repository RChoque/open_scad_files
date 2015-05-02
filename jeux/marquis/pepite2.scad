diametre = 16;
diametre_voulu = 10;

module pepite(){
import("Snowman_bowling_ball.stl");
	
translate([0,0,10]) cylinder(h=3.715, r=3, $fn=40);
}

scale(diametre_voulu/diametre) 
pepite();
