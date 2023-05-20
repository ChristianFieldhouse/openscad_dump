
h = 10;
w = 25.4;
d = 95.6;
t = 1.5;

o = (w - 10)/2;
ot = 3*t;
op = 2*t;
r_outer = 3/2;
r_inner = 2.7/2;

r = r_outer;

difference(){
    union(){
        cube([w + 2*t, d + 2*t, h]);
        translate([o + 2*(t-ot), -2*(op + r), 0])
        cube([w - 2*(o - ot), 2*(op+r), h]);
        //translate([o - t, -2*t, 0])
        //cube([w - 2*(o - 2*t), t, h]);
    }
    translate([t, t, 0])
    cube([w, d, h]);
    translate([t + o, -2*(op+r), 0])
    cube([w - 2*o, 3*(op+r), h]);
    
    translate([w/2, -r-op, h/2])
    rotate([0, 90, 0])
    cylinder(1000, r, r, $fn=10);

    translate([w/2, -r-op, h/2])
    rotate([0, -90, 0])
    cylinder(1000, r_inner, r_inner, $fn=10);
}


