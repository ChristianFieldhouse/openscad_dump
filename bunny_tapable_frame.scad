use <MCAD/regular_shapes.scad>

r = 10;

x = 124.8;
y = 178.5;
z = 3.8;

rim = 0.1;
trim = r*1.4;

intersection(){
difference(){
    difference(){
        translate([-r-rim, -r-rim, 0])
        cube([x + 2*(r + rim), y + 2*(r + rim), z]);
        cube([x, y, z]);
    }

    scale([1, 1, 1.05*z/r]){
        for (pos = [[[0, 0, 0], 180], [[x, 0, 0], -90], [[0, y, 0], 90], [[x, y, 0], 0]]){
            translate(pos[0])
            intersection(){
                torus2(r + rim, r);
                rotate([0, 0, pos[1]])
                translate([0, 0, -1.5*r])
                cube(3 * r);
            }
        }

        for (yo = [-r-rim, y + r + rim]){
            translate([0, yo, 0])
            rotate([0, 90, 0])
            cylinder(x, r, r);
        }

        for (xo = [-rim-r, x + rim + r]){
            translate([xo, 0, 0])
            rotate([-90, 0, 0])
            cylinder(y, r, r);
        }
    }
}
translate([-trim/2, -trim/2, 0])
cube([x + trim, y + trim, z]);
}