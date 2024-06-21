$fn = 120;

pcb_hole_distance_x = 119;
pcb_hole_distance_y = 71;

pcb_border_from_holes = 6;
extra_front_space = 17;

len_x = pcb_hole_distance_x + 2 * pcb_border_from_holes;
len_y = pcb_hole_distance_y + pcb_border_from_holes + extra_front_space;
thickness = 3;

bottom_mount_len_z = 8;
len_z = 60 + 2 * thickness + bottom_mount_len_z;


bottom_plate();
side_walls();
bottom_mounts();
top_mounts();


module bottom_plate() {
    translate([0, 0, -thickness])
        cube([len_x, len_y, thickness]);
}


module side_walls() {
    difference() {
        translate([-thickness, -thickness, -thickness])
            linear_extrude(len_z)
                difference() {
                    square([len_x + 2 * thickness, len_y + 2 * thickness]);
                    translate([thickness, thickness, 0])
                        square([len_x, len_y]);
                }
        
        #translate([10, -thickness - 1, 0])
            cube([len_x - 20, thickness + 2, 2 * bottom_mount_len_z]);  // sd card side

        #translate([-thickness - 1, len_y - pcb_hole_distance_y - 2, 0])
            cube([thickness + 2, pcb_hole_distance_y - 8, bottom_mount_len_z + 16]);  // ethernet side

        #translate([len_x - 1, len_y - pcb_hole_distance_y - 2, 0])
            cube([thickness + 2, pcb_hole_distance_y - 8, bottom_mount_len_z + 20]);  // usb side
    }
}


module bottom_mounts() {
    rear_mounts_len_y = 8;
    rear_left_hole_pos = [pcb_border_from_holes, len_y - pcb_border_from_holes, 0];

    translate(rear_left_hole_pos)
        difference() {
            translate([-1, 1, bottom_mount_len_z / 2])
                cube([10, 10, 8], center = true);
            cylinder(h = bottom_mount_len_z + 1, d = 2);
        }

    rear_mounts_len_x = 8;
    rear_right_hole_pos = [rear_left_hole_pos[0] + pcb_hole_distance_x, len_y - pcb_border_from_holes, 0];

    translate(rear_right_hole_pos)
        difference() {
            translate([1, 1, bottom_mount_len_z / 2])
                cube([10, 10, 8], center = true);
            cylinder(h = bottom_mount_len_z + 1, d = 2);
        }

    front_left_hole_pos = [rear_left_hole_pos[0], rear_left_hole_pos[1] - pcb_hole_distance_y, 0];

    translate(front_left_hole_pos)
        difference() {
            translate([-1, -6.5, bottom_mount_len_z / 2])
                cube([10, 21, 8], center = true);
            cylinder(h = bottom_mount_len_z + 1, d = 2);
        }

    front_right_hole_pos = [rear_right_hole_pos[0], rear_right_hole_pos[1] - pcb_hole_distance_y, 0];

    translate(front_right_hole_pos)
        difference() {
            translate([1, -6.5, bottom_mount_len_z / 2])
                cube([10, 21, 8], center = true);
            cylinder(h = bottom_mount_len_z + 1, d = 2);
        }
}


module top_mounts() {
    mount_len_z = 8;
    mount_len_xy = 10;

    // frame
    translate([0, 0, len_z - 3 * thickness])
        linear_extrude(3)
            difference() {
                square([len_x, len_y]);

                translate([thickness, thickness, 0])
                    square([len_x - 2 * thickness, len_y - 2 * thickness]);
                }

    // front left
    translate([0, 0, len_z - mount_len_z - 2 * thickness])
        difference() {
            cube([10, 10, mount_len_z]);
            translate([5, 5, 0])
                cylinder(h = mount_len_z + 1, d = 2);
        }

    // rear left
    translate([0, len_y - mount_len_xy, len_z - mount_len_z - 2 * thickness])
        difference() {
            cube([10, 10, mount_len_z]);
            translate([5, 5, 0])
                cylinder(h = mount_len_z + 1, d = 2);
        }

    // front right
    translate([len_x - mount_len_xy, 0, len_z - mount_len_z - 2 * thickness])
        difference() {
            cube([10, 10, mount_len_z]);
            translate([5, 5, 0])
                cylinder(h = mount_len_z + 1, d = 2);
        }

    // rear right
    translate([len_x - mount_len_xy, len_y - mount_len_xy, len_z - mount_len_z - 2 * thickness])
        difference() {
            cube([10, 10, mount_len_z]);
            translate([5, 5, 0])
                cylinder(h = mount_len_z + 1, d = 2);
        }
}


//module quadratic_mount(hole_position, length, height) {
//    translate([hole_position[0] - length / 2, hole_position[1] - length / 2, hole_position[2]])  // center mount at hole_position
//        difference() {
//            cube([length, length, height]);
//            #translate([length / 2, length / 2, thickness])
//                cylinder(h = height - thickness + 1, d = 2);
//        }
//}

/*
module bottom_mount(position_from_center, height, rotate_angle) {
    translate([position_from_center[0], position_from_center[1], height/2+position_from_center[2]]) {
        rotate(rotate_angle) {
            difference() {
                translate([2, 2, 0]) {
                    cube([12, 12, height], center=true);
                }
                #cylinder(h=height, d=2, center=true);
            }
        }
    }
*/

/*
module top_mount(position_from_center, height, rotate_angle) {
    translate([position_from_center[0], position_from_center[1], height/2+position_from_center[2]])
        rotate(rotate_angle)
            translate([-5, -5, -height])
                difference() {
                    cube([10, 10, height], center=true);
                    #cylinder(h=height, d=2, center=true);
                }
}
*/
