use <MCAD/involute_gears.scad>

tol = 0.1;

target_rad = 6.2;
inner_diam = 5.37;
chord_dist = 3.66;

length = 20.73 + 4;
cog_t = 9;
pitch = 230;
cog_r =  13;
cog_teeth = round(cog_r * 360/pitch);

fix_depth = 7.65;

difference(){
    union(){
    bevel_gear (
        number_of_teeth=cog_teeth, 
        cone_distance=50, 
        face_width=cog_t, 
        outside_circular_pitch=pitch, 
        pressure_angle=30,
        clearance = 0.2, 
        bore_diameter=0,
        gear_thickness = 2, 
        backlash = 0, 
        involute_facets=0, 
        finish = -1);
    join_r = target_rad * 0.6;
    translate([0, 0, cog_t - length - tol]) cylinder(length, r1 = join_r, r2 = join_r, $fn=40);
    }
    translate([0, 0, cog_t - length - tol])
    intersection(){
        cylinder(fix_depth, r1 = inner_diam/2 + tol, r2 = inner_diam/2 + tol, $fn=40);
        translate([0, 0, fix_depth/2]) cube([chord_dist + tol, inner_diam + 2*tol, fix_depth], center=true);
    }
}