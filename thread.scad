
module slice(t, width){
    rotate(90, [1, 0, 0])
    linear_extrude(height=0.01)
    polygon([
        [-t/2, -width/2],
        [-t/2, width/2],
        [t/2, width/2],
        [t/2, 0]
    ]);
    //cube([t, 0.01, width], center=true);
}

module thread(
    pitch = 3,
    width = 1,
    r = 3,
    t = 1,
    laps = 2,
    steps_per_lap = 20
){
    eps = 0.01;
    for (i = [0:steps_per_lap * laps - 1]){
        hull(){
            translate([0, 0, pitch * i/steps_per_lap])
            rotate(360 * i/steps_per_lap)
            translate([t/2 + r, 0, 0])
            slice(t, width);
                
            translate([0, 0, pitch * (i + 1)/steps_per_lap])
            rotate(360 * (i+1)/steps_per_lap)
            translate([t/2 + r, 0, 0])
            slice(t, width);
        }
    }
}

module inner_thread(
    pitch = 3,
    width = 1,
    r = 3,
    t = 1,
    laps = 2,
    steps_per_lap = 20
){
    eps = 0.01;
    for (i = [0:steps_per_lap * laps - 1]){
        hull(){
            translate([0, 0, pitch * i/steps_per_lap])
            rotate(360 * i/steps_per_lap)
            translate([t/2 + r, 0, 0])
            mirror([1, 0, 0]) slice(t, width);
                
            translate([0, 0, pitch * (i + 1)/steps_per_lap])
            rotate(360 * (i+1)/steps_per_lap)
            translate([t/2 + r, 0, 0])
            mirror([1, 0, 0]) slice(t, width);
        }
    }
}

laps = 6;
t=1;

inner_thread(
    pitch=2,
    width=1,
    r=3+0.3,
    t=t,
    laps=laps,
    steps_per_lap=20
);
difference(){
    translate([0, 0, -0.5]) cylinder(2*laps + 1, 5+0.3, 5+0.3, $fn=20);
    translate([0, 0, -0.5]) cylinder(2*laps + 1, 4+0.3, 4+0.3, $fn=20);
}


translate([12, 0, 0]){
    start = 10;
    translate([0, 0, -t/2]) cylinder(start, 3, 3, $fn=20);
    translate([0, 0, start]){
        thread(
            pitch=2,
            width=1,
            r=3,
            t=t,
            laps=laps,
            steps_per_lap=20
        );
        difference(){
            translate([0, 0, -0.5]) cylinder(2*laps + 1, 3, 3, $fn=20);
            translate([0, 0, -0.5]) cylinder(2*laps + 1, 2, 2, $fn=20);
        }
    }
}