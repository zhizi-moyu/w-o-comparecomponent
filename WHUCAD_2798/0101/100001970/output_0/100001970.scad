
// Parameters
outer_diameter = 40;
outer_height = 30;

cavity_diameter = 20;
cavity_depth = 10;

shaft_diameter = 20;
shaft_height = 15;

// Outer cylindrical body with recessed cavity
module outer_cylindrical_body() {
    difference() {
        cylinder(h = outer_height, d = outer_diameter, $fn=64);
        translate([0, 0, 0])
            cylinder(h = cavity_depth, d = cavity_diameter, $fn=64);
    }
}

// Inner cylindrical shaft
module inner_cylindrical_shaft() {
    translate([0, 0, -shaft_height])
        cylinder(h = shaft_height, d = shaft_diameter, $fn=64);
}

// Assembling the model
union() {
    outer_cylindrical_body();
    inner_cylindrical_shaft();
}

