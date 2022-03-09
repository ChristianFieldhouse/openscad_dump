include <MCAD/regular_shapes.scad>

$fn=40;

r = 6.32/2;
clce = 0.1;

h = 2*r;
t = 1;
balls = 6;
mid_r = r/sin(360/(2 * balls));

module outer_section(){
    overlap = r/3;
    difference(){
        translate([mid_r + r - (overlap - t)/2, 0, 0]) square([overlap + t, 2*r + 2*t], center=true);
        translate([mid_r, 0, 0]) circle(r + clce);
    }
}

module inner_section(){
    overlap = r/3;
    difference(){
        translate([mid_r - r + (overlap - t)/2, 0, 0]) square([overlap + t, 2*r + 2*t], center=true);
        translate([mid_r, 0, 0]) circle(r + clce);
    }
}

rotate_extrude(){
    outer_section();
}

rotate_extrude(){
    inner_section();
}

for (i = [0: balls - 1]){
    rotate(i * 360/balls) translate([mid_r, 0, 0]) sphere(r);
}