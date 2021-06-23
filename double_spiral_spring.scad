use <spiral.scad>

h = 2;
t = 1;
laps = 3;
grad = 4;
lock_h = 0.3;
handle_h = 2;

union(){
linear_extrude(height=h){
    spiral(width=t, r0=0, laps=laps, grad=grad/360);
    rotate(180){
        spiral(width=t, r0=0, laps=laps, grad=grad/360);
    }
    square([2, 3], center=true);
}

translate([0, 0, h + lock_h/2]){
    cube([2, 3, lock_h], center=true);
}
}
  
translate([grad*(laps) - grad/2, 0, 0])
    cube([(grad/2 + t), 2, 2]);

rotate(180){
translate([grad*(laps) - grad/2, 0, 0])
    cube([(grad/2 + t), 2, 2]);
}

translate([0, 0, h + handle_h/2 + lock_h]){
    cube([2, grad*laps*2, handle_h], center=true);
}
