
r = 3;
d = 140;
h = 20;

t = 2;

grip_y = 10;
top_grip_y = 7;

metal_w = 20.3;
metal_h = 29.84;

wood_l = 14.66;
wood_h = 15.6;

for (z = [0, h]){
    translate([0, 0, z])
    rotate([90, 0, 0])
    cylinder(d, r, r);
}

for (y = [0, d]){
    translate([0, -y, 0]){
        sphere(r);
        cylinder(h, r, r);
        rotate([0, 90, 0])
        cylinder(h, r, r);
        translate([0, 0, h])
        sphere(r);
        translate([h, 0, 0])
        sphere(r);
    }
}

skew = 0.15;
d_f = skew - 0.5;

translate([-r, d_f * d -grip_y/2, h + r-t])
difference(){
    cube([grip_y, metal_w + 2*t, metal_h + t]);
    translate([0, t, t])
    cube([grip_y, metal_w, metal_h]);
}

translate([-r, d_f * d - grip_y/2 - wood_l, metal_h + h + r-t])
difference(){
    cube([grip_y, wood_l + t, wood_h + t]);
    translate([0, t, t])
    cube([grip_y, wood_l, wood_h]);
}

translate([-r, d_f * d - grip_y/2 - wood_l, wood_h + metal_h + h + r])
cube([grip_y, t + top_grip_y, t]);
