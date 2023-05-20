
r3 = sqrt(3);
// geometry for 'the hat' monotile:
edges = [
    [r3, -90],
    [r3, -30],
    [1, 60],
    [1, 120],
    [r3, 30],
    [r3, 90],
    [1, 180],
    [1, 120],
    [r3, -150],
    [r3, 150],
    [1, -120],
    [2, -60],
    [1, 0]
];

// translate the lengths and angles into vectors:
vectors = [
    for (i = [0:len(edges)-1]) 
    let(
        vert = [edges[i][0]*cos(edges[i][1]), edges[i][0]*sin(edges[i][1])]
    )
    vert
];

function vert(i=0) = (i < 1) ? vectors[0] : vert(i-1) + vectors[i];


verts = [for (i = [0:len(edges)-1]) vert(i)];

echo(verts);

height = 1;

length_scale = 10;
scale([length_scale, length_scale, 1])
linear_extrude(height)
polygon(verts);
