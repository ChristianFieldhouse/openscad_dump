use <MCAD/regular_shapes.scad>

module hemisphere(r=1){
    intersection(){
        sphere(r);
        translate([0, 0, r/2])
        cube([2*r, 2*r, r], center=true);
    }
}

module smooth_hemi(r=1, smooth_r=0.1){
    hull(){
        hemisphere(r);
        torus2(r-smooth_r, smooth_r);
    }
}

module eye(r=8, h=5, stem_l=8, stem_r=1.5, smooth_r=2, $fn=40){
    scale([1, 1, h/(r+smooth_r)]){
        smooth_hemi(r, smooth_r);
    }
    translate([0, 0, -stem_l/2])
    cylinder(stem_l, stem_r, stem_r, center=true);
}

eye();

module stop(stem_r=1.5, t=1){
    torus2(stem_r + t, t);
}

translate([12, 0, 0])
stop($fn=30);

module nose(
    r_top=6,
    r_bottom=4,
    width=16,
    height=15,
    h=5,
    stem_l=8,
    stem_r=1.5,
    smooth_r=2,
    $fn=40
){
    y_translate = (height - r_top - r_bottom);
    top_weight = r_top * r_top * 2 / (r_top * r_top * 2 + r_bottom * r_bottom);
    scale([1, 1, h/(r_top+smooth_r)]){
        hull(){
            translate([width/2 - r_top, y_translate * (1 - top_weight)])
            smooth_hemi(r_top, smooth_r);
            translate([-width/2 + r_top, y_translate * (1 - top_weight)])
            smooth_hemi(r_top, smooth_r);
            translate([0, -y_translate * (top_weight)])
            smooth_hemi(r_bottom, smooth_r);
        }
    }

    translate([0, 0, -stem_l/2])
    cylinder(stem_l, stem_r, stem_r, center=true);
}

translate([-24, 0, 0])
nose();