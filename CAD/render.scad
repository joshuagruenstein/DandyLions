include <chassis.scad>

module Render() {
	color([1,0,0]) translate([0,0,0.25]) linear_extrude(height=thickness) BottomPlate_2d();

	color([0,1,0]) translate([0,thickness,0]) rotate([90,0,0]) linear_extrude(height=thickness) union() {
        translate([width/2+2.25,0]) FrontLeftPlate_2d();
        FrontRightPlate_2d();
    }

	color([1,0,1]) translate([width-thickness,0,0]) rotate([90,0,90]) linear_extrude(height=thickness) LeftPlate_2d();

	color([1,1,0]) translate([width,length-thickness,0]) rotate([90,0,180]) linear_extrude(height=thickness) BackPlate_2d();

	color([1,0,1]) translate([0,0,0]) rotate([90,0,90]) linear_extrude(height=thickness) RightPlate_2d();

    color([0,1,1]) translate([0,0,height-thickness]) linear_extrude(height=thickness) TopPlate_2d();

    translate([width/2-1,curve_depth+0.25,0.25]) rotate([90,0,90]) linear_extrude(height=thickness) Ramp_2d();

    translate([width/2+0.75,curve_depth+0.25,0.25]) rotate([90,0,90]) linear_extrude(height=thickness) Ramp_2d();

    color([1,0,1]) translate([width/2-2.5,0.25,0.25]) rotate([90,0,90]) linear_extrude(height=thickness) RightGuard_2d();

    color([1,0,1]) translate([width/2+2.25,0.25,0.25]) rotate([90,0,90]) linear_extrude(height=thickness) LeftGuard_2d();


	Wheel_Pair_3d(wheel_location);
    Wheel_Pair_3d(length-wheel_location);

    translate([width/2,6.4,2]) Cup_3d(true);

    color([.8,.8,.8]) translate([3,8.25,5]) rotate([90,0,90]) cylinder(6,0.1,0.1,$fn=res);
    color([.8,.8,.8]) translate([4.625,9.07,5]) rotate([90,0,90]) cylinder(2.75,0.1,0.1,$fn=res);
    color([.8,.8,.8]) translate([3,9.25,2.5]) rotate([90,0,90]) cylinder(6,0.1,0.1,$fn=res);


    translate([width/2+1.7,length/2-1.4,0.5]) rotate([0,0,0]) Motor_Pair_3d();

    translate([width/2+-2.75,0.25,spinner_height-1.42]) rotate([90,0,180]) Motor_Pair_3d();

    translate([width/2-2.125,0.75,spinner_height-0.395]) rotate([90,0,0]) linear_extrude(height=thickness) Intake_2d();

    translate([width/2-2.125,1.25,spinner_height-0.395]) rotate([90,0,0]) linear_extrude(height=thickness) Intake_2d();

    Particle(width/2);

    translate([width/2+2.75,0.3,0.5]) NexusPhone();

    translate([width/2+2.25,1,2]) rotate([90,0,0]) linear_extrude(height=thickness) PhoneSupport_2d();

    translate([8.4,0.78,8.43]) rotate([90,270,180]) PowerModule_3d();

    translate([2.25,5.17,3.75]) rotate([0,90,90]) MotorController_3d();

    translate([1,5.17,3.75]) rotate([0,90,90]) MotorController_3d();

    translate([9.6,7.5,4.4]) rotate([90,0,0]) TetrixBattery();

    translate([11.75,7.5,4.125]) rotate([0,0,180]) BatteryBracket_3d();
}

module BatteryBracket_3d() {
    linear_extrude(height=thickness) BatteryBracket_Top_2d();

    color([0,1,0]) translate([0,0,0.25]) rotate([0,90,0]) linear_extrude(height=thickness) BatteryBracket_Back_2d();

    color([1,0,0]) translate([0,0.25,-1]) rotate([90,0,0]) linear_extrude(height=thickness) BatteryBracket_Side_2d();

    color([1,0,0]) translate([0,5,-1]) rotate([90,0,0]) linear_extrude(height=thickness) BatteryBracket_Side_2d();
}

module Cup_3d(ball) {
    if (ball) {
        Particle();
    }

    distance = 1.1;

    translate([-0.25-distance,0,1.4]) rotate([90,0,90]) linear_extrude(height=thickness) CupSide_2d();
    translate([distance,0,1.4]) rotate([90,0,90]) linear_extrude(height=thickness) CupSide_2d();
}


module Wheel_Pair_3d(loc) {
    color([1,1,1]) {
			translate([thickness+0.8,loc,axle_height+.25+thickness]) rotate([90,0,90]) linear_extrude(height=thickness*wheel_stack,center=true) Wheel_2d();

			translate([width-thickness-0.8,loc,axle_height+.25+thickness]) rotate([90,0,90]) linear_extrude(height=thickness*wheel_stack,center=true) Wheel_2d();
	}

    translate([1.75,loc-1.41,0.5]) Motor_Pair_3d();
    translate([width-1.75,loc+1.42,0.5]) rotate([0,0,180]) Motor_Pair_3d();
}

Render();
