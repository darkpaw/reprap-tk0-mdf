
include <z_components.scad>

z_bottom_shelf_height = 4; 

module z_bottom(){

	 
	z_bottom_shelf_gap = 44;
	support_pos = 27;


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

}

module z_shelf_stepper_mount(){

	stepper_shaft_hole = 6; 
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

			// holes for stepper bolts
			translate([stepper_shaft_pos - stepper_bolt_hole_offset, stepper_bolt_hole_offset, -1])
				cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

			translate([stepper_shaft_pos + stepper_bolt_hole_offset, stepper_bolt_hole_offset, -1])
				cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

			translate([stepper_shaft_pos - stepper_bolt_hole_offset, -stepper_bolt_hole_offset, -1])
				cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

			translate([stepper_shaft_pos + stepper_bolt_hole_offset, -stepper_bolt_hole_offset, -1])
				cylinder(h=z_bottom_shelf_height + 2, r=stepper_bolt_hole, $fn=50);

			// rod clamp bolt
			//translate([-0.5,0,z_bottom_shelf_height/2])
			//	rod_clamp_holes(); 

		}

	}

}

rotate([0,-90,0]) z_bottom();


//translate([20,0,0]) rod_clamp_holes();


 