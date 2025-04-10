// Parameters
shaft_d = 20;
shaft_l = 30;
keyway_w = 4;
keyway_d = 2;
groove_d = 2;
groove_w = 3;
groove_spacing = 5;

flange_d = 50;
flange_t = 8;
bolt_r = 20;
bolt_d = 4;
bolt_h = 10;
num_bolts = 6;

flex_ring_t = 5;
flex_ring_d = 45;

// Modules
module input_shaft() {
    difference() {
        union() {
            cylinder(d=shaft_d, h=shaft_l);
            for (i = [1:3]) {
                translate([0, 0, i * groove_spacing])
                    cylinder(d=shaft_d + groove_d, h=groove_w);
            }
        }
        // Keyway slot
        translate([-keyway_w/2, shaft_d/2, shaft_l/2])
            cube([keyway_w, keyway_d, shaft_l], center=true);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        // Bolt holes
        for (i = [0:num_bolts-1]) {
            angle = 360 / num_bolts * i;
            translate([bolt_r * cos(angle), bolt_r * sin(angle), 0])
                cylinder(d=bolt_d, h=flange_t + 1, center=false);
        }
        // Center hole
        cylinder(d=shaft_d, h=flange_t + 1);
    }
}

module flexible_ring() {
    difference() {
        cylinder(d=flex_ring_d, h=flex_ring_t);
        cylinder(d=shaft_d, h=flex_ring_t + 1);
    }
}

module bolt_and_nut() {
    union() {
        cylinder(d=bolt_d, h=bolt_h);
        translate([0, 0, bolt_h])
            cylinder(d=bolt_d + 2, h=2); // Nut
    }
}

module flange_with_bolts() {
    union() {
        flange_plate();
        for (i = [0:num_bolts-1]) {
            angle = 360 / num_bolts * i;
            translate([bolt_r * cos(angle), bolt_r * sin(angle), flange_t])
                rotate([0, 0, angle])
                    bolt_and_nut();
        }
    }
}

// Assembly
module coupling_assembly() {
    translate([0, 0, 0])
        input_shaft();

    translate([0, 0, shaft_l])
        flange_with_bolts();

    translate([0, 0, shaft_l + flange_t])
        flexible_ring();

    translate([0, 0, shaft_l + flange_t + flex_ring_t])
        flange_with_bolts();

    translate([0, 0, shaft_l + 2 * flange_t + flex_ring_t])
        rotate([180, 0, 0])
            input_shaft(); // Reuse input_shaft as output_shaft
}

coupling_assembly();