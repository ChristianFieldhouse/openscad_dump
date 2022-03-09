use <MCAD/regular_shapes.scad>

function shrinky(point, a, fake_base_height, r) = 
    let(angle=a*point[0], rad=r * (fake_base_height + point[2])/fake_base_height)
        [rad * sin(angle), rad * cos(angle), 0];

function radialt(point, a, fake_base_height, r) =
    let(angle=a*point[0] + 0.2*point[2])
        (point[2] > 0) ? 
            [r*sin(angle), r*cos(angle), point[2]] : 
            shrinky(point, a, fake_base_height, r);

function transform(point, radial=true, a, fake_base_height, r) =
    radial ? radialt(point, a, fake_base_height, r) : point;

module line(
    start=[0, 0, 0],
    end=[1, 0, 0],
    t=2, radial=true,
    r=50, fake_base_height
){
    a = (180/PI)/r;
    start_ = transform(start, radial, a, fake_base_height, r);
    //echo(start, start_, fake_base_height, r);
    end_ = transform(end, radial, a, fake_base_height, r);
    hull(){
        translate(start_)
        sphere(t/2);
        translate(end_)
        sphere(t/2);
    }
}

module strip_hex(
    steps=3,
    offs=[0, 0, 0],
    flip=false,
    r=50,
    fake_base_height=100,
    l=10
){
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
            line(
                points[i], points[i+1],
                t=2, true, r=r, 
                fake_base_height=fake_base_height, 
                $fn=10
            );
        }
    }
}

module wall_hex(x=3, z=6, fake_base_height=100, r=50, l=10){
    for (i = [0:1:z-1]){
        strip_hex(
            x,
            offs=[l*sqrt(3)/2 * (i%2), 0, l*1.5*i - fake_base_height,],
            flip=(i%2==0),
            r=r,
            fake_base_height=fake_base_height,
            l=l
        );
    }
}

module hex_container(
    l = 10,
    cn = 21,
    h = 150,
    t = 2,
    base_density=1,
){
    r = sqrt(3)*cn*l / (2*PI);
    echo(r);
    fake_base_height = r*base_density;
    zn = round((h + fake_base_height)/(1.5*l));
    wall_hex(cn, zn, fake_base_height=fake_base_height, r=r, l=l);
}

hex_container();