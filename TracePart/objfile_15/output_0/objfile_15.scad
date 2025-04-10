```scad
$fn = 100;

// Parameters
hub_radius = 20;
hub_length = 15;
jaw_width = 8;
jaw_depth = 5;
insert_radius = 3;
spider_arm_length = 6;
spider_arm_thickness = 3;
spider_radius = 5;

// Module: Left Hub
module left_hub() {
    difference() {
        cylinder(h = hub_length, r = hub_radius);
        // Center hole
        cylinder(h = hub_length, r = 5);
    }
    // Jaws
    for (i = [0:120:360]) {
        rotate([0, 0, i])
        translate([hub_radius - jaw_depth, 0, hub_length - jaw_width])
        cube([jaw_depth, jaw_width, jaw_width], center = false);
    }
}

// Module: Right Hub
module right_hub() {
    translate([0, 0, -(hub_length + 2)])
    mirror([0, 0, 1])
    left_hub();
}

// Module: Jaw Inserts
module jaw_inserts() {
    for (i = [0:120:360]) {
        rotate([0, 0, i])
        translate([hub_radius - jaw_depth - 1.5, 0, hub_length - jaw_width/2])
        cylinder(h = 2, r = insert_radius, center = true);
    }
}

// Module: Elastomeric Spider
module elastomeric_spider() {
    for (i = [0:60:360]) {
        rotate([0, 0, i])
        translate([spider_radius, 0, hub_length])
        cube([spider_arm_length, spider_arm_thickness, 2], center = true);
    }
    // Center hub
    translate([0, 0, hub_length])
    cylinder(h = 2, r = 4, center = true);
}

// Assembly
module coupling() {
    left_hub();
    jaw_inserts();
    elastomeric_spider();
    right_hub();
}

coupling();
```

