
// Module to create a single L-bracket
module L_bracket() {
    difference() {
        union() {
            cube([2, 20, 2]); // vertical arm
            cube([20, 2, 2]); // horizontal arm
        }
        // Cut the inner corner to make it rounded
        translate([0, 0, 0])
            cylinder(h=2, r=2, $fn=30);
    }
}

// Stack of 6 L-brackets
for (i = [0:5]) {
    translate([0, 0, i * 5])
        L_bracket();
}

