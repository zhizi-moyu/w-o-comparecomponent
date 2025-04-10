
// Parameters
base_length = 60;
base_width = 60;
base_thickness = 6;
vertical_height = 40;
hole_radius = 12;
corner_hole_radius = 3;
slot_width = 6;
slot_height = 20;
slot_offset_x = 15;
slot_spacing = 30;

// Base Plate
difference() {
    union() {
        // Horizontal base
        cube([base_length, base_width, base_thickness]);

        // Vertical plate
        translate([0, 0, base_thickness])
            cube([base_thickness, base_width, vertical_height]);
    }

    // Central hole
    translate([base_length/2, base_width/2, -1])
        cylinder(h = base_thickness + 2, r = hole_radius, $fn=64);

    // Corner holes
    for (x = [10, base_length - 10])
        for (y = [10, base_width - 10])
            translate([x, y, -1])
                cylinder(h = base_thickness + 2, r = corner_hole_radius, $fn=32);

    // Vertical slots
    for (y = [base_width/2 - slot_spacing/2, base_width/2 + slot_spacing/2])
        translate([-1, y - slot_width/2, base_thickness + (vertical_height - slot_height)/2])
            rotate([0, 90, 0])
                linear_extrude(height = base_thickness + 2)
                    offset(r = 1)
                        square([slot_height, slot_width], center = false);
}

