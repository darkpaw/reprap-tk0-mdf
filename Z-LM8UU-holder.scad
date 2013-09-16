use <lm8uu-holder-slim_v1-1.scad>
include <configuration.scad>


// from LM8UU holder file
//LM8UU_dia = 15.2; 

body_wall_thickness = 5.6;

// from x_end 
x_end_length = 100;  

dowel_hole_from_centre = x_end_length / 2 - 9;

holder_base_to_rod_centre = 12.6;


holder_spacing = 24; 

z_rod_spacing = z_threaded_to_smooth_spacing;  // from config
bearing_centre_height = z_rod_spacing - x_end_threaded_rod_height; 

holder_z = bearing_centre_height - holder_base_to_rod_centre;

Z_LM8UU_holder();

module Z_LM8UU_holder(){

	difference(){

		union(){
			translate([0, holder_spacing, holder_z])
				 lm8uu_holder();
			
			translate([0, -holder_spacing, holder_z])
				 lm8uu_holder();

			linear_extrude(height=holder_z + 8)
				base_2d();
		}

		#LM8UU_hole();

		for(dir = [1,-1])
			translate([0, dir * dowel_hole_from_centre, -1])
				#cylinder(r=4, h=20);

		translate([-20,-60,-10])
			cube([40,120, 10]);

	}
}


module base_2d(){

	round_radius = 6;
	half_width = 7.5;
	half_height = 50;

	difference(){
		
		hull(){
	
			for(w=[1,-1])
				for(h=[1,-1])
					translate([half_width*w, half_height*h-round_radius*h])
						circle(r=round_radius); 
			
		}
	
	}


}

module LM8UU_hole(){
	
	translate([0,0,bearing_centre_height])		
					rotate([90,0,0])
						cylinder(r=(linear_bearing_radius), h=120, center=true);
}
