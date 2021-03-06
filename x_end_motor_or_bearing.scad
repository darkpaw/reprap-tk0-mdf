
include <common_components.scad>
include <configuration.scad>

x_end_length = 100;
x_end_width = 56;
x_end_thickness = 8;
x_rod_spacing = 70;
rod_inset = 12;
bearing_mount_width = 14;
motor_mount_width = 5;
half_belt_gap_length = 20;
 
// threaded rod mount
rod_height = x_end_threaded_rod_height - x_end_thickness;
rod_mount_thickness = 26;
   
bearing_bolt_height = 12;

// testing

//rod_clamp_holes(); 
//x_end_base();
//x_end_base_2d();
//x_end_rod_mount_2d(); 
//threaded_rod_mount(); 
//bearing_mount_2d();
//bearing_mount();
//x_end_motor_bracket_2d();

//mirror([1,0,0]) x_end_with_bearing_or_motor(1);

x_end_with_bearing_or_motor(0);
!x_end_with_bearing_or_motor(1);
mirror([0,1,0]) x_end_base_v2();
bearing_mount_2d();
bearing_mount();



module bearing_mount(){
	
	difference(){

		linear_extrude(height=bearing_mount_width){
			bearing_mount_2d();
		}
		
		translate([0,bearing_bolt_height,-1])
			rotate([0,0,90])
				#cylinder(r=7.5, h=4, $fn=6);

	}
}

module bearing_mount_2d(){

	bolt_radius = 4;
	bolt_height = 12;
	radius = 10.0;

	difference(){
			
		hull(){
	
			translate([0, bearing_bolt_height ])
				circle(r=radius);
			polygon(points = [[radius,-15], [0, rod_height],[-radius, -15]]);
	
		}

		#translate([0, bearing_bolt_height ])
			circle(r=bolt_radius, $fn=50);
	
	}

}


module x_end_base_v2(){
	
	w = x_end_length / 2 - 4;
	h = x_end_width / 2 - 4;
	
	minkowski(){
		
		linear_extrude(height=x_end_thickness){
			polygon(points=[
					[-w,-h], 
					[-w,h],
					[w,h],
					[w,-h],
					[20,-h],
					[20,-(h+10)],
					[-20,-(h+10)],
					[-20,-h]
			]); 
		}	
		
		cylinder(r=4, h=0.1);

	}

}


module wiring_support(){

	wiring_hole_radius = 4;
	
	difference(){
			
		hull(){
	

			circle(r=wiring_hole_radius);

			translate([wiring_hole_radius * 3, 0])
				circle(r=wiring_hole_radius);
	
		}

		#translate([0, wiring_hole_radius*3])
			circle(r=wiring_hole_radius, $fn=50);
	
	}

}

module x_end_with_bearing_or_motor(motor=1){

	rod_pos = x_rod_spacing / 2;

	difference(){
	
		union(){
		
			// base
			//linear_extrude(height=x_end_thickness)
			//	x_end_base_2d();
			mirror([0,1,0]) x_end_base_v2();

			// X rod mounts
			translate([rod_pos, x_end_width / 2, x_end_thickness])
				linear_extrude(height=x_end_thickness+3)
					rotate([0,0,180])
						x_end_rod_mount_2d();
				
	
			translate([-rod_pos, x_end_width / 2, x_end_thickness])
				linear_extrude(height=x_end_thickness+3)
					rotate([0,0,180])
						x_end_rod_mount_2d();
	
			
			// bearing/motor mount base
			translate([-rod_pos+6.5, x_end_width / 2 - rod_inset, x_end_thickness])
				cube(size=[x_rod_spacing-13, rod_inset, x_end_thickness], center=false);

			if(motor==1){		
				// motor mount
				translate([0, x_end_width / 2, x_end_thickness * 2 - 0.1])	{	

					rotate([90,-90,0])
						linear_extrude(height=motor_mount_width)
							x_end_motor_bracket_2d();
					
					translate([25, -5, 0])
						cylinder(r=5, h = 36);

					translate([-25, -5, 0])
						cylinder(r=5, h = 36);
						//cube([5, 10, 35], center=true);
				}
				

			} else {	
				// bearing mount
				translate([0, x_end_width / 2 + 10, x_end_thickness * 2 - 0.1])		
					rotate([90,0,0])
						bearing_mount();
			}

			// threaded rod nut and spring mounting
			translate([-10, -x_end_width / 2 +rod_mount_thickness/2, x_end_thickness - 0.1])
				rotate([90,0,90])
					threaded_rod_mount();


		}
		
		// extra room for bearing and idler pulley/belt
		if(motor==0){		

				translate([0, x_end_width / 2 - 3.9, x_end_thickness * 2 - 0.1 + 12])
					rotate([90, 0, 0])
						#cylinder(r=18, h=12);
		}

		// hole
		translate([0,0,-1])
			#linear_extrude(height=x_end_thickness+2)
				hull(){
					translate([-half_belt_gap_length, x_end_width/2 - rod_inset - 9])
						circle(r=7);
	
					translate([half_belt_gap_length, x_end_width/2 - rod_inset - 9])
						circle(r=7);
				}
					
				
		// holes for 'dowels' to join LM8UU mount
		translate([0,0,-1])
			#linear_extrude(height=x_end_thickness+2){
				translate([-x_end_length / 2 + 9, - x_end_width/2 + rod_mount_thickness/2])
					circle(r=4, $fn=30);
	
				translate([x_end_length / 2 - 9, - x_end_width/2 + rod_mount_thickness/2])
					circle(r=4, $fn=30);
			}
			

		// X rod holes through base
		#translate([rod_pos, x_end_width / 2 - rod_inset, -1])
			linear_extrude(height=x_end_thickness+2)
				circle(r=rod_radius, $fn=30);
	
		translate([-rod_pos, x_end_width / 2 - rod_inset, -1])
			linear_extrude(height=x_end_thickness+2)
				circle(r=rod_radius, $fn=30);	

		// hole and nut trap for rod clamps
		translate([-x_end_length / 2 - 5, x_end_width / 2 - rod_inset, x_end_thickness/2])
			rotate([90,90,90])
				#rod_clamp_holes();

		translate([x_end_length / 2 + 5, x_end_width / 2 - rod_inset, x_end_thickness/2])
			rotate([90,90,-90])
				#rod_clamp_holes();

	}

}


module x_end_motor_bracket_2d(){

	bracket_depth = 40;
	motor_centre = 20;
	bracket_round_radius = 5;

	bracket_width = 60;
	bracket_small_width = 40;

	stepper_bolt_hole = 1.55;
	stepper_bolt_hole_offset = 31/2;

	difference(){
	
		hull(){	
			translate([bracket_depth - bracket_round_radius, bracket_small_width / 2]) 
				circle(r=bracket_round_radius);	
			translate([bracket_depth - bracket_round_radius, -bracket_small_width / 2])
				circle(r=bracket_round_radius);	
			polygon(points=[
				[0, bracket_width/2], 
				[bracket_depth, bracket_small_width/2 ],
				[bracket_depth, -bracket_small_width/2 ],
				[0, -bracket_width/2],
			]);
		}

		translate([motor_centre, 0])
				circle(r=12);	

		// holes for stepper bolts
		#translate([motor_centre - stepper_bolt_hole_offset, stepper_bolt_hole_offset])
			circle(r=stepper_bolt_hole, $fn=50);
		#translate([motor_centre + stepper_bolt_hole_offset, stepper_bolt_hole_offset])
			circle(r=stepper_bolt_hole, $fn=50);
		#translate([motor_centre - stepper_bolt_hole_offset, -stepper_bolt_hole_offset])
			circle(r=stepper_bolt_hole, $fn=50);
		#translate([motor_centre + stepper_bolt_hole_offset, -stepper_bolt_hole_offset])
			circle(r=stepper_bolt_hole, $fn=50);


	}
}
 


module threaded_rod_mount(){

	rod_mount_length = 46;
	nut_length = 12;
	nut_base = 5;
	nut_gap = 13;
	nut_radius = 11.5;

	difference(){

		linear_extrude(height=rod_mount_length){
			threaded_rod_mount_2d();
		}

		translate([-20, -1, nut_length + nut_base])
			cube([40,40, nut_gap]);

		#translate([0, rod_height, nut_base])
			cylinder(r=nut_radius, h=nut_length+1, $fn=6);

		// inset for spring
		#translate([0, rod_height, nut_base + nut_length])
			cylinder(r=nut_radius-3, h=nut_length+3, $fn=60);

		#translate([0, rod_height, -1])
			cylinder(r=rod_radius + 2, h=rod_mount_length + 2, $fn=60);
	
		#translate([-rod_mount_thickness, rod_height + rod_mount_thickness / 2, rod_mount_length])
			rotate([0,90,0])
				cylinder(r=rod_mount_thickness / 2, h=rod_mount_thickness *2, $fn=60);


	}
	

}

module threaded_rod_mount_2d(){
	
	

	difference(){
			
		hull(){
	
			translate([0, rod_height])
				circle(r=rod_mount_thickness/2);
			polygon(points = [[rod_mount_thickness/2,0], [0, rod_height],[-rod_mount_thickness/2, 0]]);
	
		}

	}

}


module x_end_base(){
	
	linear_extrude(height=10)
		x_end_base_2d();

}


module x_end_rod_mount_2d(){

	rod_end_height = rod_inset;
	rod_end_width = rod_radius * 2 + 9;  //16.5; 

	difference(){

		hull(){
			translate([0, rod_end_height])
				circle(r=rod_end_width / 2);
			polygon(points = [[rod_end_width/2,0], [0, rod_end_height],[-rod_end_width/2, 0]]);
		}
		
		#translate([0, rod_end_height])
			circle(r=rod_radius, $fn=30);
	}

}


module x_end_base_2d(){

	round_radius = 8;
	corner_centres_x = x_end_length / 2 - round_radius;
	corner_centres_y = x_end_width / 2 - round_radius;
	
	difference(){

		hull(){
			translate([corner_centres_x, corner_centres_y])
				circle(r=round_radius);
			translate([corner_centres_x, -corner_centres_y])
				circle(r=round_radius);
			translate([-corner_centres_x, corner_centres_y])
				circle(r=round_radius);
			translate([-corner_centres_x, -corner_centres_y])
				circle(r=round_radius);
			
		}
		


	}

}
