
module rod_clamp_holes(){

	bolt_head_radius = 3.5;
	bolt_shaft_radius = 1.55;
	depth = 20; 
	nut_depth = 8.5; 
	nut_radius = 2.0; 

	cylinder(h=depth, r=bolt_shaft_radius, $fn=50);

	cylinder(h=4, r=bolt_head_radius);

	translate([-nut_depth, -5.7/2, nut_depth]) 
		cube([nut_depth + nut_radius +2 , 5.7, 3.2]);

}

//rod_clamp_holes();




module warp_prevention(){

	translate([-100,-100,0]){
		for(i = [0:20:200]){
	
			translate([i, 0, 0])
				cube([2, 200, 2]);
	
			translate([0, i, 0])
				cube([200, 2, 2]);
	
		}
	}

}

module teardrop_cylinder(r, h){

	linear_extrude(height=h){
		hull(){
	
			circle(r=r);
			translate([-r * 1.25, 0])
				circle(r=1);
	
		}
	}
}
