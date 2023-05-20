res = 20;
l = 20;
hexx = 5;
hexy = 5;
bend = 5;
start = 12;
t = 1;
s
module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = t, fn = 100) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

rad = l/15;

linear_extrude(height = 5, center = true, convexity = 10){
    for (j = [0:hexy]){
        translate([l * (j % 2), sqrt(3) * l * j]){
            for (k = [0:hexx]){
                translate([k*l*2, 0]){
                    circle(2, $fn=res);
                    for (i = [0:60:360]){
                        rotate(i){
                            rotate(30){
                                polygon(points = [ [0, t/2], [0, -t/2], [start, -t/2], [start, t/2] ]);
                                translate([start, rad + t/2]){
                                    rotate(-90){
                                        arc(rad, [0, 180]);
                                    }
                                }
                                inclose = start/2 + 2 * rad;
                                polygon(points = [ [start, rad * 2 + t * 1.5], [start, rad * 2 + 0.5*t], [inclose, rad * 2 + t*0.5], [inclose, rad * 2 + t * 1.5] ]);
                                translate([inclose, 3 * rad + t * 1.5]){
                                    rotate(90){
                                        arc(rad, [0, 180]);
                                    }
                                }
                                polygon(points = [ [start + 2 * rad, rad * 4 + t * 2.5], [start + 2 * rad, rad * 4 + 1.5*t], [inclose, rad * 4 + t*1.5], [inclose, rad * 4 + t * 2.5] ]);
                                translate([start + 2 * rad , 2 * rad + t * 1.5]){
                                    rotate(0){
                                        arc(rad * 2, [0, 90]);
                                    }
                                }
                                translate([start + 5 * rad + t, 2 * rad + t * 1.5]){
                                    rotate(180){
                                        arc(rad, [0, 90]);
                                    }
                                }
                                frad = rad * 2.5;
                                translate([start + 5*rad + t, rad + t * (2-0.5) + frad]){
                                    rotate(-90){
                                        arc(frad, [0, 180]);
                                    }
                                }
                                offs = [start + 5*rad + t, rad + t * (2-0.5) + 2 * frad];
                                polygon(points = [ offs + [0, 0], offs + [0, t], [l * sqrt(3)/2, l/2 + t/2], [l* sqrt(3)/2, l/2 - t/2]]);
                            }
                        }
                    }
                }
            }
        }
    }
}