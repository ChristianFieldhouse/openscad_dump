

function logistic(x, k=1, g=3) = g * (1 / (1 + exp(-k * x)) - 1/2);

function r(rad, b, fn, k, g) = rad - logistic(min(b, fn + 1 - b), k, g);

function angle(a, b, verts, step) = a * 360 / verts + b * step;

module pointy(rad=3, fn = 2, verts=3, k=1, g=3) {
    step = 360 / ((fn + 1) * verts);
    points = concat(
        [for(a = [0 : verts - 1])
            for(b = [0 : fn])[
                r(rad, b, fn, k / fn, g) * cos(angle(a, b, verts, step)), r(rad, b, fn, k / fn, g) * sin(angle(a, b, verts, step))
            ]
        ]
    );
    echo([0 : 1 : verts]);
    polygon(points);
}

linear_extrude(height = 2, center = true, convexity = 10){
    pointy(verts=20, fn=20, k=7, g=5, rad=20);
}