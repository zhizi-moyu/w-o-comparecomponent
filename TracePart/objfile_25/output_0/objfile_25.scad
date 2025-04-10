
$fn = 100; // Smoothness

// Parameters
coupling_length = 60;
coupling_diameter = 20;
clamp_length = 10;
flex_length = 40;
slot_width = 1.5;
slot_depth = 5;
screw_hole_diameter = 3;
screw_hole_offset = 5;

// Main body
module central_body() {
    difference() {
        cylinder(h = coupling_length, d = coupling_diameter);
        // Axial slot (for clamping)
        translate([0, 0, 0])
            rotate([0, 0, 0])
                cube([slot_width, coupling_diameter, clamp_length + 0.1], center = true);
        translate([0, 0, coupling_length - clamp_length])
            rotate([0, 0, 0])
                cube([slot_width, coupling_diameter, clamp_length + 0.1], center = true);
        // Flexible slots (simplified as curved cuts)
        for (i = [1:3]) {
            rotate([0, 0, i * 60])
                translate([-slot_depth, -slot_width/2, clamp_length + i * 8])
                    cube([slot_depth * 2, slot_width, 8]);
        }
    }
}

// Fastening screws
module fastening_screw(z_pos) {
    translate([coupling_diameter/2 - screw_hole_offset, 0, z_pos])
        rotate([0, 90, 0])
            cylinder(h = coupling_diameter, d = screw_hole_diameter, center = true);
}

// Assembly
difference() {
    central_body();
    // Top screw
    fastening_screw(clamp_length / 2);
    // Bottom screw
    fastening_screw(coupling_length - clamp_length / 2);
}

