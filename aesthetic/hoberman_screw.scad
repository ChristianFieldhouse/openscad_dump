
base = [40, 40, 5];
motor = [12.05, 10, 14.5];
wires = [motor.x, 6, base.z];
t = 1;

wires_out = [1000, wires.y, base.z/2];

module base(){
    difference(){
        union(){
            cylinder(base.z, base.x, base.y);
            translate([0, 0, base.z + motor.z/2])
            difference(){
                cube(motor + [2*t, 2*t, 0], center=true);
                cube(motor, center=true);
            }
        }
        translate([0, 0, wires.z/2])
        cube(wires, center=true);
        translate([0, 0, wires_out.z/2])
        cube(wires_out, center=true);
    }
}

module stick(){
    translate([0, 0, motor.z/2])
    difference(){
        cube(motor + [3*t, 4*t, 0], center=true);
        translate([-t/2, 0, 0])
        cube(motor + [2*t, 2*t, 0], center=true);
    }
    stick_r = 4;
    translate([motor.x/2 + t + stick_r, 0, 0])
    cylinder(75, stick_r, stick_r);
}

switch = [19.3, 50, 11.7 + 0.5];
switch_lip = 2.3;
base_base_z = switch.z + 2*(t + switch_lip);

module base_base(){
    difference(){
        union(){
            translate([0, 0, base_base_z])
            difference(){
                cylinder(base.z, base.x + t, base.y+t);
                cylinder(base.z, base.x, base.y);
            }
            difference(){
                cylinder(base_base_z, base.x + t, base.y + t);
                cylinder(base_base_z, base.x - t, base.y - t);
            }
            cylinder(t, base.x, base.y);
        }
        for (angle = [0, 90]){
            rotate([0, 0, angle])
            translate([0, base.y, switch.z/2 + t + switch_lip])
            cube(switch, center=true);
        }
    }
}

base_base();
//stick();