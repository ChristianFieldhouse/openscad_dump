use <MCAD/regular_shapes.scad>

hole = [14, 12, 7];
t = 1.6;
ring_t = 1.5;
eps = 0.5;
clip_fill = 0.3;
r = 12/2;

module socket(){
    difference(){
        cube(hole + [t, 0, t], center=true);
        cube(hole, center=true);
    }
    translate([0, hole.y/2 + r+ring_t, -hole.z/2-ring_t])
    torus2(r+ring_t, ring_t, $fn=20);
}

module half_clip(){
    y = hole.y + 2*eps;
    x = hole.x*0.5*clip_fill;
    z = hole.z - 2*eps;
    translate([hole.x/2 - x/2 - eps, 0, 0]){
        cube([x, y, z], center=true);
        translate([0, y/2, -z/2])
        linear_extrude(height=z){
            polygon([
                [x*1.5, 0],
                [-x/2, 0],
                [-x/2, 5*x],
                [x/2, 5*x]
            ]);
        }
    }
    translate([0, -y/2-x/2, 0])
    cube([hole.x-2*eps, x, z], center=true);
    translate([0, -y/2-x/2-r-ring_t, ring_t-z/2])
    torus2(r+ring_t, ring_t, $fn=20);
}

module clip(){
    half_clip();
    mirror([1, 0, 0])
    half_clip();
}

module prong(t, bw, tw, l){
    linear_extrude(height=t){
        polygon([
            [t/2 + bw, 0],
            [t/2 + bw + t, 0],
            [t/2 + tw + t, l],
            [t/2 + tw, l]
        ]);
    }
}

module fork(t=3, bw=1.5, tw=2.5, l=21){
    translate([0, l/2, t/2])
    cube([t, l, t], center=true);
    prong(t, bw, tw, l);
    mirror([1, 0, 0])
    prong(t, bw, tw, l);
    translate([-t*1.5-bw, -t, 0])
    cube([bw*2+3*t, t, t]);
}

//translate([0, hole.y + 1*hole.x, eps + (hole.y - hole.z)/2])
//rotate([90, 0, 0])
//socket();
//clip();

translate([20, 0, 0])
fork();
