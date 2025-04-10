
$fn = 100; // Smoothness

// Parameters
coupling_diameter = 30;
coupling_length = 40;
half_length = coupling_length / 2;
bore_diameter = 10;
bolt_hole_diameter = 5;
bolt_head_diameter = 8;
bolt_head_depth = 4;
slot_width = 2;
slot_depth = 10;
slot_offset = 5;

// Main assembly
module coupling() {
    union() {
        translate([0, 0, -half_length])
            coupling_half(true);  // Left half
        translate([0, 0, 0])
            coupling_half(false); // Right half
    }
}

// Coupling half
module coupling_half(is_left) {
    difference() {
        // Main body
        cylinder(h = half_length, d = coupling_diameter, center = false);

        // Bore
        translate([0, 0, 0])
            cylinder(h = half_length, d = bore_diameter, center = false);

        // Clamping slot
        translate([-slot_width/2, -coupling_diameter/2, half_length - slot_depth])
            cube([slot_width, coupling_diameter, slot_depth]);

        // Bolt hole
        translate([0, 0, half_length - 10])
            rotate([90, 0, 0])
                cylinder(h = coupling_diameter, d = bolt_hole_diameter, center = true);

        // Bolt head recess (only on right half)
        if (!is_left) {
            translate([0, 0, half_length - 10])
                rotate([90, 0, 0])
                    cylinder(h = bolt_head_depth, d = bolt_head_diameter, center = true);
        }
    }
}

// Render the full coupling
coupling();

