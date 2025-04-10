
// Module for the base frame
module base_frame() {
    difference() {
        // Base plate
        cube([60, 40, 2], center=true);

        // Cutout in the center
        translate([0, 0, -1])
            cube([30, 20, 4], center=true);
    }

    // Triangular side supports
    translate([-25, -20, 0])
        rotate([0, 0, 0])
            linear_extrude(height=20)
                polygon(points=[[0,0], [20,0], [0,10]]);

    translate([25, -20, 0])
        rotate([0, 0, 180])
            linear_extrude(height=20)
                polygon(points=[[0,0], [20,0], [0,10]]);
}

// Module for the support frame
module support_frame() {
    // Outer frame
    difference() {
        translate([0, 0, 2])
            cube([60, 40, 2], center=true);

        // Cutout in the center
        translate([0, 0, 1])
            cube([30, 20, 4], center=true);
    }

    // Diagonal ribs
    translate([-25, -20, 2])
        rotate([0, 0, 45])
            cube([2, 20, 2]);

    translate([25, -20, 2])
        rotate([0, 0, -45])
            cube([2, 20, 2]);
}

// Assemble the model
module full_model() {
    base_frame();
    support_frame();
}

full_model();

