include <constants.scad>
include <puzzle.scad>

include <tetrix.scad>
include <mech.scad>

/////////////////////////////
//   MAIN ROBOT STRUCTURE  //
/////////////////////////////

module FrontPlate_2d() {
	difference() {
        InterlockingPlate(width,height,0,0,0,1,0.25);
        translate([width/2,2]) square([4.5,20],center=true);

        translate([width/2 - 2.25,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);
        translate([width/2 + 2.5,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);

        for (i=[width/2-2.25:0.25:width/2+2.125]) {
            translate([i,0]) square([0.125,6]);
        }

        translate([width/2-3.25,spinner_height]) MotorMount_2d();

    }

    translate([width/2+2.5,height-0.25]) square([3,0.25]);
}

module FrontRightPlate_2d() {
    difference() {
        FrontPlate_2d();
        translate([width/2,-1]) square([10,10]);

        translate([width/2-2.5,height-0.25]) square(0.25);
    }
}

module FrontLeftPlate_2d() {
    translate([-(width/2+2.25),0]) difference() {
        FrontPlate_2d();
        square([5,10]);
    }
}

module LeftPlate_2d() {
	InterlockingPlate(length,height,0,0,0,1,0.25);

    translate([length/2-battery_slot_length/2,height-0.25]) square([battery_slot_length,0.25]);

    translate([0.25,height-0.25]) square([0.25,0.25]);
}

module RightPlate_2d() {
    difference() {
        InterlockingPlate(length,height,0,1,1,0,0.25);
        //translate([length/2,height*.8]) PingSensor_2d();
    }
}

module BackPlate_2d() {
	difference() {
		InterlockingPlate(width,height,0,1,0,1,0.25);

        translate([width/2 - 2.25,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);
        translate([width/2 + 2.5,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);

	}
}

// ADD HOLE FOR BALL EXIT
module TopPlate_2d() {
    difference() {
        InterlockingPlate(width,length,1,1,0,1);

        translate([width/2-(4.5/2),0.75]) rotate(90)knotches(0.5,length*2 - 2.5);
        translate([width/2+(4.5/2)+0.25,0.75]) rotate(90)knotches(0.5,length*2 - 2.5);

        translate([width/2+2.5,0,0]) square([width/2-2.25,0.8]);

        translate([width-width/4+1.1875,0.8]) circle(finger_hole_radius,$fn=res);

        translate([width-0.25-battery_slot_width,length/2-battery_slot_length/2]) square([battery_slot_width+0.25,battery_slot_length]);

        translate([width-0.25-battery_slot_width/2,length/2-battery_slot_length/2]) circle(finger_hole_radius,$fn=res);

        translate([width-0.25-battery_slot_width/2,length/2+battery_slot_length/2]) circle(finger_hole_radius,$fn=res);


        translate([width-0.5-0.57,length-0.5-1.08]) square([0.57,1.08]);

		translate([8.65,8.55]) scale(0.6) PowerSticker();
    }

    translate([width/2-2.25,0]) square([4.5,0.25]);

    translate([width/2-2.5,0]) square(0.25);
}

module BottomPlate_2d() {
	difference() {
    	InterlockingPlate(width,length,1,0,1,1);

        Motor_Set_2d(wheel_location);
        Motor_Set_2d(length-wheel_location);

        translate([width/2,0.25]) scale([4.5/2,curve_depth]) circle(1,$fn=res);
        translate([width/2-2.25,-1.75]) square([4.5,2]);

        translate([width/2-0.75,curve_depth+0.25]) rotate(90) knotches(0.5,ramp_length/0.5 + 0.5);
        translate([width/2+1,curve_depth+0.25]) rotate(90) knotches(0.5,ramp_length/0.5 + 0.5);

        translate([width/2-(4.5/2)-0.25,0.75]) square([0.25,0.5]);
        translate([width/2+(4.5/2),0.75]) square([0.25,0.5]);
        translate([width/2-(4.5/2)-0.25,length-1.25]) square([0.25,0.5]);
        translate([width/2+(4.5/2),length-1.25]) square([0.25,0.5]);

        translate([width/2-2.25,wheel_location+1.125]) rotate(90) knotches(0.25, 4*(length-0.5 - (wheel_location+0.75)*2)-1);
        translate([width/2+2.5,wheel_location+1.125]) rotate(90) knotches(0.25, 4*(length-0.5 - (wheel_location+0.75)*2)-1);

        translate([width/2+1.7,length/2]) MotorMount_2d();
	}
}

module Guard_2d() {
    bump_width = 0.9;
    bump_height = 1.7;

    translate([0.5,0]) square([0.5,0.25]);
    translate([length-1.5,0]) square([0.5,0.25]);

    guard_extension = 1;

    translate([0,0.25]) difference() {
        square([length-0.5,height-0.75]);

        translate([wheel_location-0.25,0]) scale([bump_width,bump_height]) circle(1,$fn=res);

        translate([length-wheel_location-0.25,0]) scale([bump_width,bump_height]) circle(1,$fn=res);

        translate([8,4.5]) circle(0.157,$fn=res);

        translate([9,2]) circle(0.157,$fn=res);
    }

    translate([0.5,height-0.5]) knotches(0.5,length*2 - 2.5);

    translate([wheel_location+0.875,0]) knotches(0.25, 4*(length-0.5 - (wheel_location+0.75)*2)-1);

    translate([0,0.5]) rotate(90) knotches(0.5,height*2 - 2.5);
    translate([length-0.25,0.5]) rotate(90) knotches(0.5,height*2 - 2.5);
}

module RightGuard_2d() {
    topLeftX = 3.45;
    topLeftY = 5.32;


    difference() {
        Guard_2d();
        translate([0.62,spinner_height-0.27]) circle(0.35,$fn=res);

        translate([3.5,0.75]) circle(0.3,$fn=res);
        translate([length-4,0.75]) circle(0.3,$fn=res);

        translate([topLeftX,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+2.52,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX,topLeftY-3.15]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+2.52,topLeftY-3.15]) circle(screw_diameter/2,$fn=res);
    }
}

// Bushing: 5448T1
// 6MM bore, 10MM OD, 14MM flange
module LeftGuard_2d() {
    topLeftX = 2.88;
    topLeftY = 5.68;

    difference() {
        Guard_2d();
        translate([(length-0.5)/2,1.14]) circle(0.8,$fn=res);

        translate([0.62,spinner_height-0.27]) circle(0.196,$fn=res);

        translate([0.75,1.75]) rotate(90) knotches(0.25,5);

        translate([2.4,2.3]) circle(0.3,$fn=res);
        translate([length-2.9,2.3]) circle(0.3,$fn=res);


        translate([topLeftX,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+3.78,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX,topLeftY-3.44]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+3.78,topLeftY-3.44]) circle(screw_diameter/2,$fn=res);
    }
}


/////////////////////////////
//     ROBOT STRUCTURE     //
/////////////////////////////

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

module PhoneSupport_2d() {
    bracket_width = width/2-2.5;
    bracket_height = 1.25;

    difference() {
        square([bracket_width,bracket_height]);
        translate([0.25,-0.25]) rotate(90) knotches(0.25,5);
    }
}

module BatteryBracket_Top_2d() {
    difference() {
        square([2.1,5]);
        translate([0.25,0.25]) rotate(90) knotches(0.25,20);

        translate([0.5,0]) knotches(0.25,5);

        translate([0.5,4.75]) knotches(0.25,5);
    }
}

module BatteryBracket_Back_2d() {
    difference() {
        square([1.25,5]);
        translate([0.25,0]) rotate(90) knotches(0.25,20);

        translate([0.5,0]) knotches(0.25,2);
        translate([0.5,4.75]) knotches(0.25,2);
    }
}

module BatteryBracket_Side_2d() {
    intersection() {
        difference() {
            square([2.1,1.25]);

            translate([0,1]) square(0.25);
            translate([0.25,1]) knotches(0.25,6);
            translate([2,1]) square(0.25);

            translate([0.25,0.25]) rotate(90) knotches(0.25,2);
        } translate([0,1]) scale([2.1,1]) circle(1,$fn=res);
    }
}
