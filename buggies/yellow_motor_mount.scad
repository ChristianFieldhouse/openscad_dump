use <MCAD/involute_gears.scad>;
include <bearing_housing.scad>;

tol = 0.1;

target_rad = 6.2;
inner_diam = 5.37;
chord_dist = 3.66;

length = 10;//20.73 + 4;
cog_t = 9;
pitch = 230;
cog_r =  6;
cog_teeth = round(cog_r * 360/pitch);

fix_depth = 7.65;

motor_w = 18.84;
motor_l = 37.04;
motor_flat_l = 32.16;

module small_gear(){
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
        //translate([0, 0, cog_t - length - tol]) cylinder(length, r1 = join_r, r2 = join_r, $fn=40);
        }
        //translate([0, 0, cog_t - length - tol])
        hole_depth = fix_depth + 2;
        intersection(){
            cylinder(hole_depth, r1 = inner_diam/2 + tol, r2 = inner_diam/2 + tol, $fn=40);
            translate([0, 0, fix_depth/2]) cube([chord_dist + tol, inner_diam + 2*tol, hole_depth], center=true);
        }
    }
}

big_cog_r =  out_r + 5 + 4;
big_cog_teeth = round(big_cog_r * 360/pitch);

module big_cog(){
    echo(bit_cog_r);
    echo(big_cog_teeth);

    difference(){
        bevel_gear (
            number_of_teeth=big_cog_teeth, 
            cone_distance=80, 
            face_width=cog_t, 
            outside_circular_pitch=pitch, 
            pressure_angle=30,
            clearance = 0.2, 
            bore_diameter=0,
            gear_thickness = 2, 
            backlash = 0, 
            involute_facets=0, 
            finish = -1);
        cylinder(fix_depth + 5, r1 = out_r, r2 = out_r, $fn=40);
    }
}

motor_rad = motor_l - motor_flat_l;

module body_mount(t = 1, h=4){
    translate([0, motor_l*0.3, -in_r - h/2]){
        rotate([0, 90, 0])
        axil(motor_w + 2*10);
        cube([motor_w + 2, in_r*2, in_r*2], center=true);
        translate([0, in_r*2, in_r/2]){
            difference(){
                cube([motor_w/2, in_r*2, in_r], center=true);
                translate([0, 0, -1.2]){
                    rotate([0, 90, 0])
                    cylinder(motor_w + 2*t, 1.5, 1.5, center=true);
                }
            }
        }
    }
    translate([0, -motor_l*0.4, -2 - h/2 + t]){
        difference(){
            cube([motor_w + 2, in_r*2, 2], center=true);
            translate([0, 0, -0.5]){
                rotate([0, 90, 0])
                cylinder(motor_w + 2*t, 1.5, 1.5, center=true);
            }
        }
    }
    difference(){
        cube([motor_w + 2 * t, motor_l + 2 * t, h], center=true);
        translate([0, (motor_rad)/2, t/2])
        cube([motor_w, motor_flat_l, h - t], center=true);
        translate([0, -motor_l/2 + (motor_l - motor_flat_l), motor_rad - h/2 + t])
        rotate([0, 90, 0])
        cylinder(motor_w, motor_rad, motor_rad, center=true);
        rad = motor_w/2 + 5;
        translate([0, motor_l/2, rad - h/2 + t]){
            rotate([90, 0, 0])
            cylinder(10, rad, rad, center=true);
        }
    }
}

body_mount();
//small_gear();
//big_cog();
