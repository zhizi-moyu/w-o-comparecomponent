
// Parameters
coupling_diameter = 20;
coupling_length = 30;
shaft_hole_diameter = 6;
set_screw_diameter = 3;
set_screw_depth = 5;
helical_cut_width = 1.5;
helical_cut_spacing = 3;
helical_cut_count = 5;

// Main coupling body
module coupling_body() {
    difference() {
        // Outer cylinder
        cylinder(h = coupling_length, d = coupling_diameter, $fn = 100);

        // Shaft holes on both ends
        translate([0, 0, -1])
            cylinder(h = coupling_length + 2, d = shaft_hole_diameter, $fn = 100);

        // Helical cuts (approximated with rotated slots)
        for (i = [0 : helical_cut_count - 1]) {
            rotate([0, 0, i * 360 / helical_cut_count])
                translate([0, 0, i * helical_cut_spacing])
                    rotate([90, 0, 0])
                        translate([-coupling_diameter/2, -helical_cut_width/2, 0])
                            cube([coupling_diameter, helical_cut_width, coupling_length], center = false);
        }
    }
}

// Set screw holes
module set_screw_hole(angle_deg, z_pos) {
    rotate([0, 0, angle_deg])
        translate([coupling_diameter/2 - 1, 0, z_pos])
            rotate([0, 90, 0])
                cylinder(h = set_screw_depth, d = set_screw_diameter, $fn = 50);
}

// Full model
difference() {
    coupling_body();

    // Set screw holes
    set_screw_hole(0, 5);
    set_screw_hole(120, 15);
    set_screw_hole(240, 25);
}

