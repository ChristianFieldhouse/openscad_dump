
t = 3;
tabletop = [1, 220, 40];
grip = [50, 10, tabletop.z + 2*t];
r = 2.5;
triangle = [200, tabletop.y];

module base(){
    translate([-grip.x, -grip.y, 0])
    difference(){
        cube(grip);
        translate([0, 0, t])
        cube(grip - [t, 0, 2*t]);
    }
    
    translate([0, -r, r])
    rotate([0, 90, 0])
    cylinder(triangle[0], r, r);

    translate([r - t, 0, r])
    rotate([90, 0, 0])
    cylinder(triangle[1], r, r);
}

base();