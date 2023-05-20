
h = 15;
w = 30.16;
d = 20.5;
t = 1.5;

o = 5;

difference(){
    union(){
        cube([w + 2*t, d + 2*t, h]);
        translate([o, -2*t, 0])
        cube([w - 2*(o - t), 2*t, h]);
        translate([o - t, -2*t, 0])
        cube([w - 2*(o - 2*t), t, h]);
    }
    translate([t, t, 0])
    cube([w, d, h]);
    translate([t + o, -2*t, 0])
    cube([w - 2*o, t*3, h]);
}
