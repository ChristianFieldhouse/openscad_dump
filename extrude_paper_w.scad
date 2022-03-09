width = 57;

t=1;
rib = 10 + 2*t;
inner = (width - 2* rib) / 2;

module curvy(t=t, h=50, segs=10, theta=80, eps=0.01){
    for (i = [0: segs-1]){
        hull(){
            seg = (inner + t)/segs;
            translate([i*seg - t/2, -t/2, 0]) cube([seg, t, eps]);
            translate([t/2 * (sin(theta) - cos(theta)), -t/2 * (cos(theta) + sin(theta))]) rotate(theta, [0, 0, 1]) translate([i*seg, 0, h]) cube([seg, t, eps]);
        }
    }

    for (i = [0: segs-1]){
        hull(){
            seg2 = (rib + t)/segs;
            translate([i*seg2 + inner, -t/2, 0]) cube([seg2, t, eps]);
            translate([inner*cos(theta) - t/2*( sin(theta) + cos(theta)), inner*sin(theta) - t/2 * (cos(theta) - sin(theta)), 0]) rotate(-theta, [0, 0, 1]) translate([i*seg2, 0, h]) cube([seg2, t, eps]);
        }
    }
}

module hollow(h=50, segs=30, theta=80){
    intersection(){
        difference(){
            curvy(t=4, segs=segs, theta=theta, h=h);
            curvy(t=2, segs=segs, theta=theta, h=h);
        }
        translate([width, 0, h]) cube([width*2, width, h * 2], center=true);
    }
}

module continuous(h=50){
    hollow(h=h);
    mirror(){
        hollow(h=h);
    }
}

module slice(z=0, h=50){
    translate([0, 0, -z])
    intersection(){
        continuous(h=h);
        translate([0, 0, z + t])
        cube([width * 2, width, 2*t], center=true);
    }
}

num_slices = 5;
for(i = [0:num_slices - 1]){
    translate([0, i * width/4, 0])
    slice(i * (50 - 2*t)/(num_slices - 1));
}