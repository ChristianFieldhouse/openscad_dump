 use <MCAD/teardrop.scad>

t = 3;
l = 10;

render_eps = 0.01;

module slot(tol=0.1, d=2*t, t=3){
    translate([d, 0, 0])
    difference(){
        union(){
            translate([-(d+t/2)/2, 0, 0])
            cube([d - t/2, t - 2*tol, t], center=true);
            rotate(90, [1, 0, 0])
            cylinder(t - 2*tol, t, t, center=true, $fn=20);
            //rotate(90, [0, 0, 1])
            //teardrop(t, t - 2*tol, center=true, angle=90, $fn=20);
        }
        rotate(90, [0, 0, 1])
        teardrop(t/2, 4*t + render_eps, angle=90, center=true, $fn=20);
    }
}

module slots(n=2, tol=0.1, d=2*t, t=3){
    translate([-t/2, 0, t/2])
    cube([t, (2*n - 1)*t - 2*tol, t], center=true);
    for (i = [0:n-1]){
        translate([0, (2 * i - n + 1) * t, t/2])
        slot(tol=tol, d=d, t=t);
    }
}

module segment(l=25, t=3, d=6){
    inner_l = l - 2*d;
    translate([0, 0, t/2])
    cube([inner_l, t, t], center=true);
    translate([inner_l/2, 0, 0])
    slots(3, tol=0.15);

    //rotate(180, [1, 0, 0])
    rotate(180, [0, 0, 1])
    translate([inner_l/2, 0, 0])
    slots(2, tol=0.15, d=d, t=t);
}

segment();
//translate([l + 2*t, 0, 0])
//segment();