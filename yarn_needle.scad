use <MCAD/regular_shapes.scad>


r = 2;
l = 40;
w = 8;

a = 0.3;

$fn=20;


hull(){
    translate([l, 0, 0])
    sphere(r);
    translate([0, w*a, 0])
    sphere(r);
    translate([0, -w*a, 0])
    sphere(r);
}


translate([-w/2, 0, 0])
torus2(w/2, r);