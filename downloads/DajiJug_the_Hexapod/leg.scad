//Author: Maarten Weyn maarten@wesdec.be 2013

include <..\openscad\libraries\hitec_servos.scad>
module leg(phi1 = 0, phi2 = 0, phi3 = 0)
{	
	rotate(phi1)
	{	
		translate([-20,14,-37])
		{

		coxa_femur_servo(phi2);

		coxa_top(phi2);
		coxa_bottom(phi2);

		rotate([90,0,0,])
		{
			rotate(phi2)
			{
				// Femur
				femur(true);
				translate([0,0,52]) femur(false);
		

				// Tibia
				translate([-26.6,95,14])
				rotate(-phi3) 
				{
					translate([-10,-294,0]) tibia_pin();
				
					translate([-29,-135,24]) tibia_counter();
					

					rotate([0,180,74.88]) translate([0,00,9]) color([0.3, 0.3, 0.3, 1])
					{
						Servo_Hitec_HS_645MG(false);
						translate([0,0,9]) rotate([0,0,-47]) Horn_Hitec_HD_LS();
					}
				}

			}
		}
		}
	}
}

module mleg(phi1 = 0, phi2 = 0, phi3 = 0)
{
	mirror([ 0, 1, 0 ]) leg(-phi1, phi2, phi3);
}

module coxa_top(phi2)
{
	difference()
	{
		union()
		{
			translate([10,-52,28.3]) cube([20, 56, 9]);
			translate([-12,-46,28.3]) cube([22, 40, 9]);			
			translate([-12,-46,28.3-44.3]) cube([22, 8, 44.3]);
		}

		coxa_femur_servo(phi2);
		translate([-10,-18.2,29]) cube([20, 6.5, 10]);
		translate([-1.5,-12,29]) cube([2, 3, 10]);
		translate([-5.5,0,34.5]) rotate([90,0,0])cylinder(h=15,r=1.6);
		translate([4.5,0,34.5]) rotate([90,0,0])cylinder(h=15,r=1.6);

		translate([25,0,25]) cylinder(h=15,r=1.6);
		translate([15,0,25]) cylinder(h=15,r=1.6);
		translate([25,-48,25]) cylinder(h=15,r=1.6);
		translate([15,-48,25]) cylinder(h=15,r=1.6);
		translate([25,0,34]) cylinder(h=4,r=3.5);
		translate([15,0,34]) cylinder(h=4,r=3.5);
		translate([25,-48,34]) cylinder(h=4,r=3.5);
		translate([15,-48,34]) cylinder(h=4,r=3.5);

		translate([19.5,-7,28]) cube([2, 12, 3]);
		translate([19.5,-55,28]) cube([2, 12, 3]);


		translate([0,-40,0]) rotate([90,0,0]) cylinder(h=10,r=1.5);
		translate([0,-33,0]) rotate([90,0,0]) cylinder(h=10,r=3);

		translate([-5,-20,-13]) rotate([90,0,0]) cylinder(h=30,r=1.5);
		translate([-5,-43,-13]) rotate([90,0,0]) cylinder(h=6,r=3.5);
	}
}

module coxa_bottom(phi2)
{
	difference()
	{
		union()
		{
			translate([16,-52,-16]) cube([14, 56, 12]);
			translate([-12,-38,-16]) cube([28, 32, 6]);
		}

		coxa_femur_servo(phi2);
		translate([-10,-18.2,-18]) cube([20, 6.5, 12]);
		translate([-1.5,-12,-18]) cube([3, 3, 12]);

		translate([-3,-39,-18]) cube([10, 7, 12]);

		
		translate([19.6,-14,-17]) cylinder(h=30,r=1.5);
		translate([19.6,-14,-7]) cylinder(h=6,r=3.5);

		translate([25,0,-18]) cylinder(h=30,r=1.6);
		translate([25,-48,-18]) cylinder(h=30,r=1.6);
		translate([25,0,-17]) cylinder(h=4,r=3);
		translate([25,-48,-17]) cylinder(h=4,r=3);

		translate([-5,-0,-13]) rotate([90,0,0]) cylinder(h=50,r=1.7);
		translate([5,-5,-13]) rotate([90,0,0]) cylinder(h=10,r=1.7);
		//translate([-10,-25,-18]) cube([6, 3, 12]);
	}
}

module coxa_femur_servo(phi2)
{
	translate([0,-5,0]) rotate([-90,90,0]) color([0.3, 0.3, 0.3, 1])
		{
			Servo_Hitec_HS_645MG(false);
			translate([0,0,9]) rotate([0,0,133-phi2]) Horn_Hitec_HD_LS();
		}

		translate([20,-14,33]) rotate([0,00,90])
		{
			color([0.3, 0.3, 0.3, 1]) Servo_Hitec_HS_485HB(false);
			color([1, 1, 1, 1]) translate([0,0,8]) Horn_Hitec_R_X();
		}
}

module femur(servoholes=false, mirrored=true)
{
	if (mirrored) mirror([0,0,1])
	difference()
	{
		translate([-83,-79,0])
		linear_extrude(height = 5, convexity = 2) import(file = "leg.dxf", layer = "femur");

		if (servoholes)
		{
			rotate(137) translate([0,0,4]) Horn_Hitec_HD_LS(false);
			rotate(137) translate([0,0,5]) Horn_Hitec_HD_LS(false);

			rotate(-99) translate([-89.4,-40.9,4]) Horn_Hitec_HD_LS(false);
			rotate(-99) translate([-89.4,-40.9,5]) Horn_Hitec_HD_LS(false);
		}
	}
}

module tibia_pin()
{
	difference()
	{
		linear_extrude(height = 5, convexity = 2) import(file = "leg.dxf", layer = "tibia");	
		translate([10,294,-9]) rotate([0,180,74.88]) Servo_Hitec_HS_645MG();
	}
}

module tibia_counter()
{
	difference()
	{
		linear_extrude(height = 8, convexity = 2) import(file = "leg.dxf", layer = "tibia_other_2");
		translate([29.4,134.7,-5]) cylinder(h=10, r=3, $fn=30);

		rotate([0,180,74.88]) translate([-138,7,33]) Servo_Hitec_HS_645MG(false);

		
		translate([31,121,5]) cylinder(h=4,r=3.5);
		translate([21,123.5,5]) cylinder(h=4,r=3.5);
		translate([43.2,166.6,5]) cylinder(h=4,r=3.5);
		translate([33.2,169.5,5]) cylinder(h=4,r=3.5);
	}	
}

// Print individual parts
// Left
//coxa_bottom();
//rotate([0,180,0]) coxa_top();

//translate([-40,0,5]) rotate([0,0,-30]) femur();
//rotate([0,180,0]) femur(true);

//translate([0,-200,0]) tibia_pin();
//rotate([0,180,0]) translate([-70,-100,0]) tibia_counter();

// Right
//mirror([1,0,0])coxa_bottom();
//rotate([0,180,0]) mirror([1,0,0]) coxa_top();

//mirror([1,0,0]) translate([-40,0,5]) rotate([0,0,-30]) femur();
//rotate([0,180,0]) mirror([1,0,0]) femur(true);

//mirror([1,0,0]) translate([0,-200,0])tibia_pin();
//mirror([1,0,0])rotate([0,180,0]) translate([-70,-100,0]) tibia_counter();
