module spiral(width = 1, laps = 1, grad = 3/360, r0 = 1, fn = 24) {
    step = 360 / fn;

    points = concat(
        [for(a = [0 : step : 360 * laps])
            [(r0 + a * grad) * cos(a), (r0 + a * grad) * sin(a)]
        ],
        [for(a = [360 * laps : -step : 0])
            [(r0 + a * grad + width) * cos(a), (r0 + a * grad + width) * sin(a)]
        ]
    );

    polygon(points);

}

spiral(r0 = 0, laps = 10, grad=3/360);