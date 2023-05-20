use <MCAD/regular_shapes.scad>

r = 3;
R = 20;
stretch = 1;

for (i = [0:5 - 1]){
    translate([0, R * i * stretch * 1.3, 0]){
        rotate(90 * (i % 2), [0, 1, 0])
        scale([1, stretch, 1]){
            torus2(R, r);
        }
    }
}