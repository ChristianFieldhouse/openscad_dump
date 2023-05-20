use <MCAD/regular_shapes.scad>

r = 32.6/2;
h = 20;
t = 1.5;

p_h = 45;
p_w = 74.2;
p_d = 9.9;
eps = 1;
o = 5;

rotate([0, 90, 0]){
    translate([-p_w/2, 0, 0])
    difference(){
        cube([p_w + eps + 2*t, p_d + eps + 2*t, p_h + t]);
        translate([0, t, 0])
        cube([p_w + eps + t, p_d + eps, p_h]);
        translate([0, p_d+t, 0])
        cube([p_w - o, 2*t, p_h]);
        translate([t + p_w/3, t, 0])
        cube([p_w/3, p_d + eps, p_h * 2]);
    }
}

b_w = 20.7;
b_h = 20;

hh = p_w + 2*t + eps;

translate([0, - b_w - t, -p_w/2 - 2*t - eps])
difference(){
    cube([b_h + t, b_w + t, hh]);
    translate([t, t, 0])
    cube([b_h, b_w, hh]);
}