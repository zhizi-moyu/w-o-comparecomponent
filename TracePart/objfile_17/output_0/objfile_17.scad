```scad
// Parameters
hub_d = 20;
hub_l = 20;
flange_d = 40;
flange_t = 4;
spacer_d = 35;
spacer_t = 6;
bolt_d = 3;
bolt_l = 20;
bolt_offset = 15;

// Modules
module hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l, $fn=100);
        translate([0, 0, -1])
            cylinder(d=8, h=hub_l + 2, $fn=100); // shaft hole
    }
}

module flange() {
    difference() {
        cylinder(d=flange_d, h=flange_t, $fn=100);
        for (i = [0:90:270]) {
            rotate([0, 0, i])
                translate([bolt_offset, 0, 0])
                    cylinder(d=bolt_d, h=flange_t + 2, $fn=50);
        }
    }
}

module spacer() {
    cylinder(d=spacer_d, h=spacer_t, $fn=100);
}

module bolt() {
    cylinder(d=bolt_d, h=bolt_l, $fn=50);
}

module nut() {
    cylinder(d=bolt_d + 2, h=2, $fn=6);
}

// Assembly
translate([0, 0, 0]) hub(); // input hub

translate([0, 0, hub_l]) flange(); // flange 1
translate([0, 0, hub_l + flange_t]) flange(); // flange 2

translate([0, 0, hub_l + 2 * flange_t]) spacer(); // spacer ring

translate([0, 0, hub_l + 2 * flange_t + spacer_t]) flange(); // flange 3
translate([0, 0, hub_l + 3 * flange_t + spacer_t]) flange(); // flange 4

translate([0, 0, hub_l + 4 * flange_t + spacer_t]) hub(); // output hub

// Bolts and nuts (simplified)
for (i = [0:90:270]) {
    rotate([0, 0, i])
        translate([bolt_offset, 0, hub_l + flange_t / 2])
            bolt();
    rotate([0, 0, i])
        translate([bolt_offset, 0, hub_l + flange_t + bolt_l])
            nut();
}
```

