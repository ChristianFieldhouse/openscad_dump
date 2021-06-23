
diaphragm_x = 50;
diaphragm_y = 60;
diaphragm_z = 0.6;

scaffold_xy = 1;
scaffold_z = 2;

twanger_y = 5;
twanger_x = 2;

twanger_gap = 8;

notes = [
    pow(2, -0/12),
    pow(2, -5/12),
    pow(2, -7/12),
];

twangers = [ for(i = [0:3-1]) 
    [(twanger_x + twanger_gap) * (i - 1), (twanger_y + twanger_gap) * (i - 1 ), 70 * notes[i]]
];


render_eps = 0.01;

cube([diaphragm_x, diaphragm_y, diaphragm_z], center=true);
translate([0, 0, scaffold_z/2]){
difference(){
    cube([diaphragm_x, diaphragm_y, scaffold_z], center=true);
    cube([diaphragm_x - 2 * scaffold_xy, diaphragm_y - 2 * scaffold_xy, scaffold_z + render_eps], center=true);
}
}

for (twanger = twangers){
    translate([0, 0, scaffold_z/2]){
        translate([twanger[0], 0, 0])
        cube([scaffold_xy, diaphragm_y, scaffold_z], center=true);
        translate([0, twanger[1], 0])
        cube([diaphragm_x, scaffold_xy, scaffold_z], center=true);
    }

    translate([twanger[0], twanger[1], twanger[2]/2]){
        cube([twanger_xy, scaffold_xy, twanger[1]], center=true);
        cube([twanger_x, twanger_y, twanger[2]], center=true);
    }
}
