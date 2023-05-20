
step = 9;
diams = [4, 4, 4, 5, 5]; // spare big ones
//diams = [1, 1.5, 2, 2.5, 3, 4, 5]; // regular set
n = len(diams);
h = 35;
t = 2;
eps = 0.5;

difference(){
    cube([h + t*2, step*n, step + t]);
    translate([t, 0, t])
    cube([h, step*n, step]);
    for (i = [0:len(diams) - 1]){
        rad = diams[i]/2 + eps;
        translate([0, step/2 + i*step, step/2 + t])
        rotate([0, 90, 0])
        cylinder(2*h, rad, rad, $fn=6);
    }
}