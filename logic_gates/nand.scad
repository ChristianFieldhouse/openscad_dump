use <MCAD/regular_shapes.scad>

w = 30;
l = 35;
h = 10;

r = w/2;
r0 = 5;
not_r = w/6;
not_overlap = 0.1;

module hemisphere(r=r){
    intersection(){
        sphere(r, center=true);
        translate([0, 0, 1.5*r])
        cube([3*r, 3*r, 3*r], center=true);
    }
}

module hemitorus(r=r, r0=r0){
    intersection(){
        rotate([90, 0, 0])
        torus2(r-r0, r0);
        translate([0, 0, 1.5*r])
        cube([3*r, 3*r, 3*r], center=true);
    }
}

hull(){
    translate([0, (l-r)/2, 0])
    cube([w, l-r-r0, h], center=true);
    cylinder(h, r, r, center=true);


    translate([0, 0, h/2])
    scale([1, 1, 0.5])
    {
        translate([0, 0, 0])
        hemisphere();
        translate([0, l-r, 0])
        scale([1, 1, 1])
        hemitorus();
    }
    
    translate([0, l-r, -h/2])
    scale([1, 1, 0.5])
    hemitorus();
}

translate([0, -r - not_r*(1-not_overlap), 0])
cylinder(h, not_r, not_r, center=true);
translate([0, -r-not_r*(1-not_overlap), h/2])
hemisphere(not_r);
