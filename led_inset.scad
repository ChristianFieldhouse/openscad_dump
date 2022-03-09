
t = 1;
led_r = 3.36/2;
wire_d = 2.77 - 0.48; //2.54;
wire_h = 0.8;

eps = 0.2;
$fn=20;

module led_inset(led_r = led_r, t = t, wire_d=wire_d, eps=0.2){
    translate([0, 0, t/2])
    cylinder(t, led_r + eps, led_r + eps, center=true);
    translate([0, wire_d/2, 0])
    cylinder(t, wire_h, wire_h, center=true);
    translate([0, -wire_d/2, 0])
    cylinder(t, wire_h, wire_h, center=true);
}
difference(){
    cube([8, 8, t], center=true);
    led_inset();
}