
// Dimensions
length = 40;
width = 20;
height_back = 20;
height_front = 5;

// Define the angled block as a polyhedron
polyhedron(
    points=[
        [0, 0, 0],                // 0: bottom front left
        [length, 0, 0],           // 1: bottom front right
        [length, width, 0],       // 2: bottom back right
        [0, width, 0],            // 3: bottom back left
        [0, 0, height_front],     // 4: top front left (lower)
        [length, 0, height_front],// 5: top front right (lower)
        [length, width, height_back], // 6: top back right (higher)
        [0, width, height_back]       // 7: top back left (higher)
    ],
    faces=[
        [0, 1, 2, 3], // bottom
        [4, 5, 6, 7], // top (inclined)
        [0, 1, 5, 4], // front
        [1, 2, 6, 5], // right
        [2, 3, 7, 6], // back
        [3, 0, 4, 7]  // left
    ]
);

