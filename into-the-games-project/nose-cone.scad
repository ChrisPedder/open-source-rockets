// 3:1 Tangent Ogive Rocket Nose Cone with Shoulder
// All dimensions in millimeters

// Configurable Parameters
base_diameter = 53;        // Base diameter of nose cone (mm)
shoulder_diameter = 49.5;     // Shoulder diameter (mm)
shoulder_length = 50;       // Shoulder length (mm)
wall_thickness = 2;         // Wall thickness (mm)
cone_length = 150;          // Length of nose cone (mm)

// Resolution settings
$fn = 100;                  // Number of fragments for circles

// Calculate ogive parameters
radius = base_diameter / 2;
L = cone_length;
rho = (radius * radius + L * L) / (2 * radius);  // Radius of curvature

// Function to calculate ogive profile at height z
function ogive_radius(z, L, rho, radius) = 
    z >= 0 && z <= L ? 
    sqrt(rho * rho - (L - z) * (L - z)) + radius - rho : 
    0;

// Create the nose cone shape
module nose_cone_solid() {
    // Generate ogive profile points
    points = [
        for(i = [0:1:100]) 
            let(z = i * L / 100)
            [ogive_radius(z, L, rho, radius), z]
    ];
    
    // Add final point at base
    final_points = concat(points, [[0, L]]);
    
    // Rotate the profile to create 3D shape
    rotate_extrude(convexity = 10)
        polygon(final_points);
}

// Create the hollow nose cone with shoulder
module hollow_nose_cone() {
    difference() {
        union() {
            // Outer nose cone
            nose_cone_solid();
            
            // Outer shoulder
            translate([0, 0, L])
                cylinder(h = shoulder_length, 
                        r = shoulder_diameter / 2, 
                        center = false);
        }
        
        // Inner cavity for nose cone
        translate([0, 0, -0.01])  // Small offset to avoid z-fighting
        scale([(radius - wall_thickness) / radius, 
               (radius - wall_thickness) / radius, 
               (L - wall_thickness) / L])
            nose_cone_solid();
        
        // Inner cavity for shoulder (hollow tube)
        translate([0, 0, L - 0.01])
            cylinder(h = shoulder_length + 0.02, 
                    r = shoulder_diameter / 2 - wall_thickness, 
                    center = false);
    }
}

// Rotate for printing orientation (tip pointing up)
// Comment out the rotation if you want tip at origin pointing up
hollow_nose_cone();

// Display information
echo("=== Nose Cone Parameters ===");
echo(str("Base diameter: ", base_diameter, " mm"));
echo(str("Cone length: ", cone_length, " mm"));
echo(str("Shoulder diameter: ", shoulder_diameter, " mm"));
echo(str("Shoulder length: ", shoulder_length, " mm"));
echo(str("Wall thickness: ", wall_thickness, " mm"));
echo(str("Ogive radius of curvature: ", rho, " mm"));