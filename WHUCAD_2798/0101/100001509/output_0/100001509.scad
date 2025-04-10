
// Parameters
plate_size = 40;         // Length and width of the square plate
plate_thickness = 2;     // Thickness of the plate
hole_diameter = 4;       // Diameter of the central hole
corner_radius = 3;       // Radius for rounded corners

// Module to create a square plate with rounded corners
module rounded_square_plate(size, thickness, radius, hole_d) {
    difference() {
        // Rounded square plate
        minkowski() {
            cube([size - 2*radius, size - 2*radius, thickness], center=true);
            cylinder(r=radius, h=0.01, center=true);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(d=hole_d, h=thickness + 2, center=true);
    }
}

// Render the plate
rounded_square_plate(plate_size, plate_thickness, corner_radius, hole_diameter);

