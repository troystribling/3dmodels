//Author: Maarten Weyn maarten@wesdec.be 2013

include <..\openscad\libraries\hitec_servos.scad>

frame_width = 110;
frame_length = 200;
thickness = 5;
hole_width = 50;
arm_width= 30;
arm_length=37;

bold_thickness = 3;
connection_bold_thickness = 4;


module arm()
{
	difference()
	{
		union()
		{
			translate([-5,-arm_width/2, 0]) cube([arm_length-(arm_width/2) + 5, arm_width, thickness]);
			translate([arm_length-(arm_width/2),0, 0]) cylinder(r=arm_width/2, h=thickness, $fn=360);
		}

		translate([arm_length-(arm_width/2),0, -1]) cylinder(r=bold_thickness/2, h=thickness+2, $fn=360);
	}
}


module bodyframe( part1 = true, part2 = true)
{
translate([0,0,thickness/2]) 
	difference()
	{
		if (part1 && part2)
			cube([frame_width,frame_length,thickness], center=true);
		else if (part1)
			cube([frame_width,frame_length,thickness], center=true);
		else if (part2)
			translate([-frame_width/2,-arm_width/2, -thickness/2]) cube([frame_width,(frame_length + arm_width) / 2,thickness]);

		translate([-hole_width/2 , arm_width * 3/4,-1-thickness/2]) cube([hole_width,frame_length/2 - (7/4)* arm_width,thickness+2]);
		translate([-hole_width/2,arm_width-frame_length/2,-1-thickness/2]) cube([hole_width,frame_length/2 - 2* arm_width,thickness+2]);
	}

	if (part1)
	{
		translate([0,-frame_length/2,0]) rotate([0,0,-90]) arm();
		translate([(frame_width-arm_width)/2,-(frame_length-arm_width)/2,0]) rotate([0,0,-45]) arm();
		translate([-(frame_width-arm_width)/2,-(frame_length-arm_width)/2,0]) rotate([0,0,-135]) arm();
	}
	
	if (part2)
	{
		translate([frame_width/2,0,0]) rotate([0,0,  0]) arm();
		translate([-frame_width/2,0,0]) rotate([0,0,180]) arm();
		translate([(frame_width-arm_width)/2,(frame_length-arm_width)/2,0]) rotate([0,0,45]) arm();
		translate([-(frame_width-arm_width)/2,(frame_length-arm_width)/2,0]) rotate([0,0,135]) arm();
	}
}

module body(top=false, part1 = true, part2 = true)
{
difference()
{
	bodyframe(part1, part2);

	if (top)
	{
		
		translate([-(frame_width-arm_width)/2 - cos(45) *(arm_length-(arm_width/2)),-(frame_length-arm_width)/2 - sin(45) *(arm_length-(arm_width/2)),3])
		rotate(45) servo_hole();		
	

	translate([ -((frame_width-arm_width)/2 + arm_length),0, 3 ]) 
		rotate(0) servo_hole();

	translate([ -(frame_width-arm_width)/2 - cos(-45) *(arm_length-(arm_width/2)), (frame_length-arm_width)/2 - sin(-45) *(arm_length-(arm_width/2)), 3 ])  
		rotate(-45) servo_hole();

	translate([ (frame_width-arm_width)/2 - cos(135) *(arm_length-(arm_width/2)), -(frame_length-arm_width)/2 - sin(135) *(arm_length-(arm_width/2)), 3 ])  
	rotate(135) servo_hole();

	translate([ ((frame_width-arm_width)/2 + arm_length), 0, 3 ]) rotate(180)
		servo_hole();

	translate([ (frame_width-arm_width)/2 - cos(-135) *(arm_length-(arm_width/2)), (frame_length-arm_width)/2 - sin(-135) *(arm_length-(arm_width/2)), 3 ]) 
	 rotate(-135) servo_hole();
		
	}
}

}

module servo_hole()
{
	minkowski () 
	{
		Horn_Hitec_R_X(false); 
		cylinder(r=0.2, h=0.5);
	}
	translate([ 0, 0, -6 ]) cylinder(r=4.7, h=10);
}

module body_split_1(top)
{
	difference()
	{	
		body(top);

		translate ([-frame_width, -arm_width/2, 2]) cube([frame_width *2 , frame_length, thickness * 2]);
		translate ([-frame_width,arm_width/2 -5.2, -2]) cube([frame_width *2 , frame_length, thickness * 2]);
		translate ([frame_width /2 - 5.2,-arm_width/2, -2]) cube([frame_width *2 , frame_length, thickness * 2]);
		translate ([-frame_width *5/2 + 5.2,-arm_width/2, -2]) cube([frame_width *2 , frame_length, thickness * 2]);
		translate ([frame_width /2,-arm_width, -2]) cube([frame_width *2 , frame_length, thickness * 2]);
		translate ([-frame_width *5/2 ,-arm_width, -2]) cube([frame_width *2 , frame_length, thickness * 2]);
	
	}
}
module body_split_2(top)
{
	difference()
	{
		body(top, false, true);
		translate ([-frame_width/2+5, -frame_width*2 + 5 + arm_width, -3]) cube([frame_width-10  , frame_length-5, thickness ]);
	}
}

// Print individual parts
//Body Top
//body_split_1(true);
//body_split_2(true);

//Body Bottom
//body_split_1(false);
//rotate([0,180,0]) body_split_2(false); 


