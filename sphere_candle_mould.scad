r = 20;
t = 2;

w = 2*(r + t);
gap = 0.5;
l = 3*t;

hole = 3;

module ideal_mould(){
    difference(){
        cube([w, w, w], center=true);
        sphere(r);
    }
}

module base(){
    intersection(){
        ideal_mould();
        translate([0, 0, -w/4])
        cube([w, w, w/2], center=true);
    }
    for (i = [-1, 1])
        for (j = [-1, 1])
            translate([i*(w/2-2*t), j*(w/2-2*t), 0])
            cylinder(3*t, t, t);
}

module top(){
    difference(){
        intersection(){
            ideal_mould();
            translate([0, 0, -w/4])
            cube([w, w, w/2], center=true);
        }
        for (i = [-1, 1])
            for (j = [-1, 1])
                translate([i*(w/2-2*t), j*(w/2-2*t), -l-gap])
                cylinder(l + gap, t+gap, t+gap);
        cylinder(1000, hole, hole, center=true);
    }
}

base();
translate([0, w*1.1, 0])
top();