
// Parameters
outer_diameter = 40;
inner_diameter = 20;

// Heights of each spacer ring
heights = [3, 5, 4, 4, 6, 5];

// Function to create a spacer ring
module spacer_ring(height) {
    difference() {
        cylinder(h = height, d = outer_diameter, $fn = 100);
        translate([0, 0, -1])  // Slightly lower to ensure clean subtraction
            cylinder(h = height + 2, d = inner_diameter, $fn = 100);
    }
}

// Stack the spacer rings
translate([0, 0, 0]) spacer_ring(heights[0]); // spacer_ring_1
translate([0, 0, heights[0]]) spacer_ring(heights[1]); // spacer_ring_2
translate([0, 0, heights[0] + heights[1]]) spacer_ring(heights[2]); // spacer_ring_3
translate([0, 0, heights[0] + heights[1] + heights[2]]) spacer_ring(heights[3]); // spacer_ring_4
translate([0, 0, heights[0] + heights[1] + heights[2] + heights[3]]) spacer_ring(heights[4]); // spacer_ring_5
translate([0, 0, heights[0] + heights[1] + heights[2] + heights[3] + heights[4]]) spacer_ring(heights[5]); // spacer_ring_6

