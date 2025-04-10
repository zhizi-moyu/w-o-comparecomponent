```scad
// Parameters
shaft_d = 20;
shaft_l = 30;
flange_d = 50;
flange_t = 5;
spacer_d = 45;
spacer_t = 5;
bolt_d = 4;
bolt_l = 20;
nut_d = 6;
nut_t = 3;
bolt_circle_r = 18;

// Helper Modules
module shaft() {
    cylinder(d=shaft_d, h=shaft_l, $fn=64);
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t, $fn=64);
        for (i = [0:90:270]) {
            rotate([0,0,i])
                translate([bolt_circle_r,0,0])
                    cylinder(d=bolt_d, h=flange_t+1, $fn=32);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=spacer_d, h=spacer_t, $fn=64);
        cylinder(d=shaft_d, h=spacer_t+1, $fn=64);
        for (i = [0:90:270]) {
            rotate([0,0,i])
                translate([bolt_circle_r,0,0])
                    cylinder(d=bolt_d, h=spacer_t+1, $fn=32);
        }
    }
}

module bolt() {
    cylinder(d=bolt_d, h=bolt_l, $fn=32);
}

module nut() {
    cylinder(d=nut_d, h=nut_t, $fn=6);
}

// Assembly
translate([0,0,0]) shaft(); // input shaft

translate([0,0,shaft_l]) flange_plate(); // flange_plate_1

translate([0,0,shaft_l+flange_t]) spacer_ring(); // spacer_ring_1

translate([0,0,shaft_l+flange_t+spacer_t]) flange_plate(); // flange_plate_2

translate([0,0,shaft_l+flange_t*2+spacer_t]) flange_plate(); // flange_plate_3

translate([0,0,shaft_l+flange_t*3+spacer_t]) spacer_ring(); // spacer_ring_2

translate([0,0,shaft_l+flange_t*3+spacer_t*2]) flange_plate(); // flange_plate_4

translate([0,0,shaft_l+flange_t*4+spacer_t*2]) shaft(); // output shaft

// Bolts and Nuts (simplified placement)
for (i = [0:90:270]) {
    angle = i;
    x = bolt_circle_r * cos(angle);
    y = bolt_circle_r * sin(angle);
    
    // Bolts between flange_plate_1 and flange_plate_2
    translate([x, y, shaft_l+flange_t]) bolt();
    
    // Nuts on flange_plate_1
    translate([x, y, shaft_l]) nut();
    
    // Bolts between flange_plate_3 and flange_plate_4
    translate([x, y, shaft_l+flange_t*3+spacer_t]) bolt();
    
    // Nuts on flange_plate_4
    translate([x, y, shaft_l+flange_t*4+spacer_t*2]) nut();
}
```

