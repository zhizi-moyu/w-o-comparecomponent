
// Parameters
block_size = [40, 40, 30]; // Width, Depth, Height of the block
pyramid_base = 10;         // Base width of each pyramid
pyramid_height = 10;       // Height of each pyramid
spacing = 20;              // Distance between centers of pyramids

module hollowed_block() {
    difference() {
        // Main solid block
        cube(block_size, center = true);

        // Pyramidal recesses
        for (x = [-spacing/2, spacing/2])
            for (y = [-spacing/2, spacing/2])
                translate([x, y, block_size[2]/2])
                    rotate([0, 0, 0])
                        pyramid_recess();
    }
}

// Pyramid-shaped recess module
module pyramid_recess() {
    translate([0, 0, 0])
        rotate([180, 0, 0]) // Invert the pyramid to recess into the block
            polyhedron(
                points=[
                    [ -pyramid_base/2, -pyramid_base/2, 0],
                    [  pyramid_base/2, -pyramid_base/2, 0],
                    [  pyramid_base/2,  pyramid_base/2, 0],
                    [ -pyramid_base/2,  pyramid_base/2, 0],
                    [ 0, 0, pyramid_height]
                ],
                faces=[
                    [0, 1, 4],
                    [1, 2, 4],
                    [2, 3, 4],
                    [3, 0, 4],
                    [0, 1, 2, 3]
                ]
            );
}

// Render the model
hollowed_block();

