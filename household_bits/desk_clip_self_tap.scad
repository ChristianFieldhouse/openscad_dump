
h = 10;
w = 25.5; //20.5;
d = 25.5; //30.5;
t = 1.5;

o = (w - 5)/2;
ot = 2*t;
op = 2*t;
r_outer = 1;
r_inner = 0.75;

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

hook_r = 2.5;
hook_l = 20;
hook_h = 20; //10;

translate([w/2 + t, d + 2*t, hook_r])
rotate([-90, 0, 0])
cylinder(hook_l, hook_r, hook_r);

translate([w/2 + t, d + 2*t + hook_l, 0])
cylinder(hook_h, hook_r, hook_r);

