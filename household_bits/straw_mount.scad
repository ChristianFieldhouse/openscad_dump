use <MCAD/regular_shapes.scad>

t = 1.5;
r = 20;
w = 25;

straw_l = 210;
grating_l = 175;
pin_z = (straw_l - grating_l) / 2;
pin = [20, 2, w + t - pin_z];
backplate_x = 15;

intersection(){
    difference(){
        cylinder(w + t, r + t, r + t);
        translate([0, 0, t])
        cylinder(w, r, r);
    }
    translate([-500, 0, 0])
    cube([1000, 1000, 1000], center=true);
}
translate([0, r + t/2, (w + t)/2])
cube([backplate_x, t, w + t], center=true);

for (x = [0, -10])
translate([backplate_x/2 + x, r + pin.y, pin_z])
rotate([0, 0, 160])
cube(pin);