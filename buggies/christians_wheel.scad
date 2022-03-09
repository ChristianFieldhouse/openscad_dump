include <gear_down.scad>
use <MCAD/regular_shapes.scad>

wheel_r = 50;
wheel_t = 8;
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

translate([0, 0, wheel_t/2])
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

grip_t = 3;

for (i = [0:360/spokes:360]){
    rotate([0, 0, i])
    translate([0, wheel_r + grip_t/2, wheel_t / 2])
    cube([2, grip_t, wheel_t], center=true);
}

//linear_extrude(height=axil_span/2 + t){
//    circle(a_r, $fn=res);
//}
//
