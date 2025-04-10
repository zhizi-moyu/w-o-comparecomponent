
// Parameters
nut_height = 30;
nut_radius = 10;
hex_radius = 5.5; // Distance from center to flat of hex
hex_depth = 10;

// Main nut body
module nut_body() {
    cylinder(h = nut_height, r1 = nut_radius * 0.9, r2 = nut_radius, $fn = 100); // Slight taper
}

// Hexagonal socket
module hex_socket() {
    rotate([0, 0, 0])
        linear_extrude(height = hex_depth)
            polygon(points = [
                [cos(0)*hex_radius, sin(0)*hex_radius],
                [cos(60)*hex_radius, sin(60)*hex_radius],
                [cos(120)*hex_radius, sin(120)*hex_radius],
                [cos(180)*hex_radius, sin(180)*hex_radius],
                [cos(240)*hex_radius, sin(240)*hex_radius],
                [cos(300)*hex_radius, sin(300)*hex_radius]
            ]);
}

// Final nut with hex socket
difference() {
    nut_body();
    translate([0, 0, nut_height - hex_depth])
        hex_socket();
}

