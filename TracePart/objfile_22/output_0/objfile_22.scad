
// Parameters
shaft_d = 20;
shaft_l = 30;
flange_d = 50;
flange_t = 5;
flexible_t = 4;
bolt_r = 2;
bolt_spacing = 18;
bolt_count = 6;
nut_r = 3;
nut_h = 3;

// Modules
module shaft() {
    cylinder(d=shaft_d, h=shaft_l, $fn=100);
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t, $fn=100);
        for (i = [0:360/bolt_count:360-360/bolt_count]) {
            rotate([0,0,i])
                translate([bolt_spacing,0,-1])
                    cylinder(r=bolt_r, h=flange_t+2, $fn=30);
        }
    }
}

module flexible_element() {
    difference() {
        cylinder(d=flange_d, h=flexible_t, $fn=100);
        for (i = [0:360/bolt_count:360-360/bolt_count]) {
            rotate([0,0,i])
                translate([bolt_spacing,0,-1])
                    cylinder(r=bolt_r+0.5, h=flexible_t+2, $fn=30);
        }
    }
}

module bolt_with_nut() {
    union() {
        cylinder(r=bolt_r, h=flange_t*2 + flexible_t + 2, $fn=30);
        translate([0,0,flange_t*2 + flexible_t])
            cylinder(r=nut_r, h=nut_h, $fn=6);
    }
}

module flange_with_bolts() {
    union() {
        flange_plate();
        for (i = [0:360/bolt_count:360-360/bolt_count]) {
            rotate([0,0,i])
                translate([bolt_spacing,0,-1])
                    bolt_with_nut();
        }
    }
}

// Assembly
translate([0,0,0])
    shaft(); // input shaft

translate([0,0,shaft_l])
    flange_with_bolts(); // flange plate 1 with bolts

translate([0,0,shaft_l + flange_t])
    flexible_element(); // flexible element

translate([0,0,shaft_l + flange_t + flexible_t])
    flange_plate(); // flange plate 2

translate([0,0,shaft_l + flange_t*2 + flexible_t])
    shaft(); // output shaft

