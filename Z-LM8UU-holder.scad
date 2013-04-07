include <lm8uu-holder-slim_v1-1.scad>

// from LM8UU holder file
LM8UU_dia = 15.2;
body_wall_thickness = 5.6;

// from x_end 
x_end_length = 100; 

dowel_hole_from_centre = x_end_length / 2 - 9;

holder_base_to_rod_centre = LM8UU_dia / 2 + body_wall_thickness; 
x_end_base_to_rod_centre = 20;

holder_spacing = 24; 

z_rod_spacing = 30;

extra_height = z_rod_spacing - holder_base_to_rod_centre - x_end_base_to_rod_centre; 

echo(extra_height);

Z_LM8UU_holder();

module Z_LM8UU_holder(){

	difference(){

		union(){
			translate([0, holder_spacing, extra_height])
				 lm8uu_holder();
			
			translate([0, -holder_spacing, extra_height])
				 lm8uu_holder();

			linear_extrude(height=4)
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
	
	translate([0,0,(LM8UU_dia/2)+body_wall_thickness+extra_height])		
					rotate([90,0,0])
						cylinder(r=(LM8UU_dia/2), h=120, center=true);
}

// match hole from LM8UU holder
// nophead's polyhole module for better lm8uu-fit
module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}