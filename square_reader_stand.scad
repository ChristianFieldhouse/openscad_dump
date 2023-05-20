px = 83.2;
py = 9.6;
pz = 25;
p_overhang = 7;
base = 100;

phone_h = 160;

angle = 20;

t = 1;

module slanted_slot(
    px=px, py=py, pz=pz,
    p_overhang=p_overhang,
    angle=angle, base=base
){
    difference(){
        rotate([angle, 0, 0])
        translate([0, (py + 2*t)/2, (pz + t)/2])
        difference(){
            translate([0, 0, -base/2])
            cube([px + 2*t, py + 2*t, pz + t + base], center=true);
            translate([0, 0, t/2])
            cube([px, py, pz], center=true);
            translate([0, t, t/2])
            cube([px - 2*p_overhang, py, pz], center=true);
        }
        translate([0, 0, -base/2])
        cube([base, base, base], center=true);
    }
}

slanted_slot();
translate([-(px + 2*t)/2, -phone_h*sin(angle), 0])
cube([px + 2*t, py/cos(angle) + phone_h*sin(angle), t]);

module rib(){
    rotate([0, 0, -90])
    rotate([90, 0, 0])
    linear_extrude(height=t){
    polygon([
        [0, 0],
        [pz * sin(angle), pz * cos(angle)],
        [30, 0]
    ]);
    }
}
rib();
translate([px/2, 0, 0])
rib();
translate([-px/2, 0, 0])
rib();

sqx = 66;
sqy = 10;

translate([-(px + sqx)/2, 0, 0])
slanted_slot(px=sqx, py=sqy, pz=pz);