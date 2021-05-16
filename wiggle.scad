thickness = 1.5;
r = 4;
span = 20;
scrunch = 1.5;
res = 20;
flaps = 20;
linear_extrude(height = 5, center = true, convexity = 10){
for (i = [0:1:flaps]){
    translate([i * (4 * r - 2 * scrunch - 2 * thickness), 0]){
        polygon(points = [ [r, 0], [r - scrunch, span], [r - scrunch - thickness, span], [r - thickness, 0] ]);
        difference(){
            difference(){
                circle(r, $fn=res);
                circle(r - thickness, $fn=res);
            };
            translate([-r, 0]){
                square(2 * r);
            }
        }
        translate([2*r - thickness - scrunch, span]){
            difference(){
                difference(){
                    circle(r, $fn=res);
                    circle(r - thickness, $fn=res);
                };
                translate([-r, -2*r]){
                    square(2 * r);
                }
            }
        }
        polygon(points = [ [3 * r - 2 * thickness - scrunch, span], [3 * r - thickness - scrunch, span], [3 * r - 2 * scrunch - thickness, 0], [3 * r - 2 * scrunch - 2 * thickness, 0] ]);
    }
}
}