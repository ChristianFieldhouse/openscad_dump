use <MCAD/regular_shapes.scad>

cr_from_wall = 95.88;
cr_rad = 28.2/2;
t = 1.5;
w = 4;

box = [56, 5, 56.55];
overhang_x = 100 - box.x;
skirt_t = 12.6;
cr_mount_rad = 44.44/2;

rotate([90, 0, 0])
{ // rotate for printing

translate([0, cr_from_wall, 0])
rotate([0, 90, 0])
difference(){
    cylinder_tube(w, cr_rad + w, w, center=true);
    R1 = cr_rad * 10;
    translate([0, R1/2 + cr_mount_rad * 0.3, 0])
    cube([R1, R1, R1], center=true);
}


cr_arm_l = cr_from_wall - cr_rad;
translate([0, cr_arm_l/2, 0])
cube([w, cr_arm_l, w], center=true);

translate([t/2, 0, -w/2])
cube([box.x, t, w]);

cr_mount_w = 3*w;
sk_arm_l = skirt_t + cr_mount_w/2;
translate([box.x + t, sk_arm_l/2, 0])
cube([w, sk_arm_l, w], center=true);

R = cr_mount_rad * 10;
translate([box.x + w -t/2 + cr_mount_rad, sk_arm_l, 0])
rotate([90, 0, 0])
difference(){
    cylinder_tube(cr_mount_w, cr_mount_rad + w, w, center=true);
    translate([R/2 + cr_mount_rad * 0.3, 0])
    cube([R, R, R], center=true);
}

translate([(box.x + t - overhang_x)/2, (box.y + t)/2, -(box.z + w - t) / 2])
difference(){
    cube([box.x + 2*t + overhang_x, box.y + t, box.z + t + w], center=true);
    translate([0, t/2, (t - w)/2])
    cube([box.x * 2 + overhang_x, box.y, box.z], center=true);
    translate([0, t/2, (t - w)/2])
    cube([box.x + overhang_x, box.y*2, box.z], center=true);
}

for (d = [45, 24, 0, -24]){
    translate([d, t/2, -box.z/2 - (w + t)/2])
    cube([w, t, box.z + t], center=true);
}

} // rotate for printing
