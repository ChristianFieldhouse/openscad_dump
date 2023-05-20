
n = 2;
m = 4;

t = 3.5;
d = 6.3;

h = 1.5;

difference(){
    cube([(d + t) * n + t, (d + t) * m + t, h]);
    for (y = [t + d/2:d+t:m*(d + t)]){
        for (x = [t + d/2:d+t:n*(d + t)]){
            translate([x, y, 0])
            cylinder(2*t, d/2, d/2);
        }
    }
}