$fn = 20;

s = 2;

handle_l = 50;
handle_r = 3;

neck_r = 2;
neck_l = 12;

tip_r = 2.5;
tip_l = 7;
tip_h = 2.5;

hook_r = 1;
hook_l = 4.5;
hook_h = 3;

module base(){translate([-handle_l, 0, 0]) sphere(handle_r);}
module shoulder(){sphere(handle_r);}
module neck(){translate([neck_l, 0, 0]) sphere(neck_r);}
module jaw(w=1/3){
    translate([neck_l + tip_l, tip_r*w, tip_h - tip_r/2])
    sphere(tip_r/2);
    translate([neck_l + tip_l, -tip_r*w, tip_h - tip_r/2])
    sphere(tip_r/2);
}
module tip(){translate([neck_l + tip_l, 0, tip_h]) sphere(tip_r);}
module post_tip(w=1/3){
    translate([neck_l + tip_l, tip_r*w, tip_h + tip_r/2])
    sphere(tip_r/2);
    translate([neck_l + tip_l, -tip_r*w, tip_h + tip_r/2])
    sphere(tip_r/2);
}
module hook(){
    translate([neck_l + tip_l - hook_l, 0, tip_h + hook_h])
    sphere(hook_r);
}

module all(){
    hull(){base(); shoulder();}
    hull(){shoulder(); neck();}
    hull(){neck(); jaw();}
    hull(){jaw(); tip();}
    hull(){tip(); post_tip();}
    hull(){post_tip(); hook();}
}

scale([s, s, s]){
    all();
}