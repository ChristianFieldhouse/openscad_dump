use <MCAD/regular_shapes.scad>


t = 1.5;
p_w = 74.2;
eps = 1;

b_w = 20.7;
b_h = 40.5;

bed_to_skirting = 150;
extension_w = 26;
bed_to_skirting_w = extension_w + 6*t;
extension_h = 54.6;

table_w = 100;
table_l = 150;

translate([0, - b_w - t, -table_w])
difference(){
    cube([b_h + t, table_l, table_w]);
    translate([t, t, 0])
    cube([b_h, table_l-t, table_w]);
}

translate([0, 0, -table_w])
cube([b_h, t, table_w]);

difference(){
    translate([0, 0, -bed_to_skirting_w])
    cube([bed_to_skirting, t, bed_to_skirting_w]);
    
    translate([bed_to_skirting - extension_h, 0, (extension_w-bed_to_skirting_w)/2 - extension_w])
    cube([extension_h, t, extension_w]);
}