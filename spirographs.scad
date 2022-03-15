use <MCAD/regular_shapes.scad>

pen_r = 8.15/2;

module tooth_stencil(point_w=0.3, length=1.5, base_w=1.2){
    polygon([
        [0, -point_w/2],
        [0, point_w/2],
        [length, base_w/2],
        [length, -base_w/2]
    ]);
}

module tooth_stencil_3d(point_w=0.3, length=1.5, base_w=1.2){
    linear_extrude(height=0.01){
        tooth_stencil(point_w=point_w, length=length, base_w=base_w);
    }
}

module tooth(overhang=0.5, point_w=0.3, length=1.5, base_w=1.2, height=1){
    hull(){
        tooth_stencil_3d(point_w=point_w, length=length, base_w=base_w);
        translate([-overhang, 0, height])
        tooth_stencil_3d(
            point_w=point_w * (overhang+length)/length,
            length=length + overhang,
            base_w=base_w * (overhang+length)/length
        );
    }
}

module outer_cog(pitch=2.5, tooth_count=50, height=3, length=1.5, pad=3){
    circumference = pitch*tooth_count;
    radius = circumference/PI;
    pitch_degrees = 2*atan(pitch/(2*radius));
    for (angle=[0:pitch_degrees:360]){
        rotate(angle)
        translate([radius, 0, 0]) tooth(height=height, length=length);
    }
    cylinder_tube(height, radius + length + pad, pad);
}

module inner_cog(pitch=2.5, tooth_count=20, height=3, length=1.5, pad=1, bias=0.5){
    circumference = pitch*tooth_count;
    radius = circumference/PI;
    pitch_degrees = 2*atan(pitch/(2*radius));
    for (angle=[0:pitch_degrees:360]){
        rotate(angle)
        translate([-length-radius, 0, height])
        scale([1, 1, -1])
        tooth(height=height, length=length);
    }
    pen_hole_height = 15;
    cylinder_tube(height, radius+0.3, pad);
    bias = 0.5;
    hull(){
        translate([0, (radius*(1+bias)+pen_r)/2, height/2])
        cube([1, radius*(1-bias)-pen_r, height], center=true);
        eps=1;
        translate([0, pen_r + eps/2 + bias*radius, pen_hole_height - height/2])
        cube([1, eps, height], center=true);
    }
    hull(){
        translate([0, -(radius*(1-bias)+pen_r)/2, height/2])
        cube([1, radius*(1+bias)-pen_r, height], center=true);
        eps=1;
        translate([0, -pen_r - eps/2 + bias*radius, pen_hole_height - height/2])
        cube([1, eps, height], center=true);
    }
    translate([0, bias*radius, 0])
    cylinder_tube(pen_hole_height, pen_r+pad, pad);
}

outer_cog(tooth_count=40);
inner_cog(tooth_count=30);
