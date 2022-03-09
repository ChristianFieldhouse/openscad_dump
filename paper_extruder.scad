width = 57;

r = width / (sqrt(2) + PI * 3/2);
t = 1;
h = 2;

tol = 0;

module holey(R=r+t){
    translate([-R/sqrt(2), 0, 0])
    union(){
        intersection() {
            translate([R/sqrt(2), 0, 0]) cylinder(h, R, R, center=true);
            translate([R, 0, 0]) cube([2*R, 2*R, 2*h], center=true);
        }
        intersection() {
            rotate(45, [0, 0, 1]) cube([R, R, h], center=true);
            translate([-R, 0, 0]) cube([2*R, 2*R, 2*h], center=true);
        }
    }
}

module longey(l=0, R=r+t){
    translate([0, l/2, 0]) holey(R);
    translate([0, -l/2, 0]) holey(R);
    translate([R*(1/2 - 1/(2*sqrt(2))), 0, 0]) cube([R*(1 + 1/sqrt(2)), l, h], center=true);
}

module slice(l=width, R=r){
    difference(){
        longey(l, R=R+t);
        longey(l, R=R);    
    }
}

height = 70;
sections = height/h;
maxl = width - 2*r;
for (i = [1:sections]){
    translate([0, 0, h*i]) slice(maxl * (sections - i) / sections, r);
}