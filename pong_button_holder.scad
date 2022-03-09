
aa_w = 33.51;
button_w = 5.96 + 0.5;
t = 1.5;
d = 15;
w = 6; //button_w + 2*t;

difference(){
    cube([w, aa_w + 2*t, t], center=true);
    //translate([0, 1.5*button_w, 0])
    //cube([button_w, button_w, t], center=true);
    //translate([0, -1.5*button_w, 0])
    //cube([button_w, button_w, t], center=true);
}
translate([0, aa_w/2 + t/2, (d + t)/2])
cube([w, t, d], center=true);
translate([0, -aa_w/2 - t/2, (d + t)/2])
cube([w, t, d], center=true);