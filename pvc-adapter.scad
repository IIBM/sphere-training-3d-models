// Ariel Burman
// Instituto de Ingeniería Biomédica
// Universidad de Buenos Aires

espesor=8;
diam=80;
height=90;
lenght=40;

screwd=4;
screwsep=26;
screwdes=20;
$fn=80;

sidewall=10;

difference() {
  cylinder(h=height,d=diam+espesor*2,center=true);
  cylinder(h=height+1,d=diam,center=true);
  translate([(diam+espesor+1)/2,0,0])cube([diam+espesor+1,diam+espesor*2+1,height+1],center=true);

  translate([-(diam+espesor)/2,0,screwsep/2+screwdes])rotate([0,90,0])cylinder(h=espesor+1,d=screwd,center=true);
  translate([-(diam-1)/2,0,screwsep/2+screwdes])rotate([0,90,0])cylinder(h=espesor+1,d=screwd*2.6,center=true);

  translate([-(diam+espesor)/2,0,-screwsep/2+screwdes])rotate([0,90,0])cylinder(h=espesor+1,d=screwd,center=true);
  translate([-(diam-1)/2,0,-screwsep/2+screwdes])rotate([0,90,0])cylinder(h=espesor+1,d=screwd*2.6,center=true);
}

translate([sidewall/2,(diam+espesor)/2,0])cube([sidewall,espesor,height],center=true);
translate([sidewall/2,-(diam+espesor)/2,0])cube([sidewall,espesor,height],center=true);


