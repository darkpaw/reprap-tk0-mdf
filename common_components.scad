
module rod_clamp_holes(){

	bolt_head_radius = 3.5;
	bolt_shaft_radius = 1.55;
	depth = 20; 
	nut_depth = 11; 
	nut_radius = 2.0; 

	cylinder(h=depth, r=bolt_shaft_radius, $fn=50);
	cylinder(h=7, r=bolt_head_radius);
		translate([-nut_depth, -5.7/2, nut_depth]) 
			cube([nut_depth + nut_radius +2 , 5.7, 3.2]);

}

//rod_clamp_holes();