
hs = [10, 10, 15];
cumulative_hs = [0, hs[0], hs[0]+hs[1]];
rs = [5, 5, 20, 0];

for (i = [0:len(hs)]){
    translate([0, 0, cumulative_hs[i]])
    cylinder(hs[i], rs[i], rs[i + 1]);
}