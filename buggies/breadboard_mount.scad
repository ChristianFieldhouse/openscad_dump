
t = 1.5;
pitch = 2.5;

x = 70.14;
y = 51.14;

difference(){
    cube([x + t, y + t, t], center=true);
    translate([t, -t, 0])
    cube([x - t, y-t, t], center=true);
}

translate([0, 0, t])
difference(){
    cube([x + t, y + t, t], center=true);
    translate([t/2, -t/2, 0])
    cube([x, y, t], center=true);
}