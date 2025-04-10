
$fn = 100; // Smoothness

module flexible_coupling() {
    difference() {
        union() {
            // Main body
            cylinder(h = 30, d = 20);

            // Flexible cutouts
            for (i = [0:1]) {
                translate([0, 0, 5 + i * 10])
                    rotate([0, 90, 0])
                        cube([20, 4, 10], center = true);
            }
        }

        // Shaft holes
        translate([0, 0, -1])
            cylinder(h = 32, d = 6);

        // Slit cut
        translate([-1, -10, 0])
            cube([2, 20, 30]);

        // Set screw holes
        for (z = [5, 25]) {
            translate([10, 0, z])
                rotate([0, 90, 0])
                    cylinder(h = 20, d = 3);
        }

        // Side holes (for clamping)
        for (z = [5, 25]) {
            translate([0, 10, z])
                rotate([90, 0, 0])
                    cylinder(h = 20, d = 3);
        }
    }
}

flexible_coupling();

