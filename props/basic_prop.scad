
z_max = 20;
z_angle_max = 2* z_max;
angle_range = 45/2;
r_max = 50;
r_mid = 35;
z_join_min = 0.3 * z_max;
z_join_max = 0.7 * z_max;
z_tip = z_max / 2;
rot_exp = 2;
fill_exp = 2;

z_step = 0.2;

t = 1;

function r_start(z) = (
    (z < z_join_min) ?
        pow((z_join_min - z)/z_join_min, fill_exp)*r_mid
    : (z > z_join_max) ?
        pow((z - z_join_max)/(z_max - z_join_max), fill_exp)*r_mid
    : 0
);

function r_end(z) = (
    (z < z_tip) ?
        r_max - pow((z_tip - z)/z_tip, fill_exp) * (r_max - r_mid)
    :
        r_max - pow(
            (z - z_tip)/(z_max - z_tip),
            fill_exp
        ) * (r_max - r_mid)
);

module cross_section(z=0){
    mr_start = r_start(z);
    mr_end = r_end(z);
    rotate([0, 0, angle_range*z_angle_max/z_max * pow((z_max - z)/z_angle_max, rot_exp)])
    translate([mr_start, -t/2, z])
    cube([mr_end - mr_start, t, 0.01]);
}

for (theta = [0: 360/3: 360]){
    rotate([0, 0, theta])
    rotate([90+20, 0, 0])
    translate([0, 0, -z_max/2])
    for (z = [0:z_step:z_max]){
        hull(){
            cross_section(z);
            cross_section(z + z_step);
        }
    }
}