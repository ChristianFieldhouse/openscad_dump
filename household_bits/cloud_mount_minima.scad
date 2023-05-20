use <MCAD/regular_shapes.scad>

r = 16.23/2;
t = 2;

grip_angle = 25;
l = 59 / cos(grip_angle);
w = 3;

cloud_h = 173;
top_angle = atan((sin(grip_angle)*59 + cloud_h) / 59);
top_l = 59/cos(top_angle);


module stick(l=l, grip_angle=grip_angle){
    intersection(){
        cylinder_tube(t, r+t, t);
        translate([0, 50 - r/3, 0])
        cube([100, 100, 100], center=true);
    }

    translate([0, l/2 + r, t/2])
    cube([w, l, t], center=true);

    grip = 10;

    translate([0, l + r - t, 0])
    rotate([0, 0, grip_angle])
    difference(){
        cube([grip+w/2, grip+w/2, t]);
        translate([w/2, w/2, 0])
        cube([grip, grip, t]);
    }
}

//stick();
translate([0, 0, 0])
rotate([0, 0, grip_angle - top_angle])
stick(l=top_l+10, grip_angle=top_angle);