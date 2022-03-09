use <MCAD/regular_shapes.scad>

in = 8.04 / 2;
out = 22 / 2;
h = 7;

eps_in = 0.01;
eps_out = 0.1;

in_r = in - eps_in;
out_r = out + eps_out;

$fn=40;

module housing(h=h){
    cylinder_tube(h, out_r + 1, 1, center=true);
}

module axil(length=h*2){ 
    cylinder_tube(length, in_r, in_r, center=true);
}

//housing();
//axil();