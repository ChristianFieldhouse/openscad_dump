include <m3?_nut_clamp.scad>

h = 55;
t = 1;
wing = 5; //11.92/2;
nut_h = 3;

module shaft(){
    nut_clamp(h=nut_h);
    translate([0, 0, 3])
    thread_tube(height=1, t=2);
    translate([0, 0, 4])
    thread_tube(height=1, t=1.5);
    translate([0, 0, 5])
    thread_tube(height=h - 5, t=1);
}

module shaft_hull(){
    hull(){
        nut_clamp(h=nut_h);
    }
    hull(){
        thread_tube(height=h, t=1);
    }
}

module winged_shaft(){
    difference(){
        translate([0, 0, h/2])
        cube([t, wing*2, h], center=true);
        shaft_hull();
    }
    shaft();
}

box_z = 9;
box_y = 12;
module box_grip(box_x=10, box_y=box_y, box_z=box_z, t=2){
    translate([0, 0, box_z/2])
    difference(){
        cube([box_x + t, box_y + t, box_z], center=true);
        cube([box_x, box_y, box_z], center=true);
    }
}

overhang = 0.5;
module wing_hold(z=h, gap=0.1){
    box_grip(box_z=z);
    w = t + box_y/2 - wing + overhang;
    translate([0, 0, z/2])
    difference(){
        union(){
            translate([0, t + (box_y - w)/2, 0])
            cube([3*t, w, z], center=true);
            translate([0, -t - (box_y - w)/2, 0])
            cube([3*t, w, z], center=true);
        }
        cube([t + 2 * gap, (wing + gap) * 2, 100], center=true);
    }
}

//winged_shaft();

wing_hold(z=h);
translate([0, 0, -box_z/2])
box_grip();