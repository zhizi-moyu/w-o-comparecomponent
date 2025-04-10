$fn=100;

// Parameters
coupling_d = 20;
coupling_l = 40;
clamp_l = 6;
bolt_d = 3;
bolt_offset = 6;
helical_turns = 4;
helical_gap = 2;
helical_depth = 3;

// Main assembly
module flexible_coupling() {
    // Left clamp
    translate([0, 0, 0])
        end_clamp();

    // Helical body
    translate([0, 0, clamp_l])
        helical_body();

    // Right clamp
    translate([0, 0, coupling_l - clamp_l])
        end_clamp();
}

// End clamp with bolt holes
module end_clamp() {
    difference() {
        cylinder(h=clamp_l, d=coupling_d);
        // Shaft hole
        translate([0, 0, -1])
            cylinder(h=clamp_l + 2, d=6);
        // Bolt holes
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([bolt_offset, 0, clamp_l/2])
                    rotate([90, 0, 0])
                        cylinder(h=clamp_l + 2, d=bolt_d);
        }
        // Slit
        translate([-coupling_d/2, -1, 0])
            cube([coupling_d, 2, clamp_l]);
    }
}

// Helical flexible body approximation
module helical_body() {
    difference() {
        cylinder(h=coupling_l - 2*clamp_l, d=coupling_d);
        for (i = [0:helical_turns-1]) {
            rotate([0, 0, i*360/helical_turns])
                translate([0, 0, i*(coupling_l - 2*clamp_l)/helical_turns])
                    rotate([0, 90, 0])
                        translate([-coupling_d/2, -helical_depth/2, 0])
                            cube([coupling_d, helical_depth, helical_gap]);
        }
    }
}

// Render the model
flexible_coupling();