
joy_width = 26.4;
tcv_width = 15.54;

x_groove = joy_width + tcv_width + 0.2;

t = 6.2;
tg = 4.7;

difference(){
    cube([x_groove + 4, 30, t], center=true);
    translate([0, 0, (t - tg)/2])
    cube([x_groove, 30, tg], center=true);
}