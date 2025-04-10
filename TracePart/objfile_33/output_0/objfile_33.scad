```scad
$fn = 100;

// Parameters
hub_radius = 20;
hub_length = 20;
flange_thickness = 5;
jaw_width = 5;
jaw_depth = 5;
jaw_count = 3;
spider_radius = 18;
spider_thickness = 10;
bolt_radius = 2;
bolt_hole_offset = 15;
bolt_count = 3;

// Modules
module hub(is_left=true) {
    difference() {
        union() {
            // Main hub body
            cylinder(h=hub_length, r=hub_radius);
            // Flange
            translate([0, 0, hub_length])
                cylinder(h=flange_thickness, r=hub_radius);
            // Jaws
            for (i = [0 : 360/jaw_count : 360-360/jaw_count]) {
                angle = i;
                x = (hub_radius - jaw_depth/2) * cos(angle);
                y = (hub_radius - jaw_depth/2) * sin(angle);
                translate([x, y, hub_length - jaw_width])
                    rotate([0, 0, angle])
                        cube([jaw_depth, jaw_width, jaw_width], center=true);
            }
        }
        // Center hole
        translate([0, 0, -1])
            cylinder(h=hub_length + flange_thickness + 2, r=5);
        // Bolt holes
        for (i = [0 : 360/bolt_count : 360-360/bolt_count]) {
            angle = i;
            x = bolt_hole_offset * cos(angle);
            y = bolt_hole_offset * sin(angle);
            translate([x, y, hub_length])
                cylinder(h=flange_thickness + 2, r=bolt_radius, center=true);
        }
    }
}

module spider() {
    difference() {
        cylinder(h=spider_thickness, r=spider_radius);
        // Cutouts for jaws
        for (i = [0 : 360/jaw_count : 360-360/jaw_count]) {
            angle = i;
            x = (hub_radius - jaw_depth/2) * cos(angle);
            y = (hub_radius - jaw_depth/2) * sin(angle);
            translate([x, y, 0])
                rotate([0, 0, angle])
                    cube([jaw_depth, jaw_width, spider_thickness], center=true);
        }
    }
}

module bolt_and_nut() {
    // Simple bolt and nut representation
    cylinder(h=flange_thickness*2 + 2, r=bolt_radius);
    translate([0, 0, flange_thickness*2 + 2])
        cylinder(h=2, r=bolt_radius + 1);
}

// Assembly
module coupling() {
    // Left hub
    hub(true);
    // Right hub (mirrored)
    translate([0, 0, hub_length + spider_thickness])
        mirror([0, 0, 1])
            hub(false);
    // Spider
    translate([0, 0, hub_length])
        spider();
    // Bolts and nuts
    for (i = [0 : 360/bolt_count : 360-360/bolt_count]) {
        angle = i;
        x = bolt_hole_offset * cos(angle);
        y = bolt_hole_offset * sin(angle);
        translate([x, y, hub_length - 1])
            bolt_and_nut();
    }
}

// Render the full coupling
coupling();
```

