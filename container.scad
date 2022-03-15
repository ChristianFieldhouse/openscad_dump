use <MCAD/regular_shapes.scad>

function shrinky(point, a, fake_base_height, r) = 
    let(angle=a*point[0], rad=r * (fake_base_height + point[2])/fake_base_height)
        [rad * sin(angle), rad * cos(angle), 0];

polygonify=4;
poly = 7;
corner_exponent=6;
corner_max=0.05;
function radialt(point, a, fake_base_height, r) =
    let(
        angle=a*point[0],
        circular_rad=r,
        polygon_rad=r*(1/cos(angle%(360/poly) - 180/poly) -
            corner_max*pow(2*(angle%(360/poly))/(360/poly) - 1, 6)),
        rad= circular_rad * (1-polygonify) +
            polygonify * polygon_rad
    ) // + 0.2*point[2])
        (point[2] > 0) ? 
            [rad*sin(angle), rad*cos(angle), point[2]] : 
            shrinky(point, a, fake_base_height, rad);

function transform(point, radial=true, a, fake_base_height, r) =
    radial ? radialt(point, a, fake_base_height, r) : point;

module line(
    start=[0, 0, 0],
    end=[1, 0, 0],
    t=2, radial=true,
    r=50, fake_base_height=100
){
    a = (180/PI)/r;
    start_ = transform(start, radial, a, fake_base_height, r);
    //echo(start, start_, fake_base_height, r);
    end_ = transform(end, radial, a, fake_base_height, r);
    diff = end_ - start_;
    random_vec = [0.123, 0.456, 0.789];
    random_vec_normed = random_vec / norm(random_vec);
    diff_normed = diff / norm(diff);
    new_x_unnormed = cross(diff_normed, random_vec_normed);
    new_x = new_x_unnormed / norm(new_x_unnormed);
    new_y_unnormed = cross(diff_normed, new_x);
    new_y = new_y_unnormed / norm(new_y_unnormed);

    hull(){
        translate(start_)
        sphere(t/2);
        translate(end_)
        sphere(t/2);
    }
    
    /*
    multmatrix(m = [
                [new_x[0], new_y[0], diff[0], start_[0]],
                [new_x[1], new_y[1], diff[1], start_[1]],
                [new_x[2], new_y[2], diff[2], start_[2]],
                [       0,        0,       0,         1]
              ]){
        cylinder(t/2, t/2, 1);
    }
    translate(end_) sphere(t/2);
    */
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

module rotational_slice(x=3, z=6, fake_base_height=100, r=50, l=10){
    for (i = [0:1:z-1]){
        strip_hex(
            1, //x,
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
    cn = 150,
    h = 21,
    t = 2,
    base_density=1,
){
    r = sqrt(3)*cn*l / (2*PI);
    echo(r);
    fake_base_height = r*base_density;
    zn = round((h + fake_base_height)/(1.5*l));
    if (polygonify != 0){
        wall_hex(cn, zn, fake_base_height=fake_base_height, r=r, l=l);
    }
    else{
        for (i = [0:1:cn-1]){
            rotate([0, 0, i*360/cn])
            rotational_slice(cn, zn, fake_base_height=fake_base_height, r=r, l=l);
        }
    }
}

hex_container(l=5, cn=38, h=10, base_density=1);