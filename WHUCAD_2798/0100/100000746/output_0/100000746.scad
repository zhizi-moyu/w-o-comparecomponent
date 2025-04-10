
// Parameters
bracket_width = 40;     // Width of the U-shape
bracket_height = 50;    // Height of the U-shape
thickness = 4;          // Thickness of the bracket (cross-section)
radius = bracket_width / 2; // Radius for the top arc

module u_shaped_bracket() {
    difference() {
        // Outer shape
        union() {
            // Bottom horizontal bar
            cube([bracket_width, thickness, thickness]);

            // Left vertical bar
            translate([0, 0, 0])
                cube([thickness, thickness, bracket_height]);

            // Right vertical bar
            translate([bracket_width - thickness, 0, 0])
                cube([thickness, thickness, bracket_height]);

            // Top arc (semi-cylinder)
            translate([thickness, 0, bracket_height - thickness])
                rotate([90, 0, 0])
                    linear_extrude(height = thickness)
                        offset(r = thickness / 2)
                            difference() {
                                circle(r = radius);
                                circle(r = radius - thickness);
                            }
        }
    }
}

// Call the module
u_shaped_bracket();

