
//include <common_components.scad>

include <z_components.scad>

module z_shelf_bearing(){ 

	bearing_holder = z_shelf_height - z_shelf_bearing_depth; 

	difference(){

		linear_extrude(height=10) z_shelf_2d(); 

		union(){	
			// hole for rod
			translate([z_shelf_rod_pos, 0, -1]){
				cylinder(h=z_shelf_height + 2, r=rod_radius);
			}
			
			// hole for bearing
			translate([z_shelf_bearing_pos, 0, bearing_holder]){
				cylinder(h=z_shelf_height, r=bearing_radius);
			}

			// hole for rod through bearing
			translate([z_shelf_bearing_pos, 0, -1]){
				cylinder(h=z_shelf_height + 2, r=bearing_radius - 2);
			} 

			// rod clamp bolt
			translate([-3.5,0,z_shelf_height/2])
				rotate([0, 90, 0])
					#rod_clamp_holes();
		}
	}

}


module z_top(){

	union(){
		z_shelf_bearing();
		translate([0, z_shelf_large_width/2 - 6, z_shelf_height - 0.1]) tab();
		translate([0, - (z_shelf_large_width/2 - 6 - tab_width - 6), z_shelf_height - 0.1]) tab();
	}



}

z_top();