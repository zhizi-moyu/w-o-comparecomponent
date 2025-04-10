
// Dimensions
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 5;

leg_thickness = 5;
leg_height = 60;

support_bar_thickness = 5;
central_bar_length = tabletop_width;
side_bar_length = tabletop_length - 2 * leg_thickness;

// Tabletop
module tabletop() {
    cube([tabletop_length, tabletop_width, tabletop_thickness]);
}

// Table leg
module table_leg() {
    cube([leg_thickness, leg_thickness, leg_height]);
}

// Central support bar
module central_support_bar() {
    cube([support_bar_thickness, central_bar_length, support_bar_thickness]);
}

// Side support bar
module side_support_bar() {
    cube([side_bar_length, support_bar_thickness, support_bar_thickness]);
}

// Assembly
module table() {
    // Tabletop
    translate([0, 0, leg_height])
        tabletop();

    // Legs
    translate([0, 0, 0])
        table_leg();
    translate([tabletop_length - leg_thickness, 0, 0])
        table_leg();
    translate([0, tabletop_width - leg_thickness, 0])
        table_leg();
    translate([tabletop_length - leg_thickness, tabletop_width - leg_thickness, 0])
        table_leg();

    // Central support bars (under tabletop, along width)
    translate([tabletop_length/4 - support_bar_thickness/2, 0, leg_height - tabletop_thickness])
        rotate([0,0,90])
        central_support_bar();
    translate([3*tabletop_length/4 - support_bar_thickness/2, 0, leg_height - tabletop_thickness])
        rotate([0,0,90])
        central_support_bar();

    // Side support bars (near bottom, along length)
    translate([leg_thickness, 0, support_bar_thickness])
        side_support_bar();
    translate([leg_thickness, tabletop_width - support_bar_thickness, support_bar_thickness])
        side_support_bar();
}

// Render the table
table();

