// Parameters
shaft_d = 20;
shaft_l = 20;

flange_d = 40;
flange_t = 5;

spacer_d = 35;
spacer_t = 5;

bolt_d = 3;
bolt_l = 10;

nut_d = 5;
nut_t = 3;

central_shaft_d = 20;
central_shaft_l = 40;

bolt_offset = 15;

// Modules
module shaft() {
    cylinder(d=shaft_d, h=shaft_l, $fn=100);
}

module flange_plate() {
    cylinder(d=flange_d, h=flange_t, $fn=100);
}

module spacer_ring() {
    cylinder(d=spacer_d, h=spacer_t, $fn=100);
}

module central_spacer_shaft() {
    cylinder(d=central_shaft_d, h=central_shaft_l, $fn=100);
}

module bolt() {
    cylinder(d=bolt_d, h=bolt_l, $fn=30);
}

module nut() {
    cylinder(d=nut_d, h=nut_t, $fn=30);
}

module bolt_with_nuts() {
    bolt();
    translate([0, 0, -nut_t]) nut();
    translate([0, 0, bolt_l]) nut();
}

module flange_with_bolts() {
    flange_plate();
    for (angle = [0, 180]) {
        rotate([0, 0, angle])
        translate([bolt_offset, 0, 0])
        bolt_with_nuts();
    }
}

// Assembly
translate([0, 0, 0]) shaft(); // input shaft

translate([0, 0, shaft_l]) flange_with_bolts(); // flange_plate_1 + bolts/nuts

translate([0, 0, shaft_l + flange_t]) spacer_ring(); // spacer_ring_1

translate([0, 0, shaft_l + flange_t + spacer_t]) flange_with_bolts(); // flange_plate_2 + bolts/nuts

translate([0, 0, shaft_l + 2*flange_t + spacer_t]) central_spacer_shaft(); // central shaft

translate([0, 0, shaft_l + 2*flange_t + spacer_t + central_shaft_l]) flange_with_bolts(); // flange_plate_3 + bolts/nuts

translate([0, 0, shaft_l + 3*flange_t + spacer_t + central_shaft_l]) spacer_ring(); // spacer_ring_2

translate([0, 0, shaft_l + 3*flange_t + 2*spacer_t + central_shaft_l]) flange_with_bolts(); // flange_plate_4 + bolts/nuts

translate([0, 0, shaft_l + 4*flange_t + 2*spacer_t + central_shaft_l]) shaft(); // output shaft
