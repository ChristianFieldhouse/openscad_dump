gap = 30;
t = 1.5;

h = 15;
overlap = 5;
dip = 7;

l = 10;

cube([overlap + gap + t, l, t]);
translate([gap, 0, -dip])
cube([t, l, dip + t]);
cube([t, l, h]);