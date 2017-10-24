// Ariel Burman
// Instituto de Ingeniería Biomédica
// Universidad de Buenos Aires

module agujero(_espesor, _rext,_rint,_fn=10){
	difference(){
		cylinder(h=_espesor,r=_rext,$fn=_fn);
		translate([0,0,-0.1]) cylinder(h=_espesor+0.2,r=_rint,$fn=_fn);
	}
}

module poligono1(_a1, _a2,_b,_c){
 polyhedron(
  points    =[ [-_a2,0,_c], [-_a1,_b,_c],[_a1,_b,_c],[_a2,0,_c],
			      [-_a2,0,0], [-_a1,_b,0],  [_a1,_b,0], [_a2,0,0] ],
  triangles = [[0,1,2],[0,2,3],[4,6,5],[4,7,6],
              [2,6,3],[3,6,7],[2,1,5],[2,5,6],
              [1,0,5],[0,4,5],[0,3,4],[3,7,4] ]
 );
}

espesor=2;
ragujero=3.4/2.0;
rexterior=6.58/2.0;
fn1=20; //poner 100

largo_ext = 36.6; // separacion entre agujeros (modelo chico)
ancho_ext = 18.2; // separacion entre agujeros (modelo chico)
largo_int = 22;   // largo de la barra horizontal (modelo chico)
ancho_int = 6;
angulo_brazo = 45.0;
rinterior = 1.2;

module pieza() {

  union() {

    //agujeros
    translate([-largo_ext/2,-ancho_ext/2,0]) 
      agujero(espesor,rexterior,ragujero,fn1);
    translate([-largo_ext/2, ancho_ext/2,0]) 
      agujero(espesor,rexterior,ragujero,fn1);
    translate([ largo_ext/2,-ancho_ext/2,0]) 
      agujero(espesor,rexterior,ragujero,fn1);
    translate([ largo_ext/2, ancho_ext/2,0]) 
      agujero(espesor,rexterior,ragujero,fn1);
    //fin agujeros

    //centro
    difference() {
      // cuerpo central
      translate([0,0,espesor/2])
      cube([largo_int,ancho_int,espesor],center=true);

      // muecas superiores
      for(i=[-3:3]) {
        translate([i*4.3,3.5,-0.1]) cylinder(h=espesor+0.2,r=rinterior,$fn=fn1);
      }
      // muecas inferiores
      for(i=[-3:2]) {
        translate([i*4.3+2.1,-3.5,-0.1]) cylinder(h=espesor+0.2,r=rinterior,$fn=fn1);
      }
    }


    for(i=[0:1]) {
      for(j=[0:1]) {
        mirror([0,j,0]) {
         mirror([i,0,0]) {
          difference(){
            union() {
              //borde agujero
              translate([-largo_ext/2,-ancho_ext/2,0])
               cylinder(h=espesor,r=rexterior,$fn=fn1);
              //brazo
              hull(){
                translate([-largo_ext/2,-ancho_ext/2,0])
                 cylinder(h=espesor,r=ragujero,$fn=fn1);
                translate([-largo_int/2+ragujero,0/2,0])
                 cylinder(h=espesor,r=ragujero,$fn=fn1);
              }
            }
            //agujero externo
            translate([-largo_ext/2,-ancho_ext/2,-0.1])
             cylinder(h=espesor+0.2,r=ragujero,$fn=fn1);
	       }

         }
        }
      }
    }
  }
}

largo_sop = largo_ext+2*rexterior;
ancho_sop = ancho_ext+2*rexterior;

module pieza_con_soporte_t() {
  difference() {
    translate([-largo_sop/2,-ancho_sop/2,0.01])
    cube([largo_sop, ancho_sop, espesor-.02]);
    pieza();
  }
}


module pieza_con_soporte() {
  difference() {
    translate([-largo_sop/2,-ancho_sop/2,0.01])
    cube([largo_sop, ancho_sop, espesor-.02]);
    minkowski() {
      pieza();
      cylinder(h=espesor,r=3.2,$fn=20);
    }
  }
  pieza();
  translate([-largo_sop/2,-1/4,0.01])
  cube([largo_sop, 1/2, espesor-.02]);
  translate([-1/4,-ancho_sop/2,0.01])
  cube([1/2, ancho_sop, espesor-.02]);

}

pieza_con_soporte();
