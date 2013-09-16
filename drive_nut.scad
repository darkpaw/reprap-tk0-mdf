include <configuration.scad>

drive_nut();

module drive_nut(){

	z_rod_radius = z_threaded_rod_radius;

	nut_length = 12;
	drive_nut_radius = 10.75;  // slightly smaller than the hole for it in X ends

	m8_nut_length = 6;
	m8_nut_radius = 15 / 2;

	difference(){


		translate([0, 0, 0])
			cylinder(r=drive_nut_radius, h=nut_length, $fn=6);

		translate([0, 0, nut_length - m8_nut_length])
			cylinder(r=m8_nut_radius, h=nut_length, $fn=6);
	
		translate([0, 0, -1])
			cylinder(r=z_rod_radius + 0.1, h=nut_length+2, $fn=60);

	}

}