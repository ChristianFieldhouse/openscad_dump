use <MCAD/regular_shapes.scad>

function transform(point, r=80) = 
    let (
        rad = sqrt(point[0]*point[0] + point[2]*point[2]),
        newrad = rad // todo: logistic function
        )
            point;

module line(
    start=[0, 0, 0],
    end=[1, 0, 0],
    t=2,
    $fn=10
){
    start_ = transform(start);
    //echo(start, start_, fake_base_height, r);
    end_ = transform(end);
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
}

module strip_hex(
    steps=3,
    offs=[0, 0, 0],
    l=10,
    end=false,
    end_tops=false,
    tops=false,
    direction=[1, 0, 0]
){
    z0 = l;
    z1 = z0 + l/2;
    for (j = [0:1:steps-1]){
        x_offs = j * sqrt(3) * l * direction;
        points = [
            [0, 0, 0],
            [0, 0, z0],
            [0, 0, z1 + 0] + l*sqrt(3)/2*direction,
            [0, 0, z0 + 0] +l*sqrt(3)*direction
        ];
        for (i = [0:1:len(points)-2]){
            line(
                x_offs + offs + points[i], x_offs + offs + points[i+1],
                t=2,
                $fn=10
            );
        }
    }
    if (tops){
        for (j = [0:1:steps-2]){
            x_offs = j * sqrt(3) * l * direction;
            points = [
                offs + [l*sqrt(3)/2, 0, 0 - l/2],
                offs + [l*sqrt(3), 0, 0],
                offs + [3*l*sqrt(3)/2, 0, 0 - l/2]
            ];
            for (i = [0:1:len(points)-2]){
                line(
                    x_offs + points[i], x_offs + points[i+1],
                    t=2,
                    $fn=10
                );
            }
        }
    }
    if (end){
        x_offs = steps * sqrt(3) * l * direction;
        line(x_offs + offs + [0, 0, z0], x_offs + offs, t=2, $fn=10);
    }
    if (end_tops){
        line(offs, l*sqrt(3)/2*direction + offs + [0, 0, - l/2],, t=2, $fn=10);
        x_offs = steps * sqrt(3) * l * direction;
        line(x_offs + offs, x_offs + offs + [0, 0, - l/2] - l*sqrt(3)/2*direction, t=2, $fn=10);
    }
}

module wall_hex(n=1, z=1, l=10){
    corners = [
        [0, 0, 0],
        [l*sqrt(3)*n, 0, 0],
        [l*sqrt(3)*(n*1.5 - 0.5), -1.5*(n-1)*l, 0],
        [l*sqrt(3)*(n - 0.5), -3*(n-0.5)*l, 0],
        [l*sqrt(3)/2, -3*(n-0.5)*l, 0],
        [-l*sqrt(3)*(n-1)*0.5, -1.5*(n-1)*l, 0],
    ];
    for (i = [0:1:z-1]){
        for (j = [0:1:5]){
            strip_hex(
                n - (j%2),
                offs=[-l*sqrt(3)/2 * (i%2), 0, l*1.5*i] + corners[j],
                l=l,
                direction=[cos(-j*60), sin(-j*60), 0]
            );
        }
    }
}

module floor_hex(n=7, z=1, l=10, point_diff=0.3){
    rotate([90, 0, 0])
    for (i = [0:1:2*n-2]){
        let(num_hexes = n + min(i, 2*n - 2 -i) - ((i==0 || i == n-1) || (i == 2*n-2) ? 2 : 0))
        strip_hex(
            num_hexes,
            offs=[-l*sqrt(3)/2 * num_hexes, 0, l*(1.5*i - 1.5*(n-1) - 0.5)],
            l=l,
            end=true,
            end_tops=(i < n + 1),
            tops=(i < 2) // todo: wasteful :)
        );
    }
    for (angle = [0:60:360]){
        x_vec=[sqrt(3)*l*cos(angle), sqrt(3)*l*sin(angle), 0];
        y_vec=[-l*sin(angle), l*cos(angle), 0];
        for (y_sgn=[1, -1])
            line((n-1)*x_vec + y_sgn*y_vec, (n-0.5 - point_diff)*x_vec);
        corner = (n-0.5 - point_diff)*x_vec;
        next_hex_corner = (n-1)*x_vec + 2*y_vec;
        prev_hex_corner = (n-1)*x_vec - 2*y_vec;
        //line(corner, corner + [0, 0, l]);
        hex_step = -x_vec/2 - 1.5*y_vec;
        points = [
            next_hex_corner,
            corner,
            for (i = [0:1:n-3]) prev_hex_corner + i*hex_step
        ];
        odd_points = [
            for (j = [0:1:len(points)-2]) (points[j] + points[j+1])/2,
            ([
                points[0].x*cos(60) + points[0].y*sin(60),
                points[0].y*cos(60) - points[0].x*sin(60), points[0].z
            ] + [
                points[1].x*cos(60) + points[1].y*sin(60),
                points[1].y*cos(60) - points[1].x*sin(60), points[1].z
            ])/2 
        ];
        for (k = [0:1:z-1]){
            let(
                fpts = k%2==0? points : odd_points,
                tpts = k%2==0? odd_points : points,
                z_offs = [0, 0, 1.5*l*k]
            )
            if (k%2){
                for (j = [0:1:len(fpts)-2]){
                    line(z_offs + fpts[j], z_offs + fpts[j] + [0, 0, l]);
                    line(z_offs + fpts[j] + [0, 0, l], z_offs + tpts[j+1] + [0, 0, l*1.5]);
                    line(z_offs + tpts[j+1] + [0, 0, l*1.5], z_offs + fpts[j+1] + [0, 0, l]);
                    line(z_offs + fpts[j+1] + [0, 0, l], z_offs + fpts[j+1]);
                }
            }
            else{
                for (j = [0:1:len(fpts)-2]){
                    line(z_offs + fpts[j], z_offs + fpts[j] + [0, 0, l]);
                    line(z_offs + fpts[j] + [0, 0, l], z_offs + tpts[j] + [0, 0, l*1.5]);
                    line(z_offs + tpts[j] + [0, 0, l*1.5], z_offs + fpts[j+1] + [0, 0, l]);
                    line(z_offs + fpts[j+1] + [0, 0, l], z_offs + fpts[j+1]);
                }
            }
        }
    }
}

N = 5;
floor_hex(n=N, z=6);
//wall_hex(n=N, z=1);
