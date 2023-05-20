use <MCAD/regular_shapes.scad>

t = 1.5;
h = 10;

r = 45;
r_ear = 20;

module silhouette(w=10, h=10){
    difference(){
        union(){
            difference(){
                for (x = [-30, 30])
                    translate([x, 30, 0])
                    cylinder_tube(h, r_ear + w/2, w);
                cylinder(h, r + w/2, r + w/2);
            }
            cylinder_tube(h, r + w/2, w);
        }
        union(){
            translate([0, 0, t])
            cylinder_tube(h, r + w/2 - t, w - 2*t);
            for (x = [-30, 30])
                translate([x, 30, t])
                cylinder_tube(h, r_ear + w/2 - t, w-2*t);
        }
    }
}

//silhouette(10, 10);
silhouette(10 + 2*t+ 0.3, 6);