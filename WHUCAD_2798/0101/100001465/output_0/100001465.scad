
// Parameters
outer_length = 60;
outer_width = 30;
outer_height = 40;
flange_thickness = 2;
flange_extension = 5;

inner_top_length = 40;
inner_top_width = 20;
inner_bottom_length = 20;
inner_bottom_width = 10;
inner_height = outer_height;

// Main block with flanges
module tapered_hollow_block() {
    difference() {
        // Outer block with flanges
        union() {
            // Main body
            cube([outer_length, outer_width, outer_height], center=false);
            
            // Bottom flange
            translate([-flange_extension, -flange_extension, 0])
                cube([outer_length + 2*flange_extension, outer_width + 2*flange_extension, flange_thickness]);

            // Top flange
            translate([-flange_extension, -flange_extension, outer_height - flange_thickness])
                cube([outer_length + 2*flange_extension, outer_width + 2*flange_extension, flange_thickness]);
        }

        // Tapered inner cavity
        translate([(outer_length - inner_top_length)/2, (outer_width - inner_top_width)/2, 0])
            linear_extrude(height=inner_height)
                polygon(points=[
                    [0, 0],
                    [inner_top_length, 0],
                    [inner_bottom_length + (inner_top_length - inner_bottom_length)/2, inner_height],
                    [(inner_top_length - inner_bottom_length)/2, inner_height]
                ]);
    }
}

// Render the model
tapered_hollow_block();


