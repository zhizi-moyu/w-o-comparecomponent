
// Parameters
block_size = 40;       // Width and depth of the block
block_height = 20;     // Height of the block
cavity_depth = 10;     // Depth of the pyramidal cavity

module pyramidal_cavity_block() {
    difference() {
        // Main solid block
        cube([block_size, block_size, block_height]);

        // Pyramidal cavity
        translate([0, 0, block_height - cavity_depth])
            translate([block_size/2, block_size/2, 0])
                rotate([0, 0, 0])
                    polyhedron(
                        points=[
                            [ -block_size/2, -block_size/2, 0],
                            [  block_size/2, -block_size/2, 0],
                            [  block_size/2,  block_size/2, 0],
                            [ -block_size/2,  block_size/2, 0],
                            [ 0, 0, cavity_depth]
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
}

// Render the model
pyramidal_cavity_block();

