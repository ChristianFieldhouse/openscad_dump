use <pointy_polygon.scad>
linear_extrude(height=2, center = true, convexity = 10){
rad = 10;
difference(){
    pointy(verts=20, fn=20, k=7, g=5, rad=rad);
    union(){
        for (i = [0:19]){
            rotate(- i * 360/20){
                ts = 0;
                if (i > 9){
                    numlength = 2;
                    echo(numlength);
                    translate([-ts * (0.3*(numlength - 1) + 1/2), rad - 2 * ts - 2])
                    text(str(i), size=ts);
                }
                else{
                    numlength = 1;
                    echo(numlength);
                    translate([-ts * (0.3*(numlength - 1) + 1/2), rad - 2 * ts - 2])
                    text(str(i), size=ts);
                }
            }
        }
    };
    difference(){
        rad = 5.95/2;
        small_diam = 4.45;
        eps = 0.2;
        inwards = 2 * rad - small_diam;
        circle(rad + eps, $fn=20);
        translate([rad * 3/2 - inwards + eps, 0])
        square([rad, 3 * rad], center=true);
    }
}
}