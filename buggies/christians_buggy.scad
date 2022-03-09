include <bearing_housing.scad>;

module truss(x=100, y=10, z=10, t=1){
    difference(){
        cube([x, y, z], center=true);
        cube([x-2*t, y-2*t, z], center=true);
    }
    for (xx = [-x/2 + t/2:z:x/2]){
        translate([xx, 0, 0])
        cube([t, y, z], center=true);
    }
}

module side(wheel_base = 100){
    translate([wheel_base/2, 0, 0])
    truss(wheel_base - 2*out_r, h, h);
    housing();
    translate([wheel_base, 0, 0])
    housing();
}

motor_w = 18.84;
motor_l = 37.04;
motor_flat_l = 32.16;
motor_rad = motor_l - motor_flat_l;

module body_mount(t = 1, h=4){
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

batteries_w = 37.29;
batteries_l = 69.29;
module katies_half_chassis(b = 50, a = 40){
    translate([0, motor_l/2 + b / 2, 2])
    body_mount();
    
    t = 2;
    translate([0, 0, -t/2]){
        difference(){
            cube([batteries_w + 2*t, a + 2*t, t], center=true);
            cube([batteries_w, a, t], center=true);
        }
        translate([0, (b - a)/2 + t + motor_l/2 + (b - a)/2 + t, 0])
        cube([motor_w, motor_l/2 + (b - a)/2 + t, t], center=true);
    }
    hull(){
        translate([0, a/2, 0]){
            cube([batteries_w, t, 0.01], center=true);
            d = 5;
            translate([0, -d, d])
            cube([batteries_w, t, 0.01], center=true);
        }
    }
}

module katies_chassis(){
    katies_half_chassis();
    mirror([0, 1, 0]){
        katies_half_chassis();
    }
}

module half_chassis(b = 100, u=20){
    translate([b / 2, 0, 2]){
        body_mount();
        translate([0, 0, -u/2 - 2])
        cube([motor_w, 10, u], center=true);
    }
    
    translate([0, 0, -1 - u])
    cube([b + motor_w, 10, 4], center=true);
}

module chassis(){
    half_chassis();
    mirror([1, 0, 0]){
        half_chassis();
    }
}

module top(l=180, w=, t=2){
    difference(){
        cube([w, l, 2*t + 4], center=true);
        translate([0, l/2 - 10/2, 0])
        cube([w, 10, 4], center=true);
        translate([0, 10/2 - l/2, 0])
        cube([w, 10, 4], center=true);
    }
}

top();

//chassis();
//side(wheel_base=100);