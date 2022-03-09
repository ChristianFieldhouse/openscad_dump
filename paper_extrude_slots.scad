use <MCAD/regular_shapes.scad>

width = 60;
t = 1;
tz = 2;
r = 3;
theta0 = 90;

$fn = 20;

module bend(theta=theta0, r=r){
    difference(){
        union(){
            cylinder_tube(tz, r + t/2 + t, t, center=true);
            cylinder_tube(tz, r - t/2, t, center=true);
        }
        rotate(theta/2 - 90)
        translate([-2*r, 0, 0])
        cube([4*r, 4*r, 2*t], center=true);
        rotate(90 - theta/2)
        translate([-2*r, 0, 0])
        cube([4*r, 4*r, 2*t], center=true);
    }
    translate([r+2.5, 0, 0])
    difference(){
        cube([4, 5, tz], center=true);
        cube([2, 3, tz], center=true);
    }
}

module sides(theta=theta0/2, withend=false, l=width/4, r=r){
    rotate(theta){
        translate([r + t, l/2, 0])
        cube([t, l, tz], center=true);

        translate([r - t, l/2, 0])
        cube([t, l, tz], center=true);
        
        if(withend){
            translate([r, l + t/2, 0])
            cube([3*t, t, tz], center=true);
        }
    }
}

module half_thing(ratio=1, theta=theta0, r=r){
    bend(r=r, theta=theta);
    length = width / 2 - 1.5 * r * theta * PI / 180;
    l1 = length * ratio / 2;
    l2 = length * (2 - ratio) / 2;
    
    sides(l=l1, r=r, theta=theta/2);
    
    translate([-l1 * sin(theta/2) + 2 * r * cos(theta/2), 2 * r * sin(theta/2) + l1 * cos(theta/2), 0]){
        rotate(180)
        bend(r=r, theta=theta);
        translate([-2 * r * cos(theta/2), 2 * r * sin(theta/2), 0])
        sides(theta=-theta/2, withend=true, l=l2, r=r);
    }
}

module whole_thing(theta=theta0, r=r){
    half_thing(theta=theta, r=r);
    mirror([0, 1, 0]){
        half_thing(theta=theta, r=r);
    }
}

slots = true;
if (slots){
whole_thing(theta=0);

translate([0.9*width/4, 0, 0])
whole_thing(theta=50);

translate([1.8*width/4, 0, 0])
whole_thing(theta=90);

translate([3*width/4, 0, 0])
whole_thing(theta=120, r=1);

translate([4.7*width/4, 0, 0])
whole_thing(theta=170, r=1);
}

//cube([2.2, 100, 1.6]);