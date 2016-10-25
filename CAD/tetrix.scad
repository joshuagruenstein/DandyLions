res = 100;

module Motor_Set_2d(loc) {
    wall_dist = 1.75;
    axle_length = 0.7;
    wheel_width = 0.75;

    translate([wall_dist,loc,0]) MotorMount_2d();
    translate([width-wall_dist,loc]) rotate(180) MotorMount_2d();

    translate([wall_dist-axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
    translate([width-wall_dist+axle_length,loc]) square([wheel_width,wheel_diameter], center=true);
}

module MotorMount_2d() {
	motor_mount_length = 2.52;
    motor_mount_width = 0.5;

	translate([motor_mount_width/2,-motor_mount_length/2]) union() {
		circle(screw_diameter/2, $fn=res);
        translate([0,motor_mount_length]) circle(screw_diameter/2, $fn=res);
	}
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

module PowerSticker(inverse) {
    translate([0.625,0.625]) difference() {
        if (inverse) translate([-0.625,-0.625]) square([3.75,1.25]);
        union() {
            difference() {
                circle(0.5,$fn=res);
                difference() {
                    circle(0.3,$fn=res);
                    circle(0.2,$fn=res);
                    translate([0,0.5]) square([0.2,1],center=true);
                } translate([0,0.2]) square([0.1,0.4],center=true);
            }

            translate([1.8,0]) union() {
                translate([0,0.05]) scale(0.025) text("MAIN ROBOT", font = "Liberation Sans:style=Bold Italic", halign = "center");
                translate([0,-0.3]) scale(0.025) text("POWER", font = "Liberation Sans:style=Bold Italic", halign = "center");
            }
        }
    }

}
