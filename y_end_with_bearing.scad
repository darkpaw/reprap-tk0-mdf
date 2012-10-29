
//include <z_components.scad>

y_rod_height = 40;
y_rod_spacing = 150;

rod_radius = 4;
rod_end_width = rod_radius*2 + 8;
rod_end_height = rod_radius*2 + 6;


module y_end_base(){
	//y_end();
	translate([0,0,10])
		y_rod_end();
	
	linear_extrude(height=10)
		y_end_base_2d();

}


module y_end_with_motor(){
	union(){

		y_end_base();

		translate([y_rod_height - 8, 0, 9.9])
			rotate([0,-90,0])
				y_end_motor_bracket();
	}
}


//y_end_motor_bracket();
y_end_with_motor();

module y_end_motor_bracket(){

	bracket_thickness = 6;

	union(){
	
		linear_extrude(height=bracket_thickness)
			y_end_motor_bracket_2d();
	
		translate([0,-(24),0])
			rotate([-90,0,0])
				linear_extrude(height=bracket_thickness/2)
					y_end_motor_bracket_support_2d();
	
		translate([0,20 ,0])
			rotate([-90,0,0])
				linear_extrude(height=bracket_thickness/2)
					y_end_motor_bracket_support_2d();
	}

}

module y_end_motor_bracket_support_2d(){

	support_thickness = 4;
	support_height = 20;

	hull(){
		polygon(points = [[0,0], [0,support_height], [support_height * 1.2,0]]);
		translate([support_height, support_height * 0.62 - 2]) 
			circle(r=4);
		}
}


module y_end_motor_bracket_2d(){

	bracket_depth = 49;
	motor_centre = 24;
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
				circle(r=bracket_round_radius);	

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
 

module y_rod_end_2d(){

	difference(){

		hull(){
			translate([rod_end_height, 0])
				circle(r=rod_end_width / 2);
			polygon(points = [[0,rod_end_width/2], [rod_end_height,0],[0,-rod_end_width/2]]);
		}
		
		#translate([rod_end_height,0])
			circle(r=rod_radius);
	}

}



module y_rod_end(){

	//	rotate([0,-90,0]) z_bottom();
	linear_extrude(height=8){
		translate([y_rod_height - rod_end_height, -y_rod_spacing/2])
			y_rod_end_2d();
		translate([y_rod_height - rod_end_height, +y_rod_spacing/2])
			y_rod_end_2d();
	}
}

module y_end_base_2d(){

	edge_to_midpoint = y_rod_spacing/2;
	base_inset = -24;

	difference(){

		hull(){
			translate([y_rod_height + 6, -edge_to_midpoint])
				circle(r=rod_end_width / 2);
			translate([y_rod_height + 6, edge_to_midpoint])
				circle(r=rod_end_width / 2);
			polygon(points = [[0,edge_to_midpoint-base_inset], [rod_end_height,0],[0,-edge_to_midpoint+base_inset]]);
		}
		
		hull(){
			translate([y_rod_height, -0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 2);
			translate([y_rod_height, -0.522 * edge_to_midpoint])
				circle(r=rod_end_width / 2);

		}

		hull(){
			translate([y_rod_height, 0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 2);
			translate([y_rod_height, 0.522 * edge_to_midpoint])
				circle(r=rod_end_width / 2);

		}


		hull(){
			translate([y_rod_height / 2, -0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 4);
			translate([y_rod_height / 2, 0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 4);

		}


		hull(){
			translate([0, -0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 2);
			translate([0, 0.722 * edge_to_midpoint])
				circle(r=rod_end_width / 2);

		}

		translate([y_rod_height, -y_rod_spacing/2])
			circle(r=rod_radius);

		translate([y_rod_height, +y_rod_spacing/2])
			circle(r=rod_radius);

	}

}
