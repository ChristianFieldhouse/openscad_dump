use <MCAD/regular_shapes.scad>

l = 10;
cn = 19;
r = sqrt(3)*cn*l / (2*PI);
echo(r);
h = 150;
fake_base_height = 100;
t = 2;



function shrinky(point, a) = [r*sin(a*point[0]) * (fake_base_height + point[2])/fake_base_height, r*cos(a*point[0]) * (fake_base_height + point[2])/fake_base_height, 0];

function radialt(point, a) = (point[2] > 0) ? [r*sin(a*point[0]), r*cos(a*point[0]), point[2]] : shrinky(point, a);

function transform(point, radial=true, a) = radial ? radialt(point, a) : point;

module line(start=[0, 0, 0], end=[1, 0, 0], t=2, radial=true){
    a = (180/PI)/r;
    start_ = transform(start, radial, a);
    end_ = transform(end, radial, a);
    hull(){
        translate(start_)
        sphere(t/2);
        translate(end_)
        sphere(t/2);
    }
}

module strip(steps=3, offs=[0, 0, 0], flip=false){
    z0 = l;
    z1 = z0 + l/2;
    for (j = [0:1:steps-1]){
        x_offs = j * sqrt(3) * l;
        /*points = [
            [x_offs + offs[0], offs[1], offs[2]],
            [x_offs + l + offs[0], offs[1], offs[2]],
            [x_offs + 1.5* l + offs[0], offs[1], z + offs[2]],
            [x_offs + 1.5* l + l + offs[0], offs[1], z + offs[2]],
            [x_offs + 3 * l + offs[0], offs[1], offs[2]]
        ];
        */
        points = [
            [x_offs + offs[0], offs[1], offs[2]],
            [x_offs + offs[0], offs[1], offs[2] + z0],
            [x_offs + l*sqrt(3)/2 + offs[0], offs[1], z1 + offs[2]],
            [x_offs + l*sqrt(3)   + offs[0], offs[1], z0 + offs[2]]
        ];
        for (i = [0:1:len(points)-2]){
            line(points[i], points[i+1], t=2, $fn=10);
        }
    }
}

module wall(x=3, z=6){
    for (i = [0:1:z-1]){
        strip(x, offs=[l*sqrt(3)/2 * (i%2), 0, l*1.5*i - fake_base_height + l/2], flip=(i%2==0));
    }
}

zn = round((h + fake_base_height)/(1.5*l));

wall(cn, zn);
