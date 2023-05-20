
inner_r = 8/2;
outer_r = 22/2;
bearing_t = 7;

center_h = 2 * (outer_r + bearing_t);

eps = 0.1;

for (rot = [[0, 0, 0], [90, 0, 0], [0, 90, 0]]){
    rotate(rot)
    translate([0, 0, -center_h/2])
    cylinder(center_h, inner_r-eps, inner_r-eps);
}

cube([2*outer_r, 2*outer_r, 2*outer_r], center=true);
