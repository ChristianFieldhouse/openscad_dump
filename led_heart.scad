use <led_inset.scad>

t=1;
//cube([40, 40, t], center=true);
led_r = 3.36/2;
led_dist = 5.5;
led_margin = 3;

sq = 30;
r = 13;

module flat_heart(sq=sq, r=r) {
  square([sq, r*1.5]);
  square([r*1.5, sq]);

  translate([r, sq, 0])
  circle(r);

  translate([sq, r, 0])
  circle(r);
}

difference(){
    linear_extrude(height = t, center=true) 
    flat_heart();
    for (xy = [led_margin:led_dist:sq]){
        translate([xy, led_margin, 0]) led_inset();
        if (xy > led_margin){
            translate([led_margin, xy, 0]) rotate(90) led_inset();
        }
    }
    new_r = r - led_margin;
    angular_dist = 180 * (led_dist / new_r) / PI;
    for (theta = [0: angular_dist: 220]){
        translate([r - cos(theta)  * new_r, sq + sin(theta) * new_r, 0]) rotate(90 -theta) led_inset();
        translate([sq + sin(theta)  * new_r, r - cos(theta) * new_r, 0]) rotate(theta) led_inset();
    }
    translate([sq - 4.3*led_r, sq - 4.3*led_r, 0]) led_inset();
    
    
    
    for (xy = [led_r * 2 + led_margin:led_dist:sq/2]){
        translate([xy, led_margin, 0]) led_inset();
        if (xy > led_margin){
            translate([led_margin, xy, 0]) rotate(90) led_inset();
        }
    }
    new_r = r - led_margin;
    angular_dist = 180 * (led_dist / new_r) / PI;
    for (theta = [0: angular_dist: 220]){
        translate([r - cos(theta)  * new_r, sq + sin(theta) * new_r, 0]) rotate(90 -theta) led_inset();
        translate([sq + sin(theta)  * new_r, r - cos(theta) * new_r, 0]) rotate(theta) led_inset();
    }
    translate([sq - 4.3*led_r, sq - 4.3*led_r, 0]) led_inset();
}