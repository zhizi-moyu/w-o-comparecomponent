
// Parameters
base_length = 60;
base_width = 10;
base_height = 4;

arm_height = 40;
arm_thickness = 6;

pivot_radius = 3;
pivot_height = 6;

stop_radius = 2.5;
stop_height = 5;

// Main base
module base() {
    cube([base_length, base_width, base_height]);
}

// Vertical arm
module vertical_arm() {
    translate([0, base_width - arm_thickness, base_height])
        cube([arm_thickness, arm_thickness, arm_height]);
}

// Downward pivot pin
module pivot_pin() {
    translate([base_length - 15, base_width / 2, 0])
        rotate([90, 0, 0])
            cylinder(h = pivot_height, r = pivot_radius, $fn = 50);
}

// Upward stop pin
module stop_pin() {
    translate([10, base_width / 2, base_height])
        cylinder(h = stop_height, r = stop_radius, $fn = 50);
}

// Full lever latch body
module lever_latch_body() {
    base();
    vertical_arm();
    pivot_pin();
    stop_pin();
}

// Render the model
lever_latch_body();

