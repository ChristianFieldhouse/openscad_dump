
switch = [50, 19.3, 11.7 + 0.5];

pico = [21, 51, 1.5];
t = 1.5;

body = [pico.x + 2*t, pico.y, switch.z + pico.z + 2*t];

if (false){
    difference(){
        cube(body, center=true);
        translate([0, 0, t/2])
        cube(body + [-4*t, 0, -t], center=true);
        translate([0, 0, body.z/2 - t - pico.z/2])
        cube(pico, center=true);
        translate([switch.x/2, 0, 100/2-t/2])
        cube(switch + [0,0, 100], center=true);
    }
}

difference(){
    difference(){
        cube(body + [2*t, 0, t], center=true);
        translate([0, 0, t/2])
        cube(body, center=true);
        translate([0, 0, body.z/2 - t - pico.z/2])
        cube(pico, center=true);
        translate([switch.x/2, 0, 100/2-t/2])
        cube(switch + [0,3, 100], center=true);
    }
}
