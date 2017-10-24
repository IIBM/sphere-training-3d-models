// Ariel Burman
// Instituto de Ingeniería Biomédica
// Universidad de Buenos Aires


/************************************************************************************/
A1 = 20 ; // Ancho regulacion lateral
B1 = 20 ; // Separacion base
C1 = 10 ; // Separacion punta
D1 = 20; // Alto 
E1 = 5; // Ancho
F1 = 2 ; // radio interno ranura regulacion
G1 = 20 ; // Largo punta
H1 = 6 ; // Radio externo boca
I1 = 2 ; // Radio menor
J1 = 2.6 ; // Radio mayor
K1 = 10 ; // alto boca

d1 = D1 - .6 ;
e1 = E1 - .6 ;

a1 = A1 + B1 + C1 ;
b1 = a1 + G1 ;
c1 = d1 - H1 ;
fn1 = 50 ;
ex = 0.1 ;
r_boq=22;
l_boq=45;
z_boq=9;

module boquilla(){
 difference() {

  union(){
    cube([b1,e1,d1]);
    translate([b1,e1-K1/2,d1])rotate([90,0,0])cylinder(h=K1,r=H1,center=true,$fn=fn1);
  }
  polyhedron(
    points = [ [a1,-ex,0] , [a1,e1+ex,0] , [b1,-ex,c1] , [b1,e1+ex,c1], [b1+ex,-ex,-ex] , [b1+ex,e1+ex,-ex] ],
    faces = [ [0,2,4] , [1,5,3] , [0,1,2] ,[1,3,2],
                  [2,3,4] , [3,5,4] , [0,4,1],[1,4,5]]
  );


  translate([A1/2+B1,e1/2,d1/2])cube([A1,e1+2*ex,F1*2],center=true);
  translate([B1,e1/2,d1/2])rotate([90,0,0])cylinder(h=e1+2*ex,r=F1,center=true,$fn=fn1);
  translate([B1+A1,e1/2,d1/2])rotate([90,0,0])cylinder(h=e1+2*ex,r=F1,center=true,$fn=fn1);

  translate([b1,e1-K1/2,d1])rotate([90,0,0])cylinder(h=K1+ex,r1=J1,r2=I1,center=true,$fn=fn1);

 }


 // agregado para que la rata no pueda agarrar el pico
 echo("Largo base = ",a1);
 echo("Largo boquilla = ",b1);
 translate([b1,E1-K1/2,d1+z_boq])
   difference(){
     translate([0,e1,0])rotate([90,0,0])cylinder(h=l_boq,r1=r_boq,r2=r_boq-4,$fn=fn1);
     rotate([90,0,0])cylinder(h=l_boq,r=r_boq-8,$fn=fn1);
     translate([-r_boq-5,-l_boq,-z_boq])cube([2*r_boq+10,l_boq+10,r_boq*2+10]);
     translate([0,(e1-E1),-z_boq])rotate([90,0,0])cylinder(h=K1+ex,r1=J1,r2=I1,center=true,$fn=fn1);

   }
}


/************************************************************************************/

A2 = A1 ;
B2 = B1 ;
C2 = 3 ;  //espesor receptor
D2 = D1 ;
E2 = E1 ;
F2 = F1 ;
G2 = 50 ;
H2 = 8 ; //excedente bordes pared
I2 = 5 ;  //espesor pared
J2 = C1 ;

a2 = G2 + 2 * H2;
b2 = D2 + 2 * C2;
c2 = A2 + B2 + J2	;
d2 = E2 + 2*C2;
e2 = E2/2 + C2;

alpha = 18 ;

beta = 35 ;

module ranura_circ(){
  union(){
    intersection() {
      union(){
        polyhedron(
          points = [ [-I2,0,0] , [I2,0,0] , 
             [-I2,G2/2+H2,(G2/2+H2)*tan(alpha)] , [I2,G2/2+H2,(G2/2+H2)*tan(alpha)],
             [-I2,G2/2+H2,-(G2/2+H2)*tan(alpha)] , [I2,G2/2+H2,-(G2/2+H2)*tan(alpha)] 
             ],
          faces = [ [0,2,1] , [1,2,3] , [2,4,3] ,[3,4,5],
                   [0,5,4] , [0,1,5] , [1,3,5],[0,4,2] ]
        );
        rotate([0,0,180]) polyhedron(
          points = [ [-I2,0,0] , [I2,0,0] , 
             [-I2,G2/2+H2,(G2/2+H2)*tan(alpha)] , [I2,G2/2+H2,(G2/2+H2)*tan(alpha)],
             [-I2,G2/2+H2,-(G2/2+H2)*tan(alpha)] , [I2,G2/2+H2,-(G2/2+H2)*tan(alpha)] 
             ],
          faces = [ [0,2,1] , [1,2,3] , [2,4,3] ,[3,4,5],
                 [0,5,4] , [0,1,5] , [1,3,5],[0,4,2] ]
         );
      }
      difference(){
        rotate([0,90,0])cylinder(h=I2+ex,r=G2/2+F2,center=true,$fn=fn1);
        rotate([0,90,0])cylinder(h=I2+2*ex,r=G2/2-F2,center=true,$fn=fn1);
      }
    }

    rotate([alpha,0,0])translate([0,G2/2,0]) rotate([0,90,0])cylinder(h=I2+ex,r=F2,center=true,$fn=fn1);
    rotate([-alpha,0,0])translate([0,G2/2,0]) rotate([0,90,0])cylinder(h=I2+ex,r=F2,center=true,$fn=fn1);
    rotate([alpha,0,0])translate([0,-G2/2,0]) rotate([0,90,0])cylinder(h=I2+ex,r=F2,center=true,$fn=fn1);
    rotate([-alpha,0,0])translate([0,-G2/2,0]) rotate([0,90,0])cylinder(h=I2+ex,r=F2,center=true,$fn=fn1);
  }
}

module pared() {
 intersection(){
  union(){
    intersection(){
      rotate([0,90,0]) cylinder(h=I2,r=G2/2+H2,center=true,$fn=fn1);
      union(){
        polyhedron(
          points = [ [-I2,0,0] , [I2,0,0] , 
            [-I2,G2/2+H2+1,(G2/2+H2+1)*tan(beta)] , [I2,G2/2+H2+1,(G2/2+H2+1)*tan(beta)],
            [-I2,G2/2+H2+1,-(G2/2+H2+1)*tan(beta)] , [I2,G2/2+H2+1,-(G2/2+H2+1)*tan(beta)] 
            ],
          faces = [ [0,2,1] , [1,2,3] , [2,4,3] ,[3,4,5],
                   [0,5,4] , [0,1,5] , [1,3,5],[0,4,2] ]
        );
        rotate([0,0,180]) polyhedron(
          points = [ [-I2,0,0] , [I2,0,0] , 
           [-I2,G2/2+H2+1,(G2/2+H2+1)*tan(beta)] , [I2,G2/2+H2+1,(G2/2+H2+1)*tan(beta)],
           [-I2,G2/2+H2+1,-(G2/2+H2+1)*tan(beta)] , [I2,G2/2+H2+1,-(G2/2+H2+1)*tan(beta)] 
           ],
          faces = [ [0,2,1] , [1,2,3] , [2,4,3] ,[3,4,5],
                   [0,5,4] , [0,1,5] , [1,3,5],[0,4,2] ]
        );
      }
    }
    cube([I2,G2+2,b2],center=true);
  }
  cube([I2,2*G2,b2],center=true);
 }
}


module receptor() {
  union() {
    translate([-I2/2,0,b2/2])
    difference(){
      pared();
      ranura_circ();
    }
    translate([c2/2,0,b2/2]) 
    difference() {
      cube([c2,d2,b2],center=true);
      cube([c2+0.2,E2,D2],center=true);
      translate([-c2/2+A2+B2,0,0])rotate([90,0,0])cylinder(h=d2+ex,r=F2,center=true,$fn=fn1); 
    }

  //rotate([0,0,180]) 
    translate([0,e2,0])polyhedron(
      points = [ [0,0,0] , [A2/2,0,0] , [0,A2/2,0] ,[0,0,b2] , [A2/2,0,b2] , [0,A2/2,b2] ],
      faces = [ [0,1,2] , [3,5,4] , [0,3,1] ,[1,3,4],
               [1,4,2] , [4,5,2] , [5,3,0],[0,2,5] ]
    );
    translate([0,-e2,0])rotate([0,0,-90]) polyhedron(
      points = [ [0,0,0] , [A2/2,0,0] , [0,A2/2,0] ,[0,0,b2] , [A2/2,0,b2] , [0,A2/2,b2] ],
      faces = [ [0,1,2] , [3,5,4] , [0,3,1] ,[1,3,4],
               [1,4,2] , [4,5,2] , [5,3,0],[0,2,5] ]
    );
  }
}

/************************************************************************************/

A3 = 140; // largo de la pieza
B3 = 20 ; // alto en la punta
D3 = 60 ; // alto base
E3 = 7; // espesor
F3 = F1  ; // diametro agujeros
G3 = 20 ; // largo base
H3 = 70 ; // largo ranura vertical
I3 = 20 ; // ancho regulacion horizontal
J3 = G2 ; // separacion regulacion horizontal
K3 = H2 ; // separacion borde base

C3 = 22.7 /2  ; // radio externo camara
L3 = 16 / 2  ;  // radio interno camara
M3 = 3 ; // espesor pared camara 
N3 = 5 ; // excedente camara
O3 = 5 ; // borde inf camara
P3 = 0 ; // Desplazamiento lateral camara

a3 = J3 + I3 + 2 * K3 ;
b3 = A3 - a3/2 ;
c3 = C3 + M3 ;


p4x1 = K3;
p4y1 = D3 - K3;
p4x2 = p4x1 + 4;
p4y2 = p4y1 - 34;


module soporte() {
echo("centro = " , A3 - a3 /2);
difference(){
  union(){
    polyhedron(
	  points = [ [0,0,0] , [A3,0,0] , [A3,0,B3] , [b3,0,B3] , [G3,0,D3] , [0,0,D3] ,
	    [0,E3,0] , [A3,E3,0] , [A3,E3,B3] , [b3,E3,B3] , [G3,E3,D3] , [0,E3,D3] 
	    ],
	  faces = [ [0,2,1] , [0,3,2] , [0,4,3] ,[0,5,4],
	    [6,7,8] , [6,8,9] , [6,9,10] ,[6,10,11],
	    [0,11,5] , [0,6,11] , [5,11,4] ,[11,10,4] , [4,9,3] , [4,10,9] ,
	    [3,8,2], [3,9,8] , [2,7,1] , [2,8,7] , [0,1,7] , [0,7,6]
	    ]
    );

  //translate([A3-a3-c3-P3,E3/2+N3,c3+O3])
   translate([A3-a3-c3-P3,0,c3+O3]) 
   translate([0,E3+0.6,0])
   rotate([0,0,15])
   translate([0,-E3/2,0])
   translate([0,N3,0])
   rotate([90,0,0]) cylinder(h=E3+N3,r=c3,center=true,$fn=fn1);
  }

  hull() {
  translate([p4x1,E3/2,p4y1-3*F3]) rotate([90,0,0]) cylinder(h=E3+0.2,r=F3+0.4,center=true,$fn=fn1);
  translate([p4x1,E3/2,p4y1]) rotate([90,0,0]) cylinder(h=E3+0.2,r=F3+0.4,center=true,$fn=fn1);
  }
  hull() {
    translate([p4x2,E3/2,p4y2]) rotate([90,0,0]) cylinder(h=E3+0.2,r=F3+0.4,center=true,$fn=fn1);
    translate([p4x2,E3/2,p4y2-3*F3]) rotate([90,0,0]) cylinder(h=E3+0.2,r=F3+0.4,center=true,$fn=fn1);
  }

  translate([A3-K3,E3/2,B3/2])rotate([90,0,0] )cylinder(h=E3+0.2,r=F3,center=true,$fn=fn1);
  translate([A3-K3-I3,E3/2,B3/2])rotate([90,0,0] )cylinder(h=E3+0.2,r=F3,center=true,$fn=fn1);
  translate([A3-K3-I3/2,E3/2,B3/2])cube([I3,E3+0.2,F3*2], center = true);
  translate([A3-K3-J3,E3/2,B3/2])rotate([90,0,0] )cylinder(h=E3+0.2,r=F3,center=true,$fn=fn1);
  translate([A3-K3-J3-I3,E3/2,B3/2])rotate([90,0,0] )cylinder(h=E3+0.2,r=F3,center=true,$fn=fn1);
  translate([A3-K3-J3-I3/2,E3/2,B3/2])cube([I3,E3+0.2,F3*2], center = true);

translate([A3-a3-c3-P3,0,c3+O3])
translate([0,E3+0.6,0])
rotate([0,0,15])
translate([0,-E3/2,0])
union(){
  translate([0,10,0]) rotate([90,0,0]) cylinder(h=E3+N3,r=C3,center=true,$fn=fn1);
  translate([0,0,0]) rotate([90,0,0]) cylinder(h=E3+20,r=L3,center=true,$fn=fn1);
}
  translate([0,-100,0]) cube([100,100,100]);

}


}
/************************************************************************************/

A4 = H3 ; // largo ranura vertical
B4 = K3 ; // separacion ranura vertical
C4 = 4 ; // espesor pieza
D4 = 10 ;
F4 = F1 ; // radio agujeros

a4 = 38 + B4; // altura
b4 = 35; // ancho
c4 = C4 ; // espesor

/*
p4x1 = B4;
p4y1 = a4 - B4;
p4x2 = p4x1 + 4;
p4y2 = p4y1 - 34;
*/
p4y3 = a4/3 ;
p4y4 = a4 * 2/3  ;
p4x3 = b4 - B4;

n4 = 8;


module adaptador() {

  difference() {
  

    translate([n4,0,n4])
    minkowski() {
      cube([b4-2*n4,c4,a4-2*n4]);
      rotate([90,0,0])cylinder(r=n4,h=.0001,$fn=fn1);
    }

    translate([p4x1,c4/2,p4y1]) rotate([90,0,0]) cylinder(h=c4+0.2,r=F4+0.4,center=true,$fn=fn1);
    translate([p4x2,c4/2,p4y2]) rotate([90,0,0]) cylinder(h=c4+0.2,r=F4+0.4,center=true,$fn=fn1);
  
    translate([p4x3,c4/2,p4y3]) rotate([90,0,0]) cylinder(h=c4+0.2,r=F4,center=true,$fn=fn1);
    translate([p4x3,c4/2,p4y4]) rotate([90,0,0]) cylinder(h=c4+0.2,r=F4,center=true,$fn=fn1);

  }
}

/************************************************************************************/
// Show all

soporte();

translate([100,-5,-3])rotate([0,0,-90])
receptor();

translate([97.8,-20,0.2])
rotate([0,0,-90])
boquilla();

// Print all
/*
translate([5,5,E1]) rotate([-90,0,0]) 
boquilla();

translate([2*b2,60,I2]) rotate([0,-90,90])
receptor();

translate([0,0,0]) rotate([90,0,0])
soporte();

translate([100,5,C4]) rotate([-90,0,0]) 
adaptador();
*/
