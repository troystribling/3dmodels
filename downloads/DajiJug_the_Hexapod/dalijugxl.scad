//Author: Maarten Weyn maarten@wesdec.be 2013

include <..\openscad\libraries\hitec_servos.scad>
include <leg.scad>
include <body.scad>

module dalijug(pos)
{
	translate([-(frame_width-arm_width)/2 - cos(45) *(arm_length-(arm_width/2)),-(frame_length-arm_width)/2 - sin(45) *(arm_length-(arm_width/2)),-1])
		rotate(45)	mleg(pos[1][0], pos[1][1], pos[1][2]);

	translate([ ((frame_width-arm_width)/2 + arm_length), 0, -1 ]) rotate(180)
		leg(pos[5][0], pos[5][1], pos[5][2]);

	translate([ -((frame_width-arm_width)/2 + arm_length),0, -1 ]) 
		rotate(0) mleg(pos[2][0], pos[2][1], pos[2][2]);

	translate([ -(frame_width-arm_width)/2 - cos(-45) *(arm_length-(arm_width/2)), (frame_length-arm_width)/2 - sin(-45) *(arm_length-(arm_width/2)), -1 ])  
		rotate(-45) mleg(pos[3][0], pos[3][1], pos[3][2]);

	translate([ (frame_width-arm_width)/2 - cos(135) *(arm_length-(arm_width/2)), -(frame_length-arm_width)/2 - sin(135) *(arm_length-(arm_width/2)), -1 ])  
	rotate(135) leg(pos[4][0], pos[4][1], pos[4][2]);	

	translate([ (frame_width-arm_width)/2 - cos(-135) *(arm_length-(arm_width/2)), (frame_length-arm_width)/2 - sin(-135) *(arm_length-(arm_width/2)), -1 ]) 
	rotate(-135) leg(pos[6][0], pos[6][1], pos[6][2]);	

translate([ 0, 0, 0 ]) body(true);
translate([ 0, 0, -60 ]) body(false);
}


// Soruce of annimation: http://www.thingiverse.com/thing:1604
if ($t == 0)
	dalijug([
		[ 0, 0 ],
		[ 0, 30, 40 ],
		[ 0, 30, 40 ],
		[ 0, 30, 40 ],
		[ 0, 30, 40 ],
		[ 0, 30, 40 ],
		[ 0, 30, 40 ],
	]);

include <testdata.scad>;
if ($t > 0)
	dalijug(spider_config($t));
