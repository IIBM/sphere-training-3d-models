// Ariel Burman
// Instituto de Ingeniería Biomédica
// Universidad de Buenos Aires

espesor=2.5;
ragujero=3.5/2.0;
rexterior=6.0/2.0;
fn1=100; //poner 100
module agujero(_espesor, _rext,_rint,_fn=10){
	difference(){
		cylinder(h=_espesor,r=_rext,$fn=_fn);
		translate([0,0,-0.1]) cylinder(h=_espesor+0.2,r=_rint,$fn=_fn);
	}
}
translate([-18.29,-9.08,0]) agujero(espesor,rexterior,ragujero,fn1);
translate([-18.30, 9.08,0]) agujero(espesor,rexterior,ragujero,fn1);
translate([ 18.29,-9.08,0]) agujero(espesor,rexterior,ragujero,fn1);
translate([ 18.30, 9.08,0]) agujero(espesor,rexterior,ragujero,fn1);

translate([-6,-6,0]) difference(){
	cube([12,12,espesor]);
	translate([2,2,-0.1])cube([8,8,espesor+0.2]);
}
largo = 12.0;
ancho = 2;
translate([6+4,6.6]) 
rotate([0,0,15]) 
translate([-largo/2.0,-ancho/2.0,0])cube([largo,ancho,espesor]);

translate([-(6+4),6.6]) 
rotate([0,0,-15]) 
translate([-largo/2.0,-ancho/2.0,0])cube([largo,ancho,espesor]);

translate([-(6+4),-(6.6)]) 
rotate([0,0,15]) 
translate([-largo/2.0,-ancho/2.0,0])cube([largo,ancho,espesor]);

translate([(6+4),-(6.6)]) 
rotate([0,0,-15]) 
translate([-largo/2.0,-ancho/2.0,0])cube([largo,ancho,espesor]);

