

big_r = 10;
h = 30;
v_step = 0.05;
bulge = 0.3;
BULGE_MAX = 0.25;

heights_and_rads = [
    for (i = [0: v_step: 1.01])[
        i, 1 - bulge * (i - 0.5) * (i - 0.5) / BULGE_MAX
    ]
];

echo(heights_and_rads);

hr_pairs = [
    for (i = [0: 1: 1/v_step - 1])[
        heights_and_rads[i], heights_and_rads[i+1]
    ]
];

rotate_extrude($fn=100)
for (ir = hr_pairs){
    hull(){
        translate([ir[0][1] * big_r, ir[0][0] * h, 0]) circle(r=1);
        translate([ir[1][1] * big_r, ir[1][0] * h, 0]) circle(r=1);
    }
}

echo(heights_and_rads);
echo(hr_pairs);