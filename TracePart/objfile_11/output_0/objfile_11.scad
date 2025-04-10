
// Parameters
outer_diameter = 30;
outer_height = 30;
shaft_diameter = 10;
shaft_length = 15;
set_screw_diameter = 4;
set_screw_depth = 6;
groove_width = 2;
groove_spacing = 4;
groove_count = 3;

// Module for central shaft
module central_shaft() {
    translate([0, 0, outer_height])
        cylinder(h = shaft_length, d = shaft_diameter, $fn=100);
}

// Module for set screw
module set_screw(angle) {
    rotate([0, 0, angle])
        translate([outer_diameter/2 - 1, 0, outer_height/2])
            rotate([0, 90, 0])
                cylinder(h = set_screw_depth, d = set_screw_diameter, $fn=50);
}

// Module for grooves
module grooves() {
    for (i = [1:groove_count]) {
        translate([0, 0, i * groove_spacing])
            difference() {
                cylinder(h = groove_width, d = outer_diameter + 1, $fn=100);
                cylinder(h = groove_width, d = outer_diameter - 2, $fn=100);
            }
    }
}

// Main body
module outer_cylindrical_body() {
    difference() {
        union() {
            cylinder(h = outer_height, d = outer_diameter, $fn=100);
            grooves();
        }
        // Slit through the body
        translate([0, -1, 0])
            cube([outer_diameter, 2, outer_height]);
    }
}

// Assemble all components
union() {
    outer_cylindrical_body();
    central_shaft();
    set_screw(0);
    set_screw(180);
}

