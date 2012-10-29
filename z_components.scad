
z_shelf_depth = 77;
z_shelf_round_radius = 5;
z_shelf_small_width = 40;
z_shelf_large_width = 75;
z_shelf_height = 10;

z_shelf_bearing_pos = 50;
z_shelf_bearing_depth = 7;

z_shelf_rod_pos = 20; 

rod_radius = 4;
bearing_radius = 11;

tab_width = 13.5;

include <common_components.scad>

module z_shelf_2d() {

	hull(){	
		translate([z_shelf_depth - z_shelf_round_radius, z_shelf_small_width / 2]) 
			circle(r=z_shelf_round_radius);	
		translate([z_shelf_depth - z_shelf_round_radius, -z_shelf_small_width / 2])
			circle(r=z_shelf_round_radius);	
		polygon(points=[
			[0, z_shelf_large_width/2], 
			[z_shelf_depth, z_shelf_small_width/2 ],
			[z_shelf_depth, -z_shelf_small_width/2 ],
			[0, -z_shelf_large_width/2],
		]);
	}

}

//z_shelf_2d();

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





//z_shelf_bearing();
//translate([0, z_shelf_large_width/2 - 6, z_shelf_height]) tab();
//translate([0, - (z_shelf_large_width/2 - 6 - tab_width - 6), z_shelf_height]) tab();

module tab() {

		rotate([90,0,0]) 
		difference() {
			union() {
				cube([4,tab_width,20]);
				translate([4,0,0]) linear_extrude(height=3) polygon(points=[[0,0],[0,10],[10,0]]);
				translate([4,0,17]) linear_extrude(height=3) polygon(points=[[0,0],[0,10],[10,0]]);
		}
		translate([-1,5,10]) rotate([0,90,0]) cylinder(r=2.6, h=6);
	}

}