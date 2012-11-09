	
include <common_components.scad>

y_rod_height = 70;
rod_radius = 4;
screw_radius = 1.75;


//y_end_2d();

// rotate for printing

difference(){

	rotate([90,0,0]) 
		y_end(); 


	rotate([0,0,45]) 
		warp_prevention();

	translate([sqrt(200),0,2])
		rotate([0,0,45]) 
			warp_prevention();


}

// no rotate for viewing
//y_end(); 

module y_end(){



	difference(){
	
		union(){
			linear_extrude(height=80)
				y_end_2d();

			translate([0, 0, 0]){
				linear_extrude(height=4)
					scale([1.65, 1.65])
						y_end_2d();
			}

		}


		translate([-50, -40, -5])
			#cube([100,40, 90]);
	
	
		//translate([-50, 16, -1])
		//	#cube([150,100, 40]);

		for(x = [17, -17]){ 			
			translate([x, 8, -1])
				#cylinder(r=screw_radius, h=6);
		}

		for(x = [12, -12]){ 			
			translate([x, 25, -1])
				#cylinder(r=screw_radius, h=6);
		}

	
		// y rods
		translate([0, 35, y_rod_height])
			rotate([90,0,0])
				#cylinder(r=rod_radius, h=60);
		
		translate([20, 8, y_rod_height])
			rotate([90,180,270])
				#rod_clamp_holes();

		translate([-30, 8, 25])
			rotate([-90,0,0])
				rotate([0,90,0])
					#teardrop_cylinder(r=rod_radius, h=60);
	
		translate([-30, 8, 50])
			rotate([-90,0,0])
				rotate([0,90,0])
					#teardrop_cylinder(r=rod_radius, h=60);



	}


}

module y_end_2d(){


	hull(){
		
		translate([-9, 0])
			circle(r=5);

		translate([9, 0])
			circle(r=5);

		translate([-6, 15])
			circle(r=5);

		translate([6, 15])
			circle(r=5);


	}

}