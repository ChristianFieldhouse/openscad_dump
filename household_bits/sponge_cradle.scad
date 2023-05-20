

module tuby(path, r=1.5){
    for (i = [0:1:len(path)-2]){
        hull(){
            translate(path[i])
            sphere(r);
            translate(path[i + 1])
            sphere(r);
        }
    }
}

h0 = 5.43;
d0 = 3;
l0 = 23.45 + 1.5;

s0 = 2; // first slope down

d1 = 5;
l1 = 20-d1;

h1 = h0 - 9.36;

h15 = h1 - 4;


h2 = -100;

riml = l0 + l1 + d1;
base = 45;
h = base;

path = [
    [0, 0, 0],
    [d0, 0, h0],
    [l0-s0, 0, h0],
    [l0, 0, h1],
    [l0 + l1, 0, h15],
    [riml, 0, h15 - d1],
    [riml, 0, h2],
    [riml + base, 0, h2],
    [riml + base, 0, h2 + h],
];

tuby(path);

module triangle_mesh(p0, p1, z, n, m){
    for (j = [0:m-1]){
        bottom_points = [for (i = [0:n]) p0 + (p1 - p0)*i/n + 2 * z * round((j + 1) / 4)];
        top_points = [for (i = [0.5:n-0.5]) z + p0 + (p1 - p0)*i/n + 2 * z * round(j / 4)];
        for (i = [0:n-1]){
            tuby([bottom_points[i], top_points[i], bottom_points[i+1]]);
        }
    }
}

z = 15;
segments = [1, 3, 1, 2, 1, 10, 5, 5];
echo(((3/2) % 1 < 1) * 3);
for (i = [0:len(path)-2]){
    triangle_mesh(path[i], path[i+1], [0, z, 0], segments[i], 2);
}

tuby([for(p = path) p + [0, z * 2, 0]]);
tuby([[0, 0, 0], [0, 2*z, 0]]);
