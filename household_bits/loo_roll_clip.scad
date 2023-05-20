
t0 = 2.4;
t = 1;
g = 0.1;
o = 1;

l = 17;
h = 14;

difference(){

    cube([l + 2 * t0, 2*t0 + 2*g + t, h], center=false);
    translate([t0, t, 0])
    cube([l, t0 + 2*g, h], center=false);
    translate([t0 + o, 0, 0])
    cube([l - 2*o, t0, h], center=false);
}