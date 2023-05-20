use <MCAD/regular_shapes.scad>

module line(a, b, r=1){
    hull(){
        translate(a) sphere(r);
        translate(b) sphere(r);
    };
}

r1=6;
lobes=7;
packing=2;
r0=(lobes/packing + 1)*r1;
r1_stick=r0 - r1 - 7;
revs=packing;
n = 600;

function angle_to_point(angle, r0=r0, r1=r1, r1_stick=r1_stick) = let(
        sub_angle=angle*r0/r1,
        stick0=(r0-r1)*[cos(angle), sin(angle), 0],
        stick1=r1_stick*[cos(sub_angle), sin(sub_angle), 0]
    )
        stick0 + stick1;

function angle_to_height(angle, r0=r0, r1=r1, r1_stick=r1_stick) = let(
        flat_point=angle_to_point(angle, r0, r1, r1_stick),
        rad=norm(flat_point),
        const_rad=r0 + r1_stick - r1,
        h=(const_rad-rad)/const_rad,
        height=const_rad * (h + pow(h, 7))
    )
        const_rad * flat_point/rad + [0, 0, height];

module flat_roulette(){
    for (angle=[0:360/n:360*revs]){
        next_angle = angle + 360/n;
        line(angle_to_point(angle), angle_to_point(next_angle));
    }
}

module height_roulette(){
    for (angle=[0:360/n:360*revs]){
        next_angle = angle + 360/n;
        line(angle_to_height(angle), angle_to_height(next_angle));
    }
}

flat_roulette();
height_roulette();
