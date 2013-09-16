
include <z_components.scad>
include <configuration.scad>

z_bottom_shelf_height = 4; 
z_bottom_shelf_gap = 44;


rotate([0,-90,0]) z_bottom();


module z_bottom(){

	support_pos = 27;

	union(){  

		difference(){
	
			union(){

				union(){
		
					z_shelf_stepper_mount();
			
					rotate([0,180,180]){
						translate([0, z_shelf_large_width/2 - 6, -0.1]) 
							tab();
						translate([0, - (z_shelf_large_width/2 - 6 - tab_width - 6), -0.1])
							tab();
					}
				}
				
				translate([0, 0, z_bottom_shelf_gap]){
					union(){
						z_shelf_bearing();
						translate([0, z_shelf_large_width/2 - 6, z_shelf_height-0.1]) 
							tab();
						translate([0, - (z_shelf_large_width/2 - 6 - tab_width - 6), z_shelf_height-0.1])
							 tab();
					}
				}
				
				difference(){
				
					union(){
						translate([0, - support_pos, z_bottom_shelf_height])
							cube([40, 4, z_bottom_shelf_gap]);
						translate([0,  support_pos - 4, z_bottom_shelf_height])
							cube([40, 4, z_bottom_shelf_gap]);
					}
					
					translate([20,50,z_bottom_shelf_height/2 + z_bottom_shelf_gap /2])
						rotate([90,0,0])
		
						cylinder(r=12, h = 100);
		
					
				}
			}

			union(){

				motor_holes();

			}




		}

		


	}

}

module z_shelf_stepper_mount(){

	stepper_shaft_hole = 12; 
	stepper_bolt_hole = 1.75; 
	stepper_shaft_pos = z_shelf_bearing_pos; 
	stepper_bolt_gap = 31; 


	bearing_holder = z_shelf_height - z_shelf_bearing_depth; 
	stepper_bolt_hole_offset = stepper_bolt_gap / 2;

	difference(){

		linear_extrude(height=z_bottom_shelf_height) z_shelf_2d();

		union(){	
			// hole for rod
			translate([z_shelf_rod_pos, 0, 3]){
				cylinder(h=z_bottom_shelf_height + 2, r=rod_radius);
			}
			
			// hole for stepper shaft
			translate([stepper_shaft_pos, 0, -1]){
				cylinder(h=z_bottom_shelf_height + 2, r=stepper_shaft_hole);
			}

		}

	}

}

module motor_holes(){

	stepper_bolt_hole = 1.75; 
	screwdriver_hole = 2.5; 
	stepper_shaft_pos = z_shelf_bearing_pos; 
	stepper_bolt_gap = 31; 

	stepper_bolt_hole_offset = stepper_bolt_gap / 2;


	union(){	

		// holes for stepper bolts
		translate([stepper_shaft_pos - stepper_bolt_hole_offset, stepper_bolt_hole_offset, -1])
			cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

		translate([stepper_shaft_pos + stepper_bolt_hole_offset, stepper_bolt_hole_offset, -1])
			cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

		translate([stepper_shaft_pos - stepper_bolt_hole_offset, -stepper_bolt_hole_offset, -1])
			cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

		translate([stepper_shaft_pos + stepper_bolt_hole_offset, -stepper_bolt_hole_offset, -1])
			cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

		// holes for access to stepper bolts
		translate([stepper_shaft_pos - stepper_bolt_hole_offset, stepper_bolt_hole_offset, z_bottom_shelf_gap-1])
			cylinder(h=z_shelf_height + 2, r=screwdriver_hole, $fn=50);

		translate([stepper_shaft_pos + stepper_bolt_hole_offset, stepper_bolt_hole_offset, z_bottom_shelf_gap-1])
			cylinder(h=z_shelf_height + 2, r=screwdriver_hole, $fn=50);

		translate([stepper_shaft_pos - stepper_bolt_hole_offset, -stepper_bolt_hole_offset, z_bottom_shelf_gap-1])
			cylinder(h=z_shelf_height + 2, r=screwdriver_hole, $fn=50);

		translate([stepper_shaft_pos + stepper_bolt_hole_offset, -stepper_bolt_hole_offset, z_bottom_shelf_gap-1])
			cylinder(h=z_shelf_height + 2, r=screwdriver_hole, $fn=50);


	}

}



