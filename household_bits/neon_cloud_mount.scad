use <MCAD/regular_shapes.scad>

t = 1;
r = 2;
flat_t = 2;
l = 50;
h = 7;

cylinder_tube(t, r+flat_t, flat_t);
translate([0, l/2 + r, t/2])
cube([flat_t, l, t], center=true);

translate([0, l, 0])
cylinder(h, r, r);