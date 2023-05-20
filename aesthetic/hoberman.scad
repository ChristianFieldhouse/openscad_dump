use <MCAD/regular_shapes.scad>

$fn = 20;

w = 8;
h = 2;
l = 50;

axil_r = 2.5;

tol = 0.2;

small_tol = 0.1;
cap_t = 1;

module cap() {
    cylinder_tube(h, axil_r + small_tol + cap_t, cap_t, center=true);
}

num_sects = 15;
alpha = 360/num_sects;

module male(){
    translate([0, 0, h * 3/2]) cylinder(h * 2, axil_r, axil_r, center=true);
    //translate([0, 0, 2*h]) cap();
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

module female () {
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

module printable(){
    repetition_pitch = 1.3;

    for (i = [0: num_sects-1]){
        translate([0, w * repetition_pitch * i, 0]) male();
        //translate([w * repetition_pitch * i, 0, 0]) female();
        //translate([0, w * 1.2 * i, 0]) cap();
    }
}

module assembly(){
    beta = 45 - alpha;
    delta = (90 - alpha)/2;
    gamma = delta - beta;
    a = sin(180 - delta)/sin(gamma);
    b = (l-w)/2 * a/sqrt(2);
    echo(alpha);
    echo(gamma);
    for (i = [0:num_sects-1]){
        rotate(2*i*gamma)
        translate([b, b, 0]){
            color("#fff") male();
            female();
        }
    }
    //cap();
}

printable();
//assembly();

//cap();