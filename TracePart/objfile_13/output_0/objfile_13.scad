```scad
$fn = 100;

// Parameters
shaft_hub_radius = 15;
shaft_hub_length = 10;
gear_ring_radius = 13;
gear_ring_length = 5;
sleeve_radius = 10;
sleeve_length = 20;
outer_housing_radius = 20;
outer_housing_length = 50;
hole_radius = 3;

// Shaft Hub (Left and Right)
module shaft_hub() {
    difference() {
        cylinder(h = shaft_hub_length, r = shaft_hub_radius);
        translate([0, 0, -1])
            cylinder(h = shaft_hub_length + 2, r = hole_radius);
    }
}

// Internal Gear Ring (simplified)
module internal_gear_ring() {
    difference() {
        cylinder(h = gear_ring_length, r = gear_ring_radius);
        translate([0, 0, -1])
            cylinder(h = gear_ring_length + 2, r = sleeve_radius);
    }
}

// Internal Gear Sleeve (simplified)
module internal_gear_sleeve() {
    cylinder(h = sleeve_length, r = sleeve_radius);
}

// Outer Housing
module outer_housing() {
    difference() {
        cylinder(h = outer_housing_length, r = outer_housing_radius);
        translate([0, 0, -1])
            cylinder(h = outer_housing_length + 2, r = shaft_hub_radius + 1);
    }
}

// Assembly
module coupling_assembly() {
    // Left Shaft Hub
    translate([0, 0, 0])
        shaft_hub();

    // Internal Gear Ring 1
    translate([0, 0, shaft_hub_length])
        internal_gear_ring();

    // Internal Gear Sleeve
    translate([0, 0, shaft_hub_length + gear_ring_length])
        internal_gear_sleeve();

    // Internal Gear Ring 2
    translate([0, 0, shaft_hub_length + gear_ring_length + sleeve_length])
        internal_gear_ring();

    // Right Shaft Hub
    translate([0, 0, shaft_hub_length + 2 * gear_ring_length + sleeve_length])
        shaft_hub();

    // Outer Housing
    translate([0, 0, 0])
        outer_housing();
}

// Render the full assembly
coupling_assembly();
```

