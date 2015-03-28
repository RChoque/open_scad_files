epaisseur_minkowski = 2;
epaisseur = 2;
detail = 20;
//Size of Heart shape  - long edge
Size=25;
//Height of Heart
Height= 5;
//Cut width
Cut = 2*epaisseur_minkowski+1;
//Hole size
Hole=2;

longueur_cle = 3*Size;
diametre_tige = Height+2*epaisseur_minkowski;


module heart(size,height,hole) {
  linear_extrude(height = height) {
     square(size);
     translate([size/2,size,0]) circle(size/2,$fn=50);

     translate([size,size/2,0]) circle(size/2,$fn=50);
  }
}

module path_open(height,width,path) {
    for (t = [0: len(path)-2 ])
          hull() {
            translate(path[t]) cylinder(h=height, r=width/2,center=true,$fn=4);
            translate(path[t + 1]) cylinder(h=height, r=width/2,center=true,$fn=4);
          }
};

function path(n,step,c,t=0) =
     t < n
       ? concat( [[t * step, f(t,c),0]],
                 path(n,step, c, t+1)
          )
       : []
;

function coefficients(n,a) =
      n == 0
         ? []
         : concat(rands(-a/2,a/2,1)[0],coefficients(n-1,a));

function f(t,c) =
   sin(t/2)*( c[0]* sin(t) + c[1] * sin(2*t)+ c[2]*sin(3*t) +c[3] * sin(4*t)+ 
              c[4]* sin(5*t) + c[5]* sin(7*t) + c[6]*sin(8*t)) ;

module rounded_hollow_split_heart(){
  minkowski (){
    hollow_split_heart();
    sphere (epaisseur_minkowski, $fn=detail);
  }
}

module hollow_split_heart(){
  N= 181;
  Step = Size * sqrt(2)/N;
  c=coefficients(7,Size/6);
 echo(Step);
  cut_path = path(N,Step,c);
echo(cut_path);

  difference(){
    difference(){
      heart(Size,Height,Hole);
      translate ([0,0,Height/2])
         rotate([0,0,45]) path_open(Height,Cut,cut_path);
    }
    
    translate([epaisseur/2,epaisseur/2,0]) 
    difference(){
      heart(Size-epaisseur,Height+epaisseur,Hole);
      translate ([-epaisseur/2,-epaisseur/2,Height/2])
         rotate([0,0,45]) path_open(Height+epaisseur,Cut+epaisseur,cut_path);
    }
  }
}

module tige(){
  difference(){
    rotate([0,-90,0]) cylinder(h=longueur_cle, r=diametre_tige/2, $fn=detail);
    translate([0.1-diametre_tige,diametre_tige/2,0])
    linear_extrude(height=diametre_tige, center=true, convexity = 0, twist = 0) 
        polygon(points=[
          [0,0],
          [diametre_tige,0],
          [diametre_tige,-diametre_tige],
          ], paths=[[0,1,2]]);
  }
  translate([-3*Size,0,0])
  sphere (diametre_tige/2, $fn=detail);
}

module alex(){
	rotate([180,0,0])
	linear_extrude(height = Height)
	scale([0.1, 0.4])
	import("alex.dxf");
}

module cinde(){
	linear_extrude(height = Height)
	scale([0.1, 0.4])
	import("cinde.dxf");
}

position_tige_y = Height+2*epaisseur_minkowski;
position_x = position_tige_y/2*tan(45);
translate ([-position_x,0,-Height/2])
rotate([0,0,-45]) 
rounded_hollow_split_heart();
translate ([(Height+2*epaisseur_minkowski),-position_tige_y,0])
color("red")
tige();
translate ([(Height+2*epaisseur_minkowski),position_tige_y,0])
rotate([180,0,0])
color("blue")
tige();

translate ([diametre_tige/2+position_x-longueur_cle,-3*(Height+2*epaisseur_minkowski)/2+1,Height/2])
alex();
translate ([diametre_tige/2+position_x-longueur_cle,3*(Height+2*epaisseur_minkowski)/2-1,-Height/2])
cinde();


