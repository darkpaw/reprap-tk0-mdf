include <configuration.scad>

rod_spacing = x_rod_spacing;

//! x_endstop_bumper();

scale([1.015, 1.015, 1.015]){
	rotate([0,180,0]){
		translate([0,0,-10]){
			x_endstop(1);
		}
	}
}

module x_endstop_bumper(){
	rotate([90,0,0])
		linear_extrude(height=20)
			polygon( points=[[0,0],[12,0],[12,12]]);

}



module x_endstop(for_x_axis=0){

	union(){
	
		difference(){
	
			union(){
				
				hull(){
	
					cylinder(r=8, h=10, $fn=20);
					translate([rod_spacing, 0, 0])
						cylinder(r=8, h=10, $fn=20);
	
					translate([0, -6, 0]){
					cylinder(r=8, h=10, $fn=20);
					translate([rod_spacing, 0, 0])
						cylinder(r=8, h=10, $fn=20);
					}
				}
	
				hull(){
	
					cylinder(r=8, h=10, $fn=20);
					translate([0, 12, 0])
						cylinder(r=8, h=10, $fn=20);
	
				}
		
	
			}
	
			union(){
	
				translate([0,0,-1]){
	
					#cylinder(r=4.2, h=12, $fn=20);
					translate([-3.8,0,0])
						#cube([7.6,20,12]);
	
					translate([rod_spacing, 0, 0]){
						#cylinder(r=4.2, h=12, $fn=20);
						translate([-3.8,0,0])
							#cube([7.6,20,12]);
	
					}
	
					translate([16, -1, 0]){
						hull(){
	
							#cylinder(r=8, h=12, $fn=20);
							translate([rod_spacing - 32, 0, 0])
								#cylinder(r=8, h=12, $fn=20);
	
							translate([0, 16, 0]){
								#cylinder(r=8, h=12, $fn=20);
								translate([rod_spacing - 32, 0, 0])
									#cylinder(r=8, h=12, $fn=20);
							}
						}
	
					}
	
					translate([6, -15, 0]){
						#cube([5,3,12]);
					}
	
					translate([16, -15, 0]){
						#cube([19,3,4]);
					}
					
					if(!for_x_axis){
		
						translate([46, -15, 0]){
							#cube([40,40,13]);		
						}	
					}
	
				}
				
				translate([-10, 8, 5])
				rotate([0,90,0])
				#cylinder(r=1.6, h=20);
	
				translate([16, -4, 7])
				rotate([90,90,0])
				#cylinder(r=1.6, h=20);
	
				translate([35, -4, 7])   // 19mm spacing for pcb holes
				rotate([90,90,0])
				#cylinder(r=1.6, h=20);
	
				
	
	
	
			}
	
		}  // end diff
	
		if(!for_x_axis){
				translate([46, -10, 0])
				cylinder(r=4, h=10, $fn=20);
		}

	}    // end outer union

}

