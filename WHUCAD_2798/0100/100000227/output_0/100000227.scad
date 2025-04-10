// Parameters
arm_thickness = 5;
arm_length = 30;
arm_height = 10;
gap_width = 10;
base_radius = 7;
base_height = 15;
tab_thickness = 4;
tab_length = 20;
tab_height = 10;
pin_hole_radius = 2;

// Fork End Connector
module fork_end_connector() {
    difference() {
        union() {
            // Left arm
            translate([0, 0, base_height])
                cube([arm_thickness, arm_length, arm_height], center=false);
            // Right arm
            translate([arm_thickness + gap_width, 0, base_height])
                cube([arm_thickness, arm_length, arm_height], center=false);
            // Base cylinder
            translate([arm_thickness + gap_width/2, arm_length/2, 0])
                cylinder(h=base_height, r=base_radius, $fn=50);
        }
        // Holes in arms
        translate([arm_thickness/2, arm_length/2, base_height + arm_height/2])
            rotate([90,0,0])
                cylinder(h=arm_thickness*2 + gap_width, r=pin_hole_radius, $fn=30);
    }
}

// Pin End Connector
module pin_end_connector() {
    difference() {
        union() {
            // Tab
            translate([arm_thickness, 0, base_height])
                cube([gap_width, tab_length, tab_height], center=false);
            // Base cylinder
            translate([arm_thickness + gap_width/2, tab_length/2, 0])
                cylinder(h=base_height, r=base_radius, $fn=50);
        }
        // Hole in tab
        translate([arm_thickness + gap_width/2, tab_length/2, base_height + tab_height/2])
            rotate([90,0,0])
                cylinder(h=gap_width + 2, r=pin_hole_radius, $fn=30);
    }
}

// Assembly
module assembly() {
    fork_end_connector();
    // Position pin_end_connector so its tab fits between the fork arms
    translate([0, 0, -base_height])
        pin_end_connector();
}

// Render the full model
assembly();