x = 30.75;
y = 25;
z = 56;
t = 1.5;

difference(){
    cube([x+t, y+t, z], center=true);
    cube([x, y, z], center=true);
}

