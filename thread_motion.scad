use <thread.scad>

base_w = 10;
base_l = 20;
base_t = 2;

t = base_t;
r = 3;
pitch = 4;
width = 2;
base_gap = base_l - 2*base_t;
laps = (base_gap - width)/pitch;

start = 10;

if (false){
translate([-(base_l - 2*base_t)/2 + t*0.5, 0, r + 3 * t]){
    rotate(90, [0, 1, 0]){
        translate([0, 0, - start]) cylinder(start, 3, 3, $fn=20);
        translate([0, 0, -t/2 + laps*pitch]) cylinder(5, 3, 3, $fn=20);
        translate([0, 0, 0]){
            thread(
                pitch=pitch,
                width=width,
                r=r,
                t=t,
                laps=laps,
                steps_per_lap=20
            );
            difference(){
                translate([0, 0, -0.5]) cylinder(pitch*laps + width, 3, 3, $fn=20);
                translate([0, 0, -0.5]) cylinder(pitch*laps + width, 2, 2, $fn=20);
            }
        }
    }
}
}

module base(){
    translate([0, 0, base_t]) cube([base_l, base_w, base_t * 2], center=true);

    module gap(tol=0.2, res=20){
        difference(){
            h = 2*(r+t) + base_t + t;
            translate([0, 0, h/2 + base_t/2]) cube([base_t, base_w, h], center=true);
            translate([0, 0, h/2 + base_t]) rotate(90, [0, 1, 0]) cylinder(2*base_t, r + tol, r + tol, center=true, $fn=res);
        }
    }

    translate([base_l/2 - base_t/2, 0, 0]) gap();
    translate([- base_l/2 + base_t/2, 0, 0]) gap();
}

slot_w = base_w/2;

module real_base(){
    difference(){
        base();
        cutout = base_t*5 + 2* (r + tol);
        translate([0, 0, cutout/2 + base_t]) cube([base_l, slot_w, cutout], center=true);
    }
}

tol = 0.5;
module rod(){
    cube([base_l*2, slot_w - tol * 2, base_t - tol], center=true);
    for (i=[0:base_l * 2/pitch - 1]){
        translate([base_l - width/4 - i*pitch, 0, base_t - tol]) cube([width/2, slot_w - 2 * tol, base_t], center=true);
    }
}

//thread();
//real_base();
translate([0, 0, t*1.5]) rod();