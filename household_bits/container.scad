use <MCAD/regular_shapes.scad>

function shrinky(point, a, fake_base_height, r) = 
    let(angle=a*point[0], rad=r * (fake_base_height + point[2])/fake_base_height)
        [rad * sin(angle), rad * cos(angle), 0];

polygonify=0;
poly = 5;
corner_exponent=6;
corner_max=0.1; //2/poly;
function radialt(point, a, fake_base_height, r) =
    let(
        angle=a*point[0],
        circular_rad=r,
        polygon_rad=r*(1/cos(angle%(360/poly) - 180/poly) -
            corner_max*pow(2*(angle%(360/poly))/(360/poly) - 1, 6)),
        rad= circular_rad * (1-polygonify) +
            polygonify * polygon_rad
    )
        (point[2] > 0) ? 
            [rad*sin(angle), rad*cos(angle), point[2]] : 
            shrinky(point, a, fake_base_height, rad);

function bend(point) = let(c0=0, c1=10, c2=80, c3=150, c4=170, angle=90, bendidx=0)
    point[bendidx] < c1 ? point : point[bendidx] < c2 ?
        let(diff = point - [c1, point[1], point[2]])
            [c1, point[1], point[2]] + [
                cos(angle)*diff[0] + sin(angle)*diff[1],
                cos(angle)*diff[1] - sin(angle)*diff[0],
                diff[2]
            ]: let(
                    corner = [
                        c2,
                        point[1], point[2]
                    ],
                    new_corner = [
                        c1 + cos(angle)*(c2 - c1),
                        -sin(angle)*(c2 - c1),
                        point[2]
                    ],
                    diff = point - corner,
                    angle2=185
               )
                    point[bendidx] < c3 ? new_corner+[
                        cos(angle2)*diff[bendidx] + sin(angle2)*diff[1],
                        cos(angle2)*diff[1] - sin(angle2)*diff[bendidx],
                        diff[2]
                    ]:
                        let(
                            corner = [
                                c3,
                                point[1], point[2]
                            ],
                            new_corner = [
                                c1 + cos(angle)*(c2 - c1) + cos(angle2)* (c3-c2),
                                -sin(angle)*(c2 - c1) - sin(angle2)*(c3-c2),
                                point[2]
                            ],
                            diff = point - corner,
                            angle3=-85
                       )
                            point[bendidx] < c4 ? new_corner + [
                                cos(angle3)*diff[bendidx] + sin(angle3)*diff[1],
                                cos(angle3)*diff[1] - sin(angle3)*diff[bendidx],
                                diff[2]
                            ] : let(
                                    corner = [
                                        c4,
                                        point[1], point[2]
                                    ],
                                    new_corner = [
                                        c1 + cos(angle)*(c2-c1) + cos(angle2)* (c3-c2) + cos(angle3)*(c4-c3),
                                        -sin(angle)*(c2-c1) - sin(angle2)*(c3-c2) - sin(angle3)*(c4-c3),
                                        point[2]
                                    ],
                                    diff = point - corner,
                                    angle4=0
                               )
                            new_corner + [
                                cos(angle4)*diff[bendidx] + sin(angle4)*diff[1],
                                cos(angle4)*diff[1] - sin(angle4)*diff[bendidx],
                                diff[2]
                            ];
                    

function transform(point, radial=true, a, fake_base_height, r) =
    radial ? radialt(point, a, fake_base_height, r) : bend(point);

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

    //echo(t);
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
    l=10,
    t=2
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
            [x_offs + l*sqrt(3)   + offs[0], offs[1], z0 + offs[2]],
            [x_offs + l*sqrt(3)   + offs[0], offs[1], offs[2]],
            [x_offs + l*sqrt(3)/2 + offs[0], offs[1], z0-z1 + offs[2]],
            [x_offs + offs[0], offs[1], offs[2]]
        ];
        for (i = [0:1:len(points)-2]){
            line(
                start=points[i], end=points[i+1],
                t=t, radial=true, r=r, 
                fake_base_height=fake_base_height, 
                $fn=10
            );
        }
    }
}

module wall_hex(x=3, z=6, fake_base_height=100, r=50, l=10, offs=[0, 0, 0], t=2){
    for (i = [0:1:z-1]){
        strip_hex(
            x,
            offs=offs + [l*sqrt(3)/2 * (i%2), 0, l*1.5*i - fake_base_height,],
            flip=(i%2==0),
            r=r,
            fake_base_height=fake_base_height,
            l=l,
            t=t
        );
    }
}

module rotational_slice(x=3, z=6, fake_base_height=100, r=50, l=10, t=2){
    for (i = [0:1:z-1]){
        strip_hex(
            1, //x,
            offs=[l*sqrt(3)/2 * (i%2), 0, l*1.5*i - fake_base_height,],
            flip=(i%2==0),
            r=r,
            fake_base_height=fake_base_height,
            l=l,
            t=t
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
        wall_hex(cn, zn, fake_base_height=fake_base_height, r=r, l=l, t=t);
    }
    else{
        for (i = [0:1:cn-1]){
            rotate([0, 0, i*360/cn])
            rotational_slice(cn, zn, fake_base_height=fake_base_height, r=r, l=l, t=t);
        }
    }
}

//wall_hex(13, 6, l=10, fake_base_height=0);

module pen_pot(t=3){
    cn = 15;
    l = 10;
    base_density=3.15;
    hex_container(l, cn, 120, base_density=base_density, t=t);
    rotate([0, 0, (360/cn)/2])
    hex_container(l, cn, 10, base_density=base_density, t=t);
}

module tweezers_pot(t=3){
    cn = 9;
    l = 10;
    base_density=3.15;
    hex_container(l, cn, 70, base_density=base_density, t=t);
    rotate([0, 0, (360/cn)/2])
    hex_container(l, cn, 10, base_density=base_density, t=t);
}

module test_pot(t=3){
    cn = 3;
    l = 10;
    base_density=3.15;
    hex_container(l, cn, 30, base_density=base_density, t=t);
    rotate([0, 0, (360/cn)/2])
    hex_container(l, cn, 10, base_density=base_density, t=t);
}

//pen_pot(3);
//tweezers_pot(2.5);
test_pot(2.5);
