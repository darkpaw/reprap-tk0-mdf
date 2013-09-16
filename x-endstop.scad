include <configuration.scad>
use <endstops.scad>

scale([1.015, 1.015, 1.015]){
	rotate([0,180,0]){
		translate([0,0,-10]){
			x_endstop(1);
		}
	}
}
