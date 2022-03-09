include <gear_down.scad>
use <MCAD/regular_shapes.scad>

wheel_r = 34;
wheel_t = 20;
spokes = 12;

big_cog();

module flat_heart(sq=30, r=13) {
  square([sq, r*1.5]);
  square([r*1.5, sq]);

  translate([r, sq, 0])
  circle(r);

  translate([sq, r, 0])
  circle(r);
}

module heart(h=3, sq=30){
    r = 13 * sq/30;
    linear_extrude(height=h) flat_heart(sq, r);
}

translate([0, 0, 0])
cylinder_tube(wheel_t, wheel_r, 1, center=true);

difference(){
    linear_extrude(height=1){
        for (i = [0:spokes-1]){
            spoke_l = wheel_r;
            rotate(i * 360 / spokes){
                translate([spoke_l / 2, 0]){
                    square([spoke_l, 3], center=true);
                }
            }
        }
    }
    cylinder(20, out_r, out_r);
}

heart_t = 3;

for (i = [0:45:360]){
    rotate([0, 0, i])
    translate([0, wheel_r + heart_t - 0.5, 3 - wheel_t / 2])
    rotate([90, 0, 0])
    rotate([0, 0, 45])
    heart(heart_t, wheel_t/2);
}

//translate([0, 0, -10])
rotate([0, 180, 0])
linear_extrude(height=10){
    text("CF", size=30, valign="center", halign="center");
}
//linear_extrude(height=axil_span/2 + t){
//    circle(a_r, $fn=res);
//}
//
