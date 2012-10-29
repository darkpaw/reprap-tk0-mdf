

linear_extrude(height=25){
	
	difference(){
	
		hull(){
			
			circle(r=20);
			
			translate([50,0])
					circle(r=10);
		
		}
	
	
		translate([50,0])
				circle(r=4);
		
	
		circle(r=4);
	
	
	}

}