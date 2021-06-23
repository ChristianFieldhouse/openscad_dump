use <MCAD/regular_shapes.scad>

$fn = 20;

w = 8;
h = 2;
l = 100;

axil_r = 2.5;

tol = 0.2;

small_tol = 0.1;
cap_t = 1;

module cap() {
    cylinder_tube(h, axil_r + small_tol + cap_t, cap_t, center=true);
}

num_sects = 6;
alpha = 360/num_sects;

male = true;
if (male) {
    translate([0, 0, h * 3/2]) cylinder(h * 2, axil_r, axil_r, center=true);
    translate([0, 0, 2*h]) cap();
    difference(){
        union(){
            translate([(l-w)/4, 0, 0]) cube([(l-w)/2, w, h], center=true);
            translate([(l-w)/2, 0, 0]) cylinder(h, w/2, w/2, center=true);
            cylinder(h, w/2, w/2, center=true);
            rotate(alpha){
                translate([-(l-w)/4, 0, 0]) cube([(l-w)/2, w, h], center=true);
                translate([-(l-w)/2, 0, 0]) cylinder(h, w/2, w/2, center=true);
            }
        }
        translate([l/2 - w/2, 0, 0]) cylinder(h * 2, axil_r + tol, axil_r + tol, center=true);
        rotate(alpha) translate([w/2 - l/2, 0, 0]) cylinder(h * 2, axil_r + tol, axil_r + tol, center=true);
    }
}

if (true) {
    translate([0, 0, h])
    difference(){
        union(){
            translate([0, (l-w)/4, 0]) cube([w, (l - w)/2, h], center=true);
            translate([0, (l-w)/2, 0]) cylinder(h, w/2, w/2, center=true);
            cylinder(h, w/2, w/2, center=true);
            rotate(-alpha){
                translate([0, -(l-w)/4, 0]) cube([w, (l - w)/2, h], center=true);
                translate([0, -(l-w)/2, 0]) cylinder(h, w/2, w/2, center=true);
            }
        }
        cylinder(h * 2, axil_r + tol, axil_r + tol, center=true);
    }
    translate([0, l/2 - w/2, -h * 1/2]) cylinder(h * 2, axil_r, axil_r, center=true);
    rotate(-alpha) translate([0, w/2 - l/2, -h * 1/2]) cylinder(h * 2, axil_r, axil_r, center=true);
}

//cap();