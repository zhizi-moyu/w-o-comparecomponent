
// Parameters
block_length = 60;
block_height = 30;
block_thickness = 10;
hole_diameter = 6;
hole_radius = hole_diameter / 2;
hole_offset_x = 15; // distance from each end
hole_center_y = block_height / 2;

// Main block
difference() {
    // Solid block
    cube([block_length, block_height, block_thickness], center=false);

    // Holes
    translate([hole_offset_x, hole_center_y, -1])
        rotate([90, 0, 0])
            cylinder(h=block_height + 2, r=hole_radius, $fn=50);

    translate([block_length - hole_offset_x, hole_center_y, -1])
        rotate([90, 0, 0])
            cylinder(h=block_height + 2, r=hole_radius, $fn=50);
}

