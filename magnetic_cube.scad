r = 3/2 + 0.1;
d = 1.2 + 0.3;

w = 5*r;
t=d+0.2;

module face(){
    difference(){
        hull(){
            cube([w, w, 0.001], center=true);
            translate([0, 0, t])
            cube([w - 2*t, w - 2*t, 0.001], center=true);
        }
        translate([0, 0, t-d])
        cylinder(d+0.001, r, r, $fn=10);
    }
}


overlap = 0.2;
wo = w - overlap;
for (offs = [[0, 0], [1, 0], [-1, 0], [0, -1], [0, 1], [0, -2]]){
    translate([offs.x*wo, offs.y*wo, 0])
    face();
}