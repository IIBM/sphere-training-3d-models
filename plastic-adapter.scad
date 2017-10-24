// Ariel Burman
// Instituto de Ingeniería Biomédica
// Universidad de Buenos Aires

translate([-24,0,0])
  difference(){
    cube([11,30,10]);
    translate([5.5,21.7,-0.5])cylinder(h=11,r=2,$fn=50);
    translate([5.5,4,-0.5])cylinder(h=11,r=2,$fn=50);
  }

translate([-11+24,0,0])
  difference(){
    cube([11,30,10]);
    translate([5.5,21.7,-0.5])cylinder(h=11,r=2,$fn=50);
    translate([5.5,4,-0.5])cylinder(h=11,r=2,$fn=50);
  }
  
x0 = 13;
d1 = 5;
y0 = (x0*x0-d1*d1)/(2*d1);
R1 = y0 + d1;

difference(){
  translate([-24,-13,0])cube([48,15,10]);
  translate([0,y0+2,-0.5]) cylinder(h=11,r=R1,$fn=150);
  translate([-11,0,-0.5]) difference(){
    rotate([0,0,180])cube([13.1,13.1,11]);
    cylinder(h=11,r=13,$fn=100);
  }
  translate([11,0,-0.5]) difference(){
    rotate([0,0,-90])cube([13.1,13.1,11]);
    translate([0,0,0])cylinder(h=11,r=13,$fn=100);
  }
}

translate([-6,-55-13,0])
  difference(){
    cube([12,55,10]);
    hull(){
      translate([6,5,-0.5])cylinder(h=11,r=2,$fn=20);
      translate([6,23,-0.5])cylinder(h=11,r=2,$fn=20);
    }
    hull(){
      translate([6,32.5,-0.5])cylinder(h=11,r=2,$fn=20);
      translate([6,50.6,-0.5])cylinder(h=11,r=2,$fn=20);
    }
  }
