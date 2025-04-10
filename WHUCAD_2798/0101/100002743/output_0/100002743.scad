
// Parameters
block_width = 30;
block_depth = 30;
block_height = 15;
round_radius = 3;

// Rounded top block
module rounded_edge_block() {
    difference() {
        // Full block with rounded top
        minkowski() {
            cube([block_width - 2*round_radius, block_depth - 2*round_radius, block_height - round_radius], center=false);
            translate([0, 0, block_height - round_radius])
                cylinder(h=round_radius, r=round_radius, $fn=50);
        }
        // Remove excess rounding at bottom
        translate([-1, -1, -10])
            cube([block_width + 2, block_depth + 2, 10]);
    }
}

// Render the block
translate([0, 0, 0])
    rounded_edge_block();

