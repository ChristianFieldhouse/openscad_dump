use <MCAD/regular_shapes.scad>
diam = 5.5;
achieved_diam = 5.05;
pad = (diam - achieved_diam) / 2;
r = diam/sqrt(3) + pad;

thread_diam = 2.90;
thread_pad = (0.1 + 2.85 - 2.46)/2;
t = 1;

module nut_clamp(h=3){
    linear_extrude(height=h){
        difference(){
            circle(r=r + t, $fn=6);
            circle(r=r, $fn=6);
        }
    }
}

module thread_tube(height=20, gap=0.0, $fn=20){
    cylinder_tube(height, thread_diam/2 + t + thread_pad + gap, t);
}

//thread_tube($fn=20);