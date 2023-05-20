use <MCAD/regular_shapes.scad>

r = 20/2;
t = 3;
h = 7;

rs = 2;

o1 = t/2 + rs;

theta = 180/4;

difference(){
    cylinder_tube(h, r + t, t, $fn=40);
    linear_extrude(height=h){
        polygon([
            [0, 0],
            [2*r * sin(theta), 2*r * cos(theta)],
            [2*r * sin(theta), -2*r * cos(theta)]
        ]);
    }
}

eps = 0.1;

translate([(r + t + rs) * sin(theta), -(r + t + rs) * cos(theta), 0]){
    rotate([0, 0, 180 + 90 + theta]){
        intersection(){
            cylinder_tube(h, rs + t, t, $fn=40);
            translate([0, (rs + t)/2, h/2])
            cube([2 * rs + 2 * t, rs + t + eps, h], center=true);
        }
        translate([rs + t/2, 0, 0])
        cylinder(h, t/2, t/2, $fn=20);
    }
}

translate([(r + t + rs) * sin(theta), (r + t + rs) * cos(theta), 0]){
    rotate([0, 0, 180 + 90 - theta]){
        intersection(){
            cylinder_tube(h, rs + t, t, $fn=40);
            translate([0, (rs + t)/2, h/2])
            cube([2 * rs + 2 * t, rs + t + eps, h], center=true);
        }
        translate([-rs - t/2, 0, 0])
        cylinder(h, t/2, t/2, $fn=20);
    }
}