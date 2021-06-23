use <MCAD/involute_gears.scad>

difference(){
    bevel_gear (
        number_of_teeth=8, 
        cone_distance=50, 
        face_width=4, 
        outside_circular_pitch=100, 
        pressure_angle=30,
        clearance = 0.2, 
        bore_diameter=0,
        gear_thickness = 2, 
        backlash = 0, 
        involute_facets=0, 
        finish = -1);

    cylinder(10, r1=1.15, $fn=20);

}