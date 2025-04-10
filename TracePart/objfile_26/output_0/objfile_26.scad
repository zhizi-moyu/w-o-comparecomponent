
// Parameters
shaft_length = 100;
shaft_radius_main = 8;
shaft_radius_ends = 6;
bulge_radius = 10;
bulge_length = 20;
end_section_length = 20;
groove_depth = 1;
groove_width = 2;
pin_radius = 1.5;
pin_length = 12;
key_slot_width = 3;
key_slot_depth = 2;
key_slot_length = 10;

// Central Shaft
module central_shaft() {
    union() {
        // Left end
        translate([0, 0, 0])
            cylinder(h = end_section_length, r = shaft_radius_ends, $fn=100);
        
        // Middle section
        translate([0, 0, end_section_length])
            cylinder(h = (shaft_length - 2 * end_section_length - bulge_length) / 2, r = shaft_radius_main, $fn=100);
        
        // Bulge
        translate([0, 0, (shaft_length - bulge_length) / 2])
            cylinder(h = bulge_length, r = bulge_radius, $fn=100);
        
        // Right middle section
        translate([0, 0, shaft_length - end_section_length - (shaft_length - 2 * end_section_length - bulge_length) / 2])
            cylinder(h = (shaft_length - 2 * end_section_length - bulge_length) / 2, r = shaft_radius_main, $fn=100);
        
        // Right end
        translate([0, 0, shaft_length - end_section_length])
            cylinder(h = end_section_length, r = shaft_radius_ends, $fn=100);
    }
}

// Retaining Ring Groove
module retaining_ring_groove(z_pos) {
    difference() {
        cylinder(h = groove_width, r = shaft_radius_ends + 0.1, $fn=100);
        translate([0, 0, -0.1])
            cylinder(h = groove_width + 0.2, r = shaft_radius_ends - groove_depth, $fn=100);
    }
    translate([0, 0, z_pos])
        difference() {
            cylinder(h = groove_width, r = shaft_radius_ends + 0.1, $fn=100);
            translate([0, 0, -0.1])
                cylinder(h = groove_width + 0.2, r = shaft_radius_ends - groove_depth, $fn=100);
        }
}

// Groove Pin
module groove_pin(z_pos) {
    rotate([90, 0, 0])
        translate([-pin_length/2, 0, z_pos])
            cylinder(h = pin_length, r = pin_radius, $fn=50);
}

// Key Slot
module key_slot(z_pos) {
    translate([-key_slot_width/2, shaft_radius_ends - key_slot_depth, z_pos])
        cube([key_slot_width, key_slot_depth, key_slot_length]);
}

// Full Assembly
module flexible_coupling() {
    union() {
        central_shaft();
        
        // Left end features
        translate([0, 0, 2])
            retaining_ring_groove(0);
        groove_pin(10);
        key_slot(0);
        
        // Right end features
        translate([0, 0, shaft_length - end_section_length + 2])
            retaining_ring_groove(0);
        groove_pin(shaft_length - 10);
        key_slot(shaft_length - key_slot_length);
    }
}

flexible_coupling();

