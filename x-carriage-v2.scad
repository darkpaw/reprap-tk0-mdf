include <configuration.scad>

bearing_r = linear_bearing_radius + 0.1;

extr_shelf_arm_length = 80;
extr_shelf_arm_height = 8;
extr_shelf_height = 16;
extr_shelf_length_a = 32;
extr_shelf_length_b = 46;

mirror([0,1,0]){
	x_arm_v2();
}



module x_arm_v2(){

	arm_end_radius = linear_bearing_radius * 1.35;

	difference(){

		union(){

			arm(x_rod_spacing, arm_end_radius, bearing_r, 8);

			cylinder(r=arm_end_radius, h=3);
			translate([x_rod_spacing,0, 0])
				cylinder(r=arm_end_radius, h=3);

			translate([0, 0, 4])
				cylinder(r=arm_end_radius, h=23);
			translate([x_rod_spacing,0, 4])
				cylinder(r=arm_end_radius, h=23);

			translate([0, -arm_end_radius, 0])
				cube([x_rod_spacing, 3, 23]);
			
			hull(){

				translate([0, 0, 0])
					cylinder(r=arm_end_radius, h=extr_shelf_arm_height);
				translate([0,extr_shelf_arm_length, 0])
					cylinder(r=arm_end_radius, h=extr_shelf_arm_height);


			}

			hull(){

				translate([0, 0, extr_shelf_arm_height])
					cylinder(r=3, h=extr_shelf_height);
				translate([0,extr_shelf_length_a, extr_shelf_arm_height])
					cylinder(r=3, h=extr_shelf_height);


			}


			hull(){

				translate([0, extr_shelf_arm_length - 20, extr_shelf_arm_height])
					cylinder(r=3, h=extr_shelf_height);
				translate([0, extr_shelf_arm_length, extr_shelf_arm_height])
					cylinder(r=3, h=extr_shelf_height);


			}


			// belt clamp mount
			hull(){

				translate([x_rod_spacing / 2, 10, extr_shelf_arm_height])
					cylinder(r=2, h=extr_shelf_height);
				translate([x_rod_spacing / 2 + 14, 10, extr_shelf_arm_height])
					cylinder(r=2, h=extr_shelf_height);


			}

			// wiring clip
			hull(){

				translate([x_rod_spacing + 8, 6, 0])
					cylinder(r=2, h=extr_shelf_height);
				translate([x_rod_spacing + 18, 6, 0])
					cylinder(r=2, h=extr_shelf_height);


			}




		}
		
		translate([0,0,-1])
			cylinder(r=5, h=5);
		
		translate([x_rod_spacing,0,-1])
			cylinder(r=5, h=5);
	
		translate([0,0,4])
			#cylinder(r=bearing_r, h=25);
		
		translate([x_rod_spacing,0,4])
			#cylinder(r=bearing_r, h=25);


		#hull(){	
			translate([20, 0, -1])
				cylinder(r=8, h=18);
	
			translate([x_rod_spacing - 20,  0, -1])
				cylinder(r=8, h=18);
		}


		#hull(){	
			translate([12, 24, 4])
				cylinder(r=6, h=8);
	
			translate([12, extr_shelf_arm_length - 12, 4])
				cylinder(r=6, h=8);
		}


		#hull(){	
			translate([-12, 24, 4])
				cylinder(r=6, h=8);
	
			translate([-12, extr_shelf_arm_length - 12, 4])
				cylinder(r=6, h=8);
		}

		// M3 holes for plate
			translate([6, extr_shelf_arm_length - 10, 16])
				rotate([0,-90,0])
					#cylinder(r=2, h=10);
			
			translate([6, 22, 16])
				rotate([0,-90,0])
					#cylinder(r=2, h=10);
	

		// M3 hole for belt mount
			translate([x_rod_spacing / 2 + 7, 4, 16])
				rotate([-90,0,0])
					#cylinder(r=2, h=10);
		
		// M3 hole for wiring clip
			translate([x_rod_spacing + 15, 4, 8])
				rotate([-90,0,0])
					#cylinder(r=2, h=10);


	}

}


module arm(length, radius, hole_radius, height){
	
	linear_extrude(height=height){

		difference(){

			hull(){
		
				circle(r=radius);
				translate([length, 0])
					circle(r=radius);
			}	
	

			union(){
	
				circle(r=hole_radius);
				translate([length, 0])
					circle(r=hole_radius);
			

			}
		}
	}

}

