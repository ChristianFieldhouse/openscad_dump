
t = 2;
height = 7.5;
gap = 2.69;
w = 12;
l = 15;

rotate([0, 90, 0])
difference(){
    cube([height, l, w + gap + t], center=true);
    translate([0, t/2, (w + gap + t) / 2 - gap])
    cube([height, l-t, gap], center=true);
}