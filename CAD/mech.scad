module Ramp_2d() {
    knotches(0.5,ramp_length/0.5 + 0.5);

    translate([ramp_length,0.25]) mirror() difference() {
        square([ramp_length,ramp_height]);

        translate([0,+ramp_height]) rotate(-atan(ramp_height/ramp_length)) square([30,30]);

        translate([0.5,0.5]) circle(0.3, $fn=res);
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

    } translate([1.99,0]) difference() {
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
