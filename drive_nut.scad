


drive_nut();

module drive_nut(){

	rod_radius = 4;

	nut_length = 12;

	// printed and was press fit
	//nut_radius = 11.25;  // hole is 11.5 r


	nut_radius = 10.75;  // hole is 11.5 r

	m8_nut_length = 6;
	m8_nut_radius = 15 / 2;

	difference(){


		translate([0, 0, 0])
			cylinder(r=nut_radius, h=nut_length, $fn=6);

		translate([0, 0, nut_length - m8_nut_length])
			cylinder(r=m8_nut_radius, h=nut_length, $fn=6);
	
		translate([0, 0, -1])
			cylinder(r=rod_radius + 0.1, h=nut_length+2, $fn=60);

	}

}