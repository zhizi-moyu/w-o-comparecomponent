```scad
$fn = 100; // Smoothness

module flexible_coupling() {
    difference() {
        union() {
            // Main cylindrical body
            cylinder(h = 30, r = 10);

            // Clamping blocks
            translate([0, 0, 0])
                cube([20, 20, 5], center = true);
            translate([0, 0, 25])
                cube([20, 20, 5], center = true);
        }

        // Central bore
        translate([0, 0, -1])
            cylinder(h = 32, r = 4);

        // Helical cuts (simplified as rotated slots)
        for (i = [0:5]) {
            rotate([0, 0, i * 60])
                translate([10, -2, i * 5])
                    cube([20, 4, 5]);
        }

        // Clamping screw holes
        translate([7, 0, 2])
            rotate([90, 0, 0])
                cylinder(h = 20, r = 1.5);
        translate([7, 0, 28])
            rotate([90, 0, 0])
                cylinder(h = 20, r = 1.5);
    }
}

flexible_coupling();
```

