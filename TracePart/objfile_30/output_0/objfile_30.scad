
$fn = 100; // Smoothness

// Parameters
shaft_d = 20;
shaft_l = 20;

flange_d = 40;
flange_t = 5;

bolt_r = 2;
bolt_l = 10;
bolt_circle_r = 12;

nut_r = 3;
nut_h = 3;

ring_d = 35;
ring_t = 3;
ring_gap = 1;
ring_count = 4;

// Helper: bolt pattern
module bolt_pattern(z_offset=0) {
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_circle_r * cos(angle);
        y = bolt_circle_r * sin(angle);
        translate([x, y, z_offset])
            cylinder(h = bolt_l, r = bolt_r, center = true);
    }
}

// Helper: nut pattern
module nut_pattern(z_offset=0) {
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_circle_r * cos(angle);
        y = bolt_circle_r * sin(angle);
        translate([x, y, z_offset])
            cylinder(h = nut_h, r = nut_r, center = true);
    }
}

// Input Shaft
module input_shaft() {
    cylinder(h = shaft_l, r = shaft_d/2);
}

// Output Shaft
module output_shaft() {
    cylinder(h = shaft_l, r = shaft_d/2);
}

// Flange Plate
module flange_plate() {
    difference() {
        cylinder(h = flange_t, r = flange_d/2);
        bolt_pattern(z_offset = flange_t/2);
    }
}

// Flexible Ring
module flexible_ring() {
    difference() {
        cylinder(h = ring_t, r = ring_d/2);
        cylinder(h = ring_t + 1, r = shaft_d/2); // center hole
    }
}

// Full Assembly
module coupling() {
    // Input shaft
    translate([0, 0, 0])
        input_shaft();

    // Flange plate 1
    translate([0, 0, shaft_l])
        flange_plate();

    // Bolts and nuts for flange 1
    translate([0, 0, shaft_l + flange_t/2])
        bolt_pattern();

    translate([0, 0, shaft_l + flange_t + ring_count * (ring_t + ring_gap)])
        nut_pattern();

    // Flexible rings
    for (i = [0:ring_count-1]) {
        translate([0, 0, shaft_l + flange_t + i * (ring_t + ring_gap)])
            flexible_ring();
    }

    // Flange plate 2
    translate([0, 0, shaft_l + flange_t + ring_count * (ring_t + ring_gap)])
        flange_plate();

    // Bolts and nuts for flange 2
    translate([0, 0, shaft_l + flange_t + ring_count * (ring_t + ring_gap) + flange_t/2])
        bolt_pattern();

    translate([0, 0, shaft_l + flange_t + ring_count * (ring_t + ring_gap) + flange_t])
        nut_pattern();

    // Output shaft
    translate([0, 0, shaft_l + flange_t + ring_count * (ring_t + ring_gap) + flange_t])
        output_shaft();
}

// Render the model
coupling();

