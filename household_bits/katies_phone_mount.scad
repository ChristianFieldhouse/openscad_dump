use <MCAD/regular_shapes.scad>

height = 2;
t = 1.5;
x = 40.48/2 + t + (40.48 - 39.41)/2;
y = 14.27/2 + t;

phone_t = 10.3;
phone_w = 75;
phone_holder_w = phone_w + 2*t;
phone_holder_t = phone_t + 2*t;

l = 110;

oval_tube(height, x, y, t);

translate([0, -l-y - phone_t/2, height/2])
difference(){
    cube([phone_holder_w, phone_holder_t, height], center=true);
    wedge();
    cube([phone_w, phone_t, height], center=true);
}

dec = 10;
squiggle = 1;
for (x_dec = [-dec, dec]){
    translate([x_dec, squiggle -l/2 - y, height/2])
    cube([t, l + squiggle, height], center=true);
}