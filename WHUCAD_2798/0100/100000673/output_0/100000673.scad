
// Locking Key - Irregular polygonal shape with consistent thickness

module locking_key() {
    linear_extrude(height = 3)  // Thickness of the key
    polygon(points=[
        [0, 0],         // Bottom-left rounded end
        [5, 0],
        [6, 1],
        [10, 4],
        [6, 8],
        [5, 9],
        [0, 9],
        [-1, 8],
        [-1, 1]
    ]);
}

// Render the locking key
locking_key();

