$fn = 5;

alpha = 75;
l = 3;
up = 1;

X = 3;
Y = 3;
Z = 4;

angly = 3;

translate([-1, 0, 0])
rotate(90, [0, 1, 0])
cylinder(1.3, 3.5, 3.5);

function remap(x0) = let(
    alpha=x0[2] * 3,
    x = cos(alpha) * x0[0] - sin(alpha) * x0[1], 
    y = cos(alpha) * x0[1] + sin(alpha) * x0[0]
)[
    x0[2] * cos(x * angly) * cos(y * angly),
    x0[2] * sin(x * angly) * cos(y * angly),
    x0[2] * cos(x * angly) * sin(y * angly),
];

module sphere_hull(x0, x1, r0, r1){
    sp0 = remap(x0);
    sp1 = remap(x1);
    hull(){
        translate(sp0) sphere(r0);
        translate(sp1) sphere(r1);
    }
}

old_one = false;

if (old_one){
for (j = [0: Z-1]){
    for (i = [round(-j/2): max(round((j - 1)/2), 0)]){
        for (k = [round(-j/2): max(round((j - 1)/2), 0)]){
            let(s = 1)
            let(next_s = 1)
            translate([l*cos(alpha) * (j%2) * s, l*cos(alpha) * (j%2) * s, 0]){
                translate([i * 2 * cos(alpha) * l * s, k * 2 * cos(alpha) * l * s, l * j * (1 + sin(alpha))])
                sphere_hull([0, 0, 0],[0, 0, l], 1, 1);

                translate([i * 2 * cos(alpha) * l * s, k * 2 * cos(alpha) * l * s, l * j * (1 + sin(alpha))])
                for (sgx = [-1, 1]) for (sgy = [-1, 1])
                sphere_hull(
                    [0, 0, l],
                    [sgx * cos(alpha) * l * next_s, sgy * cos(alpha) * l * next_s, l * (1 + sin(alpha))]
                    , 1, 1
                );
            }
        }
    }
}
}
else{
for (j = [0: Z-1]){
    for (i = [0: pow(2, j) - 1]){
        for (k = [0: pow(2, j) - 1]){
            let(s = pow(2, Z - j))
            let(next_s = pow(2, Z - j - 1))
            let(offs = - l * cos(alpha) * (pow(2, j) - 1) * s)
            let(branch = 2 * cos(alpha) * l * s)
            let(upstep = l * (up + sin(alpha))){
            sphere_hull(
                [offs + i * branch, offs + k * branch, j * upstep],
                [offs + i * branch, offs + k * branch, l * up + j * upstep],
                r0 = 1 - (j/Z),
                r1 = 1 - (j+0.5)/Z
            );
            for (sgx = [-1, 1]) for (sgy = [-1, 1])
                sphere_hull(
                    [offs + i * branch, offs + k * branch, l * up + j * upstep],
                    [offs + i * branch + sgx * cos(alpha) * l * next_s, offs + k * branch + sgy * cos(alpha) * l * next_s, upstep + j * upstep],
                    r0 = 1 - (j + 0.5)/Z,
                    r1 = 1 - (j + 1)/Z
                );
            }
        }
    }
}
}