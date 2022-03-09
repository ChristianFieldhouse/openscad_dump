
t = 0.7;
h = 4;
pitch = 2.5;

x = 2;
y = 4;

for (i = [1:1:x-1]){
    translate([(i - (x/2)) * pitch, 0, 0])
    cube([t, y * pitch, h], center=true);
}

for (j = [1:1:y-1]){
    translate([0, (j - (y/2)) * pitch, 0])
    cube([x * pitch, t, h], center=true);
}