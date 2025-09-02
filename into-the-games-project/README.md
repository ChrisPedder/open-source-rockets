# Into the Games Rocket

An open source model rocket project designed for educational purposes and recreational flying. This rocket uses readily available components and 3D printed parts to create a stable, recoverable rocket suitable for D-class motors.

## Project Overview

This rocket is designed around a 50mm diameter mailing tube body with 3D printed motor mount, nose cone, and fin attachment system. The design prioritizes simplicity, safety, and repeatability while maintaining good aerodynamic performance.

**Key Specifications:**
- Body diameter: 50mm
- Motor: 18mm diameter (Klima D9-3 recommended)
- Recovery: 30cm parachute with kevlar shock cord
- Fin material: 4mm plywood
- Estimated flight altitude: ~150m (dependent on motor and conditions)

## Repository Contents

### Design Files

#### `into-the-games-rocket.ork`
OpenRocket simulation file containing the complete rocket design, stability analysis, and flight simulations.

**How to open:** Download and install [OpenRocket](http://openrocket.sourceforge.net/) (free, cross-platform), then open this .ork file to view simulations, modify the design, or analyze different motor configurations.

**What it contains:**
- Complete 3D model of the rocket
- Center of gravity and pressure calculations
- Stability margin analysis
- Flight simulation data for various motors
- Recovery system deployment timing

#### `fin-shape.svg`
Laser cutter template for the rocket fins.

**How to open:** Any vector graphics program (Inkscape, Adobe Illustrator, or even a web browser)

**Usage:** Send this file directly to a laser cutter set for 4mm plywood. The design includes 3 identical fins.

### 3D Printable Parts

All STL files are ready for 3D printing in PLA plastic with standard settings (0.2mm layer height, 20% infill).

#### `motor-mount.stl` / `motor-mount.scad`
**Purpose:** Houses the 18mm motor and provides attachment point for recovery system
**Features:**
- Precise 18mm motor tube fit
- Drill two 3mm holes in the top mounting ring shock cord attachment point
- Designed for friction fit into 50mm body tube, attachment with pva glue

#### `nose-cone.stl` / `nose-cone.scad`
**Purpose:** Aerodynamic nose cone with recovery system compartment
**Features:**
- Ogive shape for optimal aerodynamics
- Hollow interior, drill two 3mm holes for shock cord attachment
- Friction fit to body tube

#### `screw-cap.stl`
**Purpose:** Removable cap for motor mount access
**Features:** Threaded design for secure motor retention and easy motor changes

#### `fin-guide.stl`
**Purpose:** Alignment jig for precise fin attachment
**Features:** Ensures proper fin angle and spacing during assembly

### OpenSCAD Source Files

The `.scad` files are parametric source code for the 3D printed parts.

**How to open:** Download [OpenSCAD](https://openscad.org/) (free, open source)

**Benefits:**
- Modify dimensions for different body tubes or motors
- Adjust tolerances for your specific 3D printer
- Customize features like shock cord attachment points
- Generate parts for scaled versions

## Required Components

### Body Tube
**Part:** Mailing tube with plastic caps (50mm inner diameter × 310mm length)
**Source:** [Galaxus.ch](https://www.galaxus.ch/en/s12/product/kaiserkraft-mailing-tube-with-plastic-cap-and-base-lx-310-x-50-mm-brown-30-items-1-x-cardboard-boxes-43762165)
**Quantity:** 1 tube
**Notes:** Brown cardboard construction, includes plastic end caps

### Fins
**Material:** 4mm plywood
**Source:** Local laser cutting service or makerspace
**Quantity:** 3 fins (cut from `fin-shape.svg`)
**Dimensions:** Approximately 100mm × 80mm per fin

### 3D Printed Components
**Material:** PLA plastic
**Print Settings:**
- Layer height: 0.2mm
- Infill: 20%
- Supports: Only for nose cone if needed
**Parts:** Motor mount, nose cone, screw cap, fin guide

### Recovery System
**Parachute:** 30cm diameter
**Source:** [Amazon.de](https://www.amazon.de/TranRantic-Parachute-Children-Outdoor-Outdoors/dp/B0F7KQTMBR/)
**Shock Cord:** 1m of 2mm kevlar line
**Notes:** Kevlar is heat-resistant and won't burn from motor ejection charge

### Rail Guide
**Material:** 5mm paper drinking straw
**Length:** ~50mm
**Purpose:** Guides rocket on launch rod during initial acceleration, attached with pva glue

## Flight Components

### Motors
**Recommended:** Klima D9-3 (18mm diameter)
**Source:** [Hobbyshop.ch](https://www.hobbyshop.ch/modellraketen-treibsatz-d9-3-6-stueck-klima0493.html)
**Notes:**
- D9-3 provides good altitude (150m) with 3-second delay for recovery deployment
- Always verify motor fits properly before flight
- Store motors in cool, dry location

### Recovery Wadding
**Purpose:** Protects parachute from hot ejection gases
**Source:** [Hobbyshop.ch](https://www.hobbyshop.ch/schutzwatte-fuer-modellraketen-klima7020.html)
**Usage:** Pack wadding loosely into body tube below parachute before each flight

## Launch Equipment

### Launch Rod
**Specification:** 5mm diameter metal rod, minimum 1m length
**Purpose:** Guides rocket during initial acceleration until fins provide stability

### Safety Equipment
**Fire blanket:** Protects ground from motor flames
**Safety distance:** Minimum 30m from spectators
**Recovery area:** Large open field, minimum 200m radius

## Assembly Instructions

1. **Prepare body tube:** Remove plastic end caps, sand lightly if needed for 3D printed parts fit

2. **Install motor mount:** Press-fit motor mount into body tube, ensure shock cord attachment is accessible

3. **Attach fins:** Use fin guide to mark positions, epoxy fins to body tube with 90° spacing

4. **Install nose cone:** Test fit, ensure smooth separation for recovery

5. **Prepare recovery system:** Tie kevlar cord to motor mount, attach parachute with swivel if available

## Pre-Flight Checklist

- [ ] Motor properly installed and retained
- [ ] Recovery wadding packed above parachute
- [ ] Parachute properly folded and not tangled
- [ ] Fin attachment secure
- [ ] Launch rod guide (straw) attached
- [ ] Weight and balance verified using OpenRocket file

## Safety Notes

⚠️ **Important Safety Information:**
- Always follow local regulations for model rockets
- Never attempt to make your own motors
- Inspect all components before each flight
- Maintain safe distances during launch
- Recovery area must be clear of dry vegetation
- Do not fly in high wind conditions (>20 km/h)

## Modifications and Customization

The OpenSCAD files allow easy customization:
- **Different body tubes:** Adjust outer diameter in motor-mount.scad
- **Alternative motors:** Modify motor mount inner diameter
- **Scaled versions:** Proportionally adjust all dimensions
- **Enhanced recovery:** Add dual-deploy or electronic altimeter bay

## Contributing

This is an open source project! Contributions welcome:
- Improved designs or alternative components
- Additional motor configurations
- Better assembly instructions
- Flight test data and photos

## License

This project is released under [Creative Commons Attribution-ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/). You're free to use, modify, and share these designs as long as you provide attribution and share derivative works under the same license.

## Disclaimer

Model rocketry involves inherent risks. Users are responsible for following all local laws and safety guidelines. Always prioritize safety over performance. The authors are not responsible for damages or injuries resulting from the use of these designs.

---

**First time building rockets?** Consider joining [ARGOS](https://www.argoshpr.ch/j3/) a local rocketry club. The experience and mentorship are invaluable for safe, successful flights.
