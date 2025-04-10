
// Parameters
shaft_diameter = 20;
shaft_length = 40;
bore_diameter = 8;
screw_hole_diameter = 6;
screw_hole_depth = 10;
screw_offset = 10; // distance from center to screw holes
hex_radius = 3.5; // radius of hex socket
hex_depth = 4;

// Main shaft
difference() {
    // Outer cylinder
    cylinder(h = shaft_length, d = shaft_diameter, $fn = 100);

    // Central bore
    translate([0, 0, 0])
        cylinder(h = shaft_length, d = bore_diameter, $fn = 100);

    // Side screw holes (2x)
    for (i = [-1, 1]) {
        translate([i * screw_offset, shaft_diameter/2 + 0.1, shaft_length/2])
            rotate([90, 0, 0])
                cylinder(h = screw_hole_depth, d = screw_hole_diameter, $fn = 100);

        // Hex socket for screw
        translate([i * screw_offset, shaft_diameter/2 + 0.1, shaft_length/2])
            rotate([90, 0, 0])
                cylinder(h = hex_depth, r = hex_radius, $fn = 6);
    }
}

