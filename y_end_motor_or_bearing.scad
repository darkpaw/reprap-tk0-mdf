	
include <common_components.scad>
include <y-end-motor-bracket.scad>

y_rod_height = 70;
rod_radius = 4;
screw_radius = 1.75;

// testing
//y_end_2d();
//teardrop_cylinder(5, 50);
//rail_mount();
//bearing_mount_2d();


// parts
//y_end_motor_mount(); 
//!y_end_bearing_mount(); 



module bearing_mount_2d(){


	difference(){
	
		hull(){
			
			translate([0, 0])
				circle(r=9);
	
			rotate([0,0,180])
				translate([10, 0])
					square([17, 17],  center=true);
	
	
		}

		circle(r=4);

	}

}

module y_end_bearing_mount(){



	difference(){ 
	
		union(){ 
			
			translate([0, -2, 0])
				rail_mount();
			translate([0, -12, 0])
				rotate([0,0,-90])	
					linear_extrude(height=15)
						bearing_mount_2d();

		}

	
		//translate([-35, -20, 26])
//			rotate([0,90,0])
//				#cylinder(r=16, h=70);
	

		// hex nut m8 = 15mm
		translate([0, -12, 8])
			#cylinder(r=7.5, h=10, $fn=6);
		

		translate([-35, 5, 8])
			rotate([0,90,0])
				#teardrop_cylinder(r=rod_radius, h=70);
	
		translate([-35, 5, 33])
			rotate([0,90,0])
				#teardrop_cylinder(r=rod_radius, h=70);


	}


}

module y_end_motor_mount(){



	difference(){ 
	
		union(){ 
			
			translate([22, -2, 0])
				rail_mount();
			translate([-22, -2, 0]) 
				rail_mount();
			translate([0, 0, 0])
				rotate([0,0,-90])	
					y_end_motor_bracket();

		}

	
		translate([-35, 5, 8])
			rotate([0,90,0])
				#teardrop_cylinder(r=rod_radius, h=70);
	
		translate([-35, 5, 33])
			rotate([0,90,0])
				#teardrop_cylinder(r=rod_radius, h=70);


	}


}



 
module rail_mount(){

	linear_extrude(height=45)
		rail_mount_2d();
		

}

module rail_mount_2d(){


	hull(){
		
		translate([4, 10])
			circle(r=4);

		translate([-4, 10])
			circle(r=4);

		translate([-6, 4])
			circle(r=4);

		translate([6, 4])
			circle(r=4);


	}

}