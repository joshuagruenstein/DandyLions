include <puzzle.scad>

res = 200;

thickness = 0.25;

kerf = 0.00;
kerf_2 = kerf / 2;

width = 10;
length = 10;
height = 6;

wheel_diameter = 3;
screw_diameter = 0.125;
wheel_stack = 2;
wheel_location = 2.3;

module FrontPlate_2d(is_square) {
	InterlockingPlate(width,height,0,0,0,1,0.25);
}

module LeftPlate_2d() {
	difference() {
        InterlockingPlate(length,height,0,0,0,1,0.25);
        translate([length/2,height*.8]) PingSensor_2d();
    }
}

module RightPlate_2d() {
    difference() {
        InterlockingPlate(length,height,0,1,1,0,0.25);
        translate([length/2,height*.8]) PingSensor_2d();
    }
}

module BackPlate_2d() {
	difference() {
		InterlockingPlate(width,height,0,1,0,1,0.25);
        translate([width/2,height*.8]) PingSensor_2d();
	}
}

module PingSensor_2d() {
	translate([-0.495, 0]) circle(.315, $fn=res);
	translate([0.495, 0]) circle(.315, $fn=res);
}

module MotorMount_2d() {
	motor_mount_length = 2.52;
    motor_mount_width = 0.5;

	translate([motor_mount_width/2,-motor_mount_length/2]) union() {
		circle(screw_diameter/2, $fn=res);
        translate([0,motor_mount_length]) circle(screw_diameter/2, $fn=res);
	}
}

module BottomPlate_2d() {
	difference() {
    	InterlockingPlate(width,length,1,0,1,1);
        
        Motor_Set_2d(wheel_location);
        Motor_Set_2d(length-wheel_location);

	}
}

module Motor_Set_2d(loc) {
    wall_dist = 1.75;
    axle_length = 0.7;
    wheel_width = 0.75;
    
    translate([wall_dist,loc,0]) MotorMount_2d();
    translate([width-wall_dist,loc]) rotate(180) MotorMount_2d();

    translate([wall_dist-axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
    translate([width-wall_dist+axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
}

module TopPlate_2d() {
    InterlockingPlate(width,length,1,1,0,1);
}

module Wheel_2d() {
    bolt_circle = 0.63;
    shaft_diameter = 0.25;

    bump_angle = 5;
    bump_scale = 0.0125;

	difference() {
		circle(wheel_diameter/2, $fn=res);

        for (i=[0:bump_angle:360-bump_angle]) {
            translate([wheel_diameter*cos(i)/2,wheel_diameter*sin(i)/2]) circle(bump_scale*wheel_diameter, $fn=res);
        }

        translate([bolt_circle/2,0]) circle(screw_diameter/2,$fn=res);
        translate([-bolt_circle/2,0]) circle(screw_diameter/2,$fn=res);
        translate([0,bolt_circle/2]) circle(screw_diameter/2,$fn=res);
        translate([0,-bolt_circle/2]) circle(screw_diameter/2,$fn=res);
        circle(shaft_diameter/2,$fn=res);
	}
}


module CheckLayout_3d() {
	color([1,0,0]) translate([0,0,0.25]) linear_extrude(height=thickness) BottomPlate_2d();

	color([0,1,0]) translate([0,thickness,0]) rotate([90,0,0]) linear_extrude(height=thickness) FrontPlate_2d(true);

	color([0,0,1]) translate([width-thickness,0,0]) rotate([90,0,90]) linear_extrude(height=thickness) LeftPlate_2d();

	color([1,1,0]) translate([width,length-thickness,0]) rotate([90,0,180]) linear_extrude(height=thickness) BackPlate_2d();

	color([1,0,1]) translate([0,0,0]) rotate([90,0,90]) linear_extrude(height=thickness) RightPlate_2d();

	color([0,1,1]) translate([0,0,height-thickness]) linear_extrude(height=thickness) TopPlate_2d();

	Wheel_Pair_3d(wheel_location);
    Wheel_Pair_3d(length-wheel_location);
}

module Wheel_Pair_3d(loc) {
    axle_height = 0.16 + 0.47;

    color([1,1,1]) {
			translate([thickness+0.8,loc,axle_height+.25+thickness]) rotate([90,0,90]) linear_extrude(height=thickness*wheel_stack,center=true) Wheel_2d();

			translate([width-thickness-0.8,loc,axle_height+.25+thickness]) rotate([90,0,90]) linear_extrude(height=thickness*wheel_stack,center=true) Wheel_2d();
	}
        
    translate([1.75,loc-1.41,0.5]) Motor_Pair_3d();
    translate([width-1.75,loc+1.42,0.5]) rotate([0,0,180]) Motor_Pair_3d();
}

module Motor_Pair_3d() {
    indent = 0.2;
    
    color([0.6,0.6,0.6]) rotate([90,0,90]) scale(0.0393701) import("tetrix/motor_mount.stl");
    
    translate([2.67-indent,0.68,0.15]) color([0.8,0.8,0.8]) rotate([0,0,90]) scale(0.0393701) import("tetrix/motor.stl");
    
    
}

CheckLayout_3d();