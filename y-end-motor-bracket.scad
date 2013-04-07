//y_end_motor_bracket();

module y_end_motor_bracket(){

	bracket_thickness = 6;

	union(){
	
		linear_extrude(height=bracket_thickness)
			y_end_motor_bracket_2d();
	
		translate([0,-(23), 6 - 0.1])
			rotate([90,0,0])
				linear_extrude(height=bracket_thickness/2)
					y_end_motor_bracket_support_2d();
	
		translate([0, 26, 6 - 0.1])
			rotate([90,0,0])
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
 