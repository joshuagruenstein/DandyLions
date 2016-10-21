include <puzzle.scad>

// 0.12LB BALL
// SHORTEST DISTANCE: 2.5"
// EXTENSION: ~ 0.5" ?

// BRUSH HOLDER: MCMASTER 7900T34

// Phone Cable: https://www.amazon.com/dp/B00JSXUJ7Y/ref=psdc_464394_t3_B00ENZDN3Y
// Phone Cable Adapter: https://www.amazon.com/StarTech-com-Micro-Mini-Adapter-UUSBMUSBFM/dp/B002O1S8IE/ref=sr_1_1?ie=UTF8&qid=1476927961&sr=8-1&keywords=micro+to+mini+usb+adapter
// USB Cables for Power Module: https://www.amazon.com/degree-Extension-Female-Adapter-Length/dp/B00RLEQCWS/ref=sr_1_4?ie=UTF8&qid=1477023056&sr=8-4&keywords=right+angle+usb

res = 100;

thickness = 0.25;

kerf = 0.00;
kerf_2 = kerf / 2;

width = 12;
length = 10;
height = 6.5;

axle_height = 0.16 + 0.47;
wheel_diameter = 3;
screw_diameter = 0.13;
wheel_stack = 2;
wheel_location = 2.4;

curve_depth = 1.5;
ramp_length = 2.5;
ramp_height = 2;

battery_slot_width = 2.225;
battery_slot_length = 5.125;

finger_hole_radius = 0.4;

module FrontPlate_2d(is_square) {
	difference() {
        InterlockingPlate(width,height,0,0,0,1,0.25);
        translate([width/2,2]) square([4.5,20],center=true);
        
        translate([width/2 - 2.25,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);
        translate([width/2 + 2.5,0.75]) rotate(90) knotches(0.5,height*2 - 2.5);
        
        for (i=[width/2-2.25:0.25:width/2+2.125]) {
            translate([i,0]) square([0.125,6]);
        }
        
        translate([width/2-3.25,4.17]) MotorMount_2d();
        
    }
    
    translate([width/2+2.5,height-0.25]) square([3,0.25]);
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

module Ramp_2d() {
    knotches(0.5,ramp_length/0.5 + 0.5);
    
    translate([ramp_length,0.25]) mirror() difference() {
        square([ramp_length,ramp_height]);
        
        translate([0,+ramp_height]) rotate(-atan(ramp_height/ramp_length)) square([30,30]);
        
        translate([0.5,0.5]) circle(0.3, $fn=res);
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
        translate([0.62,3.9]) circle(0.35,$fn=res);
        
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
        
        translate([0.62,3.9]) circle(0.196,$fn=res);
        
        translate([0.75,1.75]) rotate(90) knotches(0.25,5);
        
        translate([2.4,2.3]) circle(0.3,$fn=res);
        translate([length-2.9,2.3]) circle(0.3,$fn=res);
        
       
        translate([topLeftX,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+3.78,topLeftY]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX,topLeftY-3.44]) circle(screw_diameter/2,$fn=res);
        translate([topLeftX+3.78,topLeftY-3.44]) circle(screw_diameter/2,$fn=res);
    }
}

module Intake_2d() {    
    difference() {
        square([4.25,0.75]);
        for (i=[0:0.5:3.5]) {
            translate([i+0.375,0.2]) circle(screw_diameter/2,$fn=res);
            translate([i+0.375,0.55]) circle(screw_diameter/2,$fn=res);
        }
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

module Motor_Set_2d(loc) {
    wall_dist = 1.75;
    axle_length = 0.7;
    wheel_width = 0.75;
    
    translate([wall_dist,loc,0]) MotorMount_2d();
    translate([width-wall_dist,loc]) rotate(180) MotorMount_2d();

    translate([wall_dist-axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
    translate([width-wall_dist+axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
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
    } translate([width/2-2.25,0]) square([4.5,0.25]);
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

module CupSide_2d() {
    radius = 2;
    
    difference() {
        union() {
            circle(radius,$fn=res);
            translate([-radius,0]) square([radius*2,radius]);
        }
        
        circle(radius-0.5,$fn=res);
        translate([-(radius-0.5),0]) square([radius*2-1,radius]);
        
        translate([-2,-0.9]) square([1,5]);
        
        translate([1.5,1]) difference() {
            square([1,1]);
            translate([0.5,0.5]) circle(0.5,$fn=res);
            square([1,0.5]);
        }
        
        translate([1.85,1.6]) circle(0.157,$fn=res);
        
    } translate([2,0]) difference() {
        square([1,2]);
        translate([0.5,0.5]) circle(0.5,$fn=res);
        translate([0.5,-1]) square([1,2]);
        translate([0,-1.5]) square([1,2]);
        
        translate([0.65,1.6]) circle(0.157,$fn=res);
        
        translate([0,1]) difference() {
            square([1,1]);
            translate([0.5,0.5]) circle(0.5,$fn=res);
            translate([-0.5,0]) square([1,2]);
        }
    } translate([0.23-radius,-1.1]) difference() {
        circle(0.2,$fn=res);
        circle(screw_diameter/2,$fn=res);
    } translate([radius-0.25,-1.1]) difference() {
        circle(0.2,$fn=res);
        circle(screw_diameter/2,$fn=res);
    } translate([radius+0.25,0.8]) difference() {
        circle(0.2,$fn=res);
        circle(screw_diameter/2,$fn=res);
    }
    
}


module knotches(width, number) {
    for (i=[0:2*width:width*number]) {
        translate([i,0,0]) square([width,thickness]);
    }
}

module Render() {
	color([1,0,0]) translate([0,0,0.25]) linear_extrude(height=thickness) BottomPlate_2d();

	color([0,1,0]) translate([0,thickness,0]) rotate([90,0,0]) linear_extrude(height=thickness) FrontPlate_2d(true);

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
    
    translate([width/2+-2.75,0.25,2.75]) rotate([90,0,180]) Motor_Pair_3d();
    
    translate([width/2-2.125,0.75,3.775]) rotate([90,0,0]) linear_extrude(height=thickness) Intake_2d();

    translate([width/2-2.125,1.25,3.775]) rotate([90,0,0]) linear_extrude(height=thickness) Intake_2d();

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

module Motor_Pair_3d() {
    indent = 0.2;
    
    color([0.6,0.6,0.6]) rotate([90,0,90]) scale(0.0393701) import("tetrix/motor_mount.stl");
    
    translate([2.67-indent,0.68,0.15]) color([0.8,0.8,0.8]) rotate([0,0,90]) scale(0.0393701) import("tetrix/motor.stl");
}

module PowerModule_3d() {
    color([0.5,1,1]) scale(0.393701) import("tetrix/power_module.stl");
}

module MotorController_3d() {
    color([0.5,1,1]) scale(0.393701) import("tetrix/motor_controller.stl");
}

module NexusPhone() {
    color([0.4,0.8,0.1]) cube([2.723,0.338,5.427]); 
}

module TetrixBattery() {
    color([0.1,0.1,0.1]) cube([2.1,2.1,5]);
}

module Particle(x,y,z) {
    translate([x,y,z]) translate([0,0,1.5]) color([0,0,1]) scale(0.0393701) import("tetrix/particle.stl");
}

Render();