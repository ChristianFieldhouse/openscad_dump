use <MCAD/involute_gears.scad>
use <pointy_polygon.scad>

R = 60;
r = 0;
a_r = 3;
t = 2;
h = 3;

tol = 0.2;

axil_span = 60;
grip_t = 1;
grip_length = 30;

spokes = 6;

res = 36;

pitch = 230;
gear_r =  26.5;
teeth = round(gear_r * 360/pitch);
gear_h = 5;

wheel = false;
if (wheel){
linear_extrude(height=h){
    difference(){
        pointy(verts=120, $fn=680, k=3, g=10, rad=R + 3);
        circle(R-t, $fn=res);
    }
    for (i = [0:spokes-1]){
        spoke_l = R - r - t/2;
        rotate(i * 360 / spokes){
            translate([spoke_l / 2 + r, 0]){
                square([spoke_l, t], center=true);
            }
        }
    }
}
linear_extrude(height=axil_span/2 + t){
    circle(a_r, $fn=res);
}
}

grip_tol = 0.1;
grip = true;
if(grip){
translate([0, 0, axil_span/2]){
    linear_extrude(height=grip_length, center=true){
        difference(){
            circle(a_r + grip_tol + grip_t, $fn=res);
            circle(a_r + grip_tol, $fn=res);
        }
    }
}
}

gear = false;
if(gear && wheel){
translate([0, 0, h])
difference(){
    bevel_gear (
        number_of_teeth=teeth, 
        cone_distance=70, 
        face_width=gear_h, 
        outside_circular_pitch=pitch, 
        pressure_angle=30,
        clearance = 0.2, 
        bore_diameter=0,
        gear_thickness = 2, 
        backlash = 0, 
        involute_facets=0, 
        finish = -1);

    cylinder(10, r1=gear_r - 2*t, r2=gear_r - 2*t, $fn=20);

}
translate([0, 0, h])
linear_extrude(height=gear_h)
for (i = [0:spokes-1]){
    gea_r = gear_r - 2*t;
    rotate(i * 360 / spokes){
        translate([gea_r/2, 0]){
            square([gea_r, t], center=true);
        }
    }
}
}