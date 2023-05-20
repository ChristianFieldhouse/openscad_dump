
t = 4;
h = 65;
l = h + 20; //36;
h2 = 15;

z = 20;

difference(){
    cube([h, l, z]);
    cube([h - t, l - t, z]);
}

translate([h - h2, 0, 0])
cube([h2, t, z]);