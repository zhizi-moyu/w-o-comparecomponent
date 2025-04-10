
// Module to create a single curved wedge block (60-degree sector)
module curved_wedge_block() {
    difference() {
        // Outer cylinder sector
        rotate_extrude(angle=60)
            translate([20, 0, 0])  // Radius of 20
                square([2, 30]);   // Thickness 2, height 30

        // Inner cylinder cutout to make it hollow
        rotate_extrude(angle=60)
            translate([18, 0, 0])  // Inner radius of 18
                square([2.1, 30]); // Slightly larger to ensure subtraction
    }
}

// Assemble six blocks in a circular pattern
for (i = [0:5]) {
    rotate([0, 0, i * 60])
        curved_wedge_block();
}

