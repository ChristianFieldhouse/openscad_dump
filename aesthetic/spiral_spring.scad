use <spiral.scad>

h = 2;
t = 1;
laps = 3;

linear_extrude(height=h)
    spiral(width=t, r0=0, laps=laps);

lock_h = 1;
translate([0, -0.8 /*magic*/, (h + lock_h)/2])
    cube([2, 5, h + lock_h], center=true);

translate([3*(laps-1), 0, 0])
    cube([3 + 1, 2, 2]);

handle_h = 2;
translate([0, 0, 2 + lock_h + handle_h/2])
    cube([2, 3*laps*2, handle_h], center=true);