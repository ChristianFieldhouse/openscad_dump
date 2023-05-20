use <MCAD/regular_shapes.scad>

t = 3;
r = 7;
l = 180;

intersection(){
    cylinder_tube(t, 7, t);
    cube_r = 3*r;
    translate([0, -cube_r/2, 0])
    cube([cube_r, cube_r, cube_r], center=true);
}

translate([r - t, 0, 0])
cube([t, l, t]);