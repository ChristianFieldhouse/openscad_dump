use <MCAD/regular_shapes.scad>

t = 6;
w = 42.9 + 0.2;
h = 37.14 + 0.2;

frame = [w, h, t];

hook_r = 22;
num_hooks = 1;

hook0_space = hook_r * 2;
hook_step = hook_r * 3;

difference(){
    cube(frame + [2*t, 2*t, 0], center=true);
    cube(frame, center=true);
}

spine_l = hook0_space + hook_step*(num_hooks-1) + 7;
translate([0, spine_l/2+h/2+t, 0])
cube([2*t, spine_l, t], center=true);


theta = 20;
for (i = [0:num_hooks-1]){
    translate([0, h/2+ hook0_space + hook_step*i, 0])
    intersection(){
        translate([0, 0, hook_r-t/2])
        rotate([0, 90, 0])
        torus2(hook_r, t);
        
        rotate([0, -90, 0])
        translate([0, 0, -t])
        linear_extrude(2*t){
            polygon([
                [-t/2, 0],
                [hook_r, 0],
                [cos(theta)*(hook_r + t)*sqrt(2) + hook_r, sin(theta)*(hook_r + t)*sqrt(2)],
                [hook_r, (hook_r + t)*sqrt(2)],
                [-t/2, hook_r+t]
            ]);
        }
    }
}