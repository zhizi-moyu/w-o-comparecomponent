
// Parameters
shaft_radius = 10;
shaft_height = 20;
flange_radius = 15;
flange_thickness = 3;
tab_width = 5;
tab_thickness = 3;
tab_height = 10;
center_hole_radius = 2;

// Main shaft body
module shaft_body() {
    cylinder(h = shaft_height, r = shaft_radius, $fn=100);
}

// Flange
module flange() {
    translate([0, 0, shaft_height])
        cylinder(h = flange_thickness, r = flange_radius, $fn=100);
}

// Rectangular tabs
module tabs() {
    translate([-shaft_radius, -tab_thickness/2, shaft_height - tab_height])
        cube([tab_width, tab_thickness, tab_height]);
    translate([shaft_radius - tab_width, -tab_thickness/2, shaft_height - tab_height])
        cube([tab_width, tab_thickness, tab_height]);
}

// Center hole
module center_hole() {
    translate([0, 0, -1])
        cylinder(h = shaft_height + flange_thickness + 2, r = center_hole_radius, $fn=100);
}

// Final input shaft assembly
difference() {
    union() {
        shaft_body();
        flange();
        tabs();
    }
    center_hole();
}

