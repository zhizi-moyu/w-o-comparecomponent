
$fn = 100; // Smoothness

// Parameters
hub_diameter = 30;
hub_length = 20;
insert_length = 10;
shaft_hole_diameter = 8;
jaw_width = 5;
jaw_depth = 5;
jaw_count = 3;

// Main assembly
module coupling() {
    translate([0, 0, hub_length + insert_length])
        left_clamp_hub();
    translate([0, 0, hub_length])
        central_jaw_insert();
    right_clamp_hub();
}

// Left clamp hub
module left_clamp_hub() {
    difference() {
        cylinder(d=hub_diameter, h=hub_length);
        translate([0, 0, -1])
            cylinder(d=shaft_hole_diameter, h=hub_length + 2);
        // Jaw slots
        for (i = [0 : 360/jaw_count : 360 - 360/jaw_count]) {
            rotate([0, 0, i])
                translate([hub_diameter/2 - jaw_depth, -jaw_width/2, hub_length - jaw_depth])
                    cube([jaw_depth, jaw_width, jaw_depth]);
        }
    }
}

// Right clamp hub
module right_clamp_hub() {
    difference() {
        cylinder(d=hub_diameter, h=hub_length);
        translate([0, 0, -1])
            cylinder(d=shaft_hole_diameter, h=hub_length + 2);
        // Jaw slots
        for (i = [0 : 360/jaw_count : 360 - 360/jaw_count]) {
            rotate([0, 0, i])
                translate([hub_diameter/2 - jaw_depth, -jaw_width/2, 0])
                    cube([jaw_depth, jaw_width, jaw_depth]);
        }
    }
}

// Central jaw insert
module central_jaw_insert() {
    difference() {
        cylinder(d=hub_diameter, h=insert_length);
        // Remove material between jaws
        for (i = [0 : 360/jaw_count : 360 - 360/jaw_count]) {
            rotate([0, 0, i])
                translate([hub_diameter/2 - jaw_depth, -jaw_width/2, 0])
                    cube([jaw_depth, jaw_width, insert_length]);
        }
    }
}

// Render the full coupling
coupling();

