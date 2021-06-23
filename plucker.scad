
line_length = 60;
line_join = 10;
line_z = 2;

diaphragm_x = 30;
diaphragm_y = 30;
diaphragm_z = 0.6;

scaffold_xy = 3; // width of outer scaffold
scaffold_z = 3; // height of outer scaffold

render_eps = 0.01;

// diaphragm
translate([0, 0, diaphragm_z/2])
cube([diaphragm_x, diaphragm_y, diaphragm_z], center=true);

translate([0, line_length/2, scaffold_z/2]){
difference(){
    cube([diaphragm_x + 2 * scaffold_xy, diaphragm_y + line_length + 2 * scaffold_xy, scaffold_z], center=true);
    cube([diaphragm_x, diaphragm_y + line_length, scaffold_z + render_eps], center=true);
}
}

translate([0, diaphragm_y/2 - line_join, 0])
cube([1, line_length + line_join, scaffold_z]);
