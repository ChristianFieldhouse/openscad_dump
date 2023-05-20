use <MCAD/regular_shapes.scad>

r = 32.6/2;
h = 20;
t = 1.5;

p_h = 45;
p_w = 70.5;
p_d = 8;
eps = 1;
o = 5;

cylinder_tube(h, r + t, t);

translate([r - p_w, r, 0])
difference(){
    cube([p_w + eps + 2*t, p_d + eps + 2*t, p_h + t]);
    translate([t, t, 0])
    cube([p_w + eps, p_d + eps, p_h]);
    translate([t + eps/2 + o, p_d+t, 0])
    cube([p_w - 2*o, 2*t, p_h]);
    translate([t + p_w/3, t, 0])
    cube([p_w/3, p_d + eps, p_h * 2]);
}