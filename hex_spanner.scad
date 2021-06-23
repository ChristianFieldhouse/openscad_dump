
t = 20;

diam = 17;
rad = diam/2;
tol = 0.4;
inner_r = rad * 2 / sqrt(3) + tol;
outer_r = inner_r + t;

grip_r = 5;

linear_extrude(height=5){
union(){
    difference(){
        circle(outer_r, $fn=6);
        circle(inner_r, $fn=6);
    }
    //for(i = [0:6]){
    //    translate([outer_r * cos(i * 60), outer_r * sin(i * 60)])
    //        circle(grip_r);
    //}
    translate([100/2 + inner_r, 0]){
        square([100, 30], center=true);
    }
}
}