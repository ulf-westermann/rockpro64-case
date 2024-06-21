$fn = 120;

pcb_hole_distance_x = 119;
pcb_hole_distance_y = 71;

pcb_border_from_holes = 6;
extra_front_space = 17;

len_x = pcb_hole_distance_x + 2 * pcb_border_from_holes;
len_y = pcb_hole_distance_y + pcb_border_from_holes + extra_front_space;
border_shrink = 0.5;
thickness = 3;

hole_distance_from_edge = 5;


difference() {
    translate([border_shrink / 2, border_shrink / 2, 0])
        cube([len_x - border_shrink, len_y - border_shrink, thickness]);
    
    translate([hole_distance_from_edge, hole_distance_from_edge, -1])
        cylinder(h = thickness + 2, d = 3);

    translate([len_x - hole_distance_from_edge, hole_distance_from_edge, -1])
        cylinder(h = thickness + 2, d = 3);

    translate([hole_distance_from_edge, len_y - hole_distance_from_edge, -1])
        cylinder(h = thickness + 2, d = 3);

    translate([len_x - hole_distance_from_edge, len_y - hole_distance_from_edge, -1])
        cylinder(h = thickness + 2, d = 3);

    for (i = [-11 * thickness : 2 * thickness : 11 * thickness])
        translate([(len_x - 80) / 2, i - (thickness / 2) + (len_y / 2) , -1])
            #cube([80, thickness, thickness + 2]);
}
