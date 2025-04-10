```scad
// Parameters
shaft_d = 20;
shaft_l = 30;

flange_d = 40;
flange_t = 5;

spacer_d = 35;
spacer_t = 5;

bolt_d = 4;
bolt_l = 20;

nut_d = 6;
nut_t = 3;

spacing = 2; // spacing between components

// Modules
module shaft() {
    cylinder(d=shaft_d, h=shaft_l, $fn=64);
}

module flange_plate() {
    cylinder(d=flange_d, h=flange_t, $fn=64);
}

module spacer_ring() {
    difference() {
        cylinder(d=spacer_d, h=spacer_t, $fn=64);
        cylinder(d=shaft_d, h=spacer_t+1, $fn=64);
    }
}

module bolt() {
    cylinder(d=bolt_d, h=bolt_l, $fn=32);
}

module nut() {
    cylinder(d=nut_d, h=nut_t, $fn=32);
}

// Assembly
translate([0, 0, 0]) shaft(); // input shaft

translate([0, 0, shaft_l + spacing]) flange_plate(); // flange_plate_1
translate([flange_d/2 + 2, 0, shaft_l + spacing]) nut(); // nut_1
translate([-flange_d/2 - 2, 0, shaft_l + spacing]) nut(); // nut_2

translate([0, 0, shaft_l + spacing + flange_t + spacing]) spacer_ring(); // spacer_ring_1
translate([bolt_d*3, 0, shaft_l + spacing + flange_t + spacing]) bolt(); // bolt_1
translate([-bolt_d*3, 0, shaft_l + spacing + flange_t + spacing]) bolt(); // bolt_2

translate([0, 0, shaft_l + spacing + flange_t + spacing + spacer_t + spacing]) flange_plate(); // flange_plate_2
translate([flange_d/2 + 2, 0, shaft_l + spacing + flange_t + spacing + spacer_t + spacing]) nut(); // nut_3
translate([-flange_d/2 - 2, 0, shaft_l + spacing + flange_t + spacing + spacer_t + spacing]) nut(); // nut_4

translate([0, 0, shaft_l + spacing + flange_t*2 + spacer_t + spacing*3]) flange_plate(); // flange_plate_3
translate([flange_d/2 + 2, 0, shaft_l + spacing + flange_t*2 + spacer_t + spacing*3]) nut(); // nut_5
translate([-flange_d/2 - 2, 0, shaft_l + spacing + flange_t*2 + spacer_t + spacing*3]) nut(); // nut_6

translate([0, 0, shaft_l + spacing + flange_t*3 + spacer_t + spacing*4]) spacer_ring(); // spacer_ring_2
translate([bolt_d*3, 0, shaft_l + spacing + flange_t*3 + spacer_t + spacing*4]) bolt(); // bolt_3
translate([-bolt_d*3, 0, shaft_l + spacing + flange_t*3 + spacer_t + spacing*4]) bolt(); // bolt_4

translate([0, 0, shaft_l + spacing + flange_t*3 + spacer_t*2 + spacing*5]) flange_plate(); // flange_plate_4
translate([flange_d/2 + 2, 0, shaft_l + spacing + flange_t*3 + spacer_t*2 + spacing*5]) nut(); // nut_7
translate([-flange_d/2 - 2, 0, shaft_l + spacing + flange_t*3 + spacer_t*2 + spacing*5]) nut(); // nut_8

translate([0, 0, shaft_l + spacing + flange_t*4 + spacer_t*2 + spacing*6]) shaft(); // output shaft
```

