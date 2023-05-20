use <MCAD/regular_shapes.scad>


g = 3.65;
t = 3;
d = 24.18 + 2*t;

r = d/2;

rotate([0, 90, 0]){ // for printing

difference(){
    cube([t, d, 2 * t + g], center=true);
    translate([0, 0, 0])
    cube([t, d - 2*t, g], center=true);
    translate([0, t, 0])
    cube([t, d - 2*t, g/4], center=true);
}


translate([0, 0, -r - g/2])
rotate([0, 90, 0])
difference(){
    cylinder_tube(t, r, t, center=true);
    translate([0, 0, -t/2])
    rotate([0, 0, 180])
    cube([r, r, t]);
}

} // for printing