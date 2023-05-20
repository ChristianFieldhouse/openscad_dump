use <MCAD/regular_shapes.scad>

r = 16.23/2;
t = 15;

grip_angle = 25;
l = 59 / cos(grip_angle);
w = 3;

base_to_hole = 122;

cloud_h = 10;
top_angle = atan((sin(grip_angle)*59 + cloud_h) / 59);
top_l = 59/cos(top_angle);

screw_d = 3.6;

module stick(l=l, grip_angle=grip_angle){
    intersection(){
        cylinder_tube(t, r+w, w);
        translate([0, 50 - r/3, 0])
        cube([100, 100, 100], center=true);
    }

    translate([0, l/2 + r, t/2])
    cube([w, l, t], center=true);

    grip = 10;

    translate([0, l + r - w, 0])
    rotate([0, 0, grip_angle]){
        cube([base_to_hole + t/2, w, t]);
        translate([base_to_hole - t/2, -t, 0])
        difference(){
            cube([t, t, t]);
            translate([t/2, 0, t/2])
            rotate([-90, 0, 0])
            cylinder(2*t, screw_d/2, screw_d/2, $fn=20);
        }
        translate([0, -t, 0])
        cube([t, t, t]);
    }
}

//stick();
//translate([0, 0, 0])
//rotate([0, 0, grip_angle - top_angle])
stick(l=top_l+10, grip_angle=top_angle);