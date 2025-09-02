// Rocket Motor Mount with Cap for 3D Printing - CONTINUOUS THREAD GROOVES
// All dimensions in millimeters

// Global Parameters
$fn = 50; // Reduced for faster rendering, increase to 100 for final print

// Main dimensions
inner_radius = 18.4 / 2;  // 9.2mm
wall_thickness = 2;
outer_radius = inner_radius + wall_thickness;  // 10.85mm
total_height = 100;

// Thread parameters
thread_length = 10;
thread_start = total_height - thread_length;  // 90mm from base
thread_pitch = 3;  // M22x1.5 metric thread
thread_depth = 1;  // Conservative depth to maintain wall strength
thread_thickness = 1;  // Controls thread thickness

// Internal retaining band parameters
band_distance_from_thread = 68.5;
band_position = total_height - band_distance_from_thread;  // 31.5mm from base
band_inner_radius = 15 / 2;  // 7.5mm
band_height = 3;

// External disc parameters
disc_outer_radius = 49.5 / 2;  // 24.75mm
disc_thickness = 2;
disc1_position = total_height - 12;  // 88mm from base
disc2_position = 0;  // At base

// Vent hole parameters for bottom disc
vent_hole_diameter = 3;
vent_hole_radius = vent_hole_diameter / 2;
vent_hole_separation = 10;  // Center to center

// Conical support parameters
cone_wall_thickness = 1.5;  // Wall thickness of the cone
cone_height = 15;  // Height of the conical support

// Cap parameters
cap_height = 15;  // Total height of cap
cap_wall_thickness = 2;
cap_top_thickness = 3;  // Thickness of top plate
cap_nozzle_radius = 16 / 2;  // 8mm radius for central hole
cap_clearance = 0.1;  // Clearance for thread fit (adjust based on printer)

// Module for creating external threads with finite thickness
module external_threads(height, radius, pitch, depth, thickness) {
    // Number of segments per turn for smoothness
    segments_per_turn = 36;
    total_angle = 360 * height / pitch;
    total_segments = segments_per_turn * height / pitch;
    
    // Generate thread as a series of small segments
    for(i = [0 : total_segments - 1]) {
        angle = i * total_angle / total_segments;
        z = i * height / total_segments;
        next_angle = (i + 1) * total_angle / total_segments;
        next_z = (i + 1) * height / total_segments;
        
        // Create each thread segment
        hull() {
            // Current position
            rotate([0, 0, angle])
            translate([radius, 0, z])
            rotate([90, 0, 0])
            linear_extrude(height = 0.1)
            polygon(points = [
                [-thickness/2, 0],
                [-thickness/2 * 0.7, depth],
                [thickness/2 * 0.7, depth],
                [thickness/2, 0]
            ]);
            
            // Next position
            rotate([0, 0, next_angle])
            translate([radius, 0, next_z])
            rotate([90, 0, 0])
            linear_extrude(height = 0.1)
            polygon(points = [
                [-thickness/2, 0],
                [-thickness/2 * 0.7, depth],
                [thickness/2 * 0.7, depth],
                [thickness/2, 0]
            ]);
        }
    }
}

// Module for main cylinder body
module main_cylinder() {
    difference() {
        // Outer cylinder
        cylinder(h = total_height, r = outer_radius);
        
        // Inner hollow
        cylinder(h = total_height, r = inner_radius);
    }
}

// Module for internal retaining band
module internal_band() {
    translate([0, 0, band_position]) {
        difference() {
            // Fill the internal space at this height
            cylinder(h = band_height, r = inner_radius);
            // Create the smaller opening
            cylinder(h = band_height, r = band_inner_radius);
        }
    }
}

// Module for conical support structure
module conical_support(disc_position) {
    translate([0, 0, disc_position - cone_height]) {
        difference() {
            // Outer cone (from disc radius at top to cylinder radius at bottom)
            cylinder(h = cone_height, 
                    r1 = outer_radius,  // Bottom radius (at cylinder)
                    r2 = disc_outer_radius);  // Top radius (at disc)
            
            // Inner cone (hollow it out to save material and reduce weight)
            translate([0, 0, -0.01])  // Slight offset to ensure clean difference
                cylinder(h = cone_height + 0.02, 
                        r1 = outer_radius - cone_wall_thickness,  // Bottom inner radius
                        r2 = disc_outer_radius - cone_wall_thickness);  // Top inner radius
            
            // Cut out the center to allow the main cylinder to pass through
            translate([0, 0, -0.01])
                cylinder(h = cone_height + 0.02, r = outer_radius + 0.01);
        }
    }
}

// Module for external mounting discs with vent holes
module mounting_disc(position, add_vent_holes = false) {
    translate([0, 0, position]) {
        difference() {
            cylinder(h = disc_thickness, r = disc_outer_radius);
            
            // Cut out center to fit around main cylinder
            cylinder(h = disc_thickness, r = outer_radius - 0.01);
            
            // Add vent holes if specified (for bottom disc)
            if (add_vent_holes) {
                // First vent hole
                translate([vent_hole_separation/2, 0, 0])
                    cylinder(h = disc_thickness + 1, r = vent_hole_radius);
                // Second vent hole
                translate([-vent_hole_separation/2, 0, 0])
                    cylinder(h = disc_thickness + 1, r = vent_hole_radius);
            }
        }
    }
}

// Complete motor mount assembly
module motor_mount() {
    union() {
        // Main cylinder body
        main_cylinder();
        
        // Add internal retaining band
        internal_band();
        
        // Add conical support for top disc
        conical_support(disc1_position);
        
        // Add external mounting disc (top, no vent holes)
        mounting_disc(disc1_position, false);
        
        // Add external mounting disc (bottom, with vent holes)
        mounting_disc(disc2_position, true);
        
        // Add threads to external surface
        translate([0, 0, thread_start])
            external_threads(thread_length, outer_radius, thread_pitch, thread_depth, thread_thickness);
    }
}

// NEW: Module for creating continuous internal thread grooves using hull operations
module continuous_internal_thread_groove(height, inner_radius, pitch, depth, groove_width) {
    // Number of segments per turn for smoothness
    segments_per_turn = 72;  // Increased for smoother groove
    total_segments = segments_per_turn * height / pitch;
    
    // Create continuous groove by hulling adjacent segments
    for(i = [0 : total_segments - 1]) {
        angle1 = i * 360 / segments_per_turn;
        z1 = i * height / total_segments;
        angle2 = (i + 1) * 360 / segments_per_turn;
        z2 = (i + 1) * height / total_segments;
        
        // Hull between consecutive positions to create continuous groove
        hull() {
            // First position
            rotate([0, 0, angle1])
            translate([inner_radius, 0, z1])
            rotate([0, 90, 0])
            cylinder(h = depth * 1.5, r = groove_width/2);
            
            // Second position
            rotate([0, 0, angle2])
            translate([inner_radius, 0, z2])
            rotate([0, 90, 0])
            cylinder(h = depth * 1.5, r = groove_width/2);
        }
    }
}

// Alternative method using polyhedron for truly continuous groove
module helical_thread_cutter(height, radius, pitch, depth, width) {
    // This creates a spiral cutting tool
    linear_extrude(height = height, twist = -360 * height / pitch, slices = height * 2)
    translate([radius, 0, 0])
    square([depth * 2, width], center = true);
}

// IMPROVED: Screw cap with continuous internal thread grooves
module screw_cap() {
    // Calculate the inner radius for thread engagement
    thread_inner_radius = outer_radius + cap_clearance;
    
    difference() {
        // Main cap body
        union() {
            // Cylindrical body with enough thickness for threads
            cylinder(h = cap_height, 
                    r = thread_inner_radius + thread_depth + cap_wall_thickness);
            
            // Grip ridges for easier handling
            for(i = [0:11]) {
                rotate([0, 0, i * 30])
                translate([thread_inner_radius + thread_depth + cap_wall_thickness - 0.5, 0, cap_height/2])
                    cube([1, 3, cap_height * 0.6], center = true);
            }
        }
        
        // Main hollow cavity for the motor mount body
        translate([0, 0, cap_top_thickness])
            cylinder(h = cap_height, r = thread_inner_radius - thread_depth * 0.5);
        
        // Thread engagement area - slightly wider
        translate([0, 0, cap_height - thread_length - 1])
            cylinder(h = thread_length + 1.1, r = thread_inner_radius + thread_depth * 0.3);
        
        // Cut continuous internal thread grooves
        translate([0, 0, cap_height - thread_length])
            continuous_internal_thread_groove(
                height = thread_length,
                inner_radius = thread_inner_radius,
                pitch = thread_pitch,
                depth = thread_depth * 1.2,  // Slightly deeper for better engagement
                groove_width = thread_thickness * 1.2  // Slightly wider for clearance
            );
        
        // Central nozzle hole
        cylinder(h = cap_height + 1, r = cap_nozzle_radius);
        
        // Top chamfer for nozzle
        translate([0, 0, cap_height - 1])
            cylinder(h = 1.5, r1 = cap_nozzle_radius, r2 = cap_nozzle_radius + 1);
        
        // Lead-in chamfer at bottom for easier threading
        translate([0, 0, cap_height - 1])
            cylinder(h = 1.5, 
                    r1 = thread_inner_radius - thread_depth * 0.5,
                    r2 = thread_inner_radius + thread_depth + cap_clearance);
        
        // Thread lead-in taper
        translate([0, 0, cap_height - thread_length - 1])
            cylinder(h = 1, 
                    r1 = thread_inner_radius + thread_depth * 0.3,
                    r2 = thread_inner_radius);
    }
}

// Alternative cap using linear_extrude method for perfectly continuous threads
module screw_cap_alternative() {
    // Calculate the inner radius for thread engagement
    thread_inner_radius = outer_radius + cap_clearance;
    
    difference() {
        // Main cap body
        union() {
            // Cylindrical body
            cylinder(h = cap_height, 
                    r = thread_inner_radius + thread_depth + cap_wall_thickness);
            
            // Grip ridges
            for(i = [0:11]) {
                rotate([0, 0, i * 30])
                translate([thread_inner_radius + thread_depth + cap_wall_thickness - 0.5, 0, cap_height/2])
                    cube([1, 3, cap_height * 0.6], center = true);
            }
        }
        
        // Main hollow cavity
        translate([0, 0, cap_top_thickness])
            cylinder(h = cap_height, r = thread_inner_radius - thread_depth * 0.5);
        
        // Thread area
        translate([0, 0, cap_height - thread_length - 1])
            cylinder(h = thread_length + 1.1, r = thread_inner_radius + thread_depth * 0.3);
        
        // Use helical cutter for perfectly continuous groove
        translate([0, 0, cap_height - thread_length])
            helical_thread_cutter(
                height = thread_length,
                radius = thread_inner_radius,
                pitch = thread_pitch,
                depth = thread_depth * 1.2,
                width = thread_thickness * 1.2
            );
        
        // Central nozzle hole
        cylinder(h = cap_height + 1, r = cap_nozzle_radius);
        
        // Chamfers
        translate([0, 0, cap_height - 1])
            cylinder(h = 1.5, r1 = cap_nozzle_radius, r2 = cap_nozzle_radius + 1);
    }
}

// RENDERING OPTIONS
// Uncomment the option you want to render:

// Option 1: Motor mount only
motor_mount();

// Option 2: Cap with continuous grooves (hull method)
// screw_cap();

// Option 2b: Cap with helical cutter method (alternative - may be smoother)
// screw_cap_alternative();

// Option 3: Both parts side by side for printing
// motor_mount();
// translate([60, 0, 0])
//     rotate([180, 0, 0])
//     screw_cap();

// Option 4: Assembly view (cap on mount)
// motor_mount();
// color("red", 0.5)
//     translate([0, 0, total_height - cap_height + cap_top_thickness])
//     screw_cap();

// Option 5: Cross-section view - BEST FOR VERIFYING CONTINUOUS GROOVES
// difference() {
//     union() {
//         motor_mount();
//         color("red", 0.7)
//             translate([0, 0, total_height - cap_height + cap_top_thickness])
//             screw_cap();
//     }
//     translate([0, -50, -1])
//         cube([100, 100, 150]);
// }

// PRINT RECOMMENDATIONS:
// 1. Print mount vertically with supports for overhangs
// 2. Print cap upside down (threads facing build plate) for best thread quality
// 3. Layer height: 0.15-0.2mm for good thread detail
// 4. Initial cap_clearance set to 0.3mm - adjust based on your printer
// 5. Test with a short section first (reduce thread_length to 3mm for testing)
// 6. If threads are too tight, increase cap_clearance by 0.1mm increments
// 7. For smoother threads, increase $fn to 100 for final render