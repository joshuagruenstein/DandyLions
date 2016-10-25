include <chassis.scad>


/* Bottom, Back, Front Right, Ramps,
 * Intake, and Phone Support.
 *
 * Cut from 1/4" MDF.
 */
module SheetOne() {
    BottomPlate_2d();

    translate([12,0]) BackPlate_2d();

    translate([23.75,6.75]) rotate(90) FrontRightPlate_2d();

    translate([14.5,6.75]) union() {
        Ramp_2d();
        translate([2.25,2.5]) rotate(180) Ramp_2d();
    }

    translate([0.5,10.75]) Intake_2d();
    translate([5,10.75]) Intake_2d();

    translate([13,10]) PhoneSupport_2d();
}

/* Right, Guards, Front Right, and Ball Cup
 *
 * Cut from 1/4" MDF.
 */

module SheetTwo() {
    translate([13.5,0.0625]) RightPlate_2d();

    translate([6.5,0.5]) rotate(90) LeftGuard_2d();
    translate([13,0.5]) rotate(90) RightGuard_2d();

    translate([23.75,6.6875]) rotate(90) FrontRightPlate_2d();

    translate([15.25,9.8]) rotate(60) rotate(140) CupSide_2d();

    translate([18,9.7]) rotate(200) CupSide_2d();
}

/* Top and Left Plates
 *
 * Cut from 1/4" MDF.
 */
module SheetThree() {
    translate([0.25,0.25]) TopPlate_2d();

    translate([19,0]) rotate(90) LeftPlate_2d();
}

/* Wheels
 *
 * Cut from 1/8" Ply.
 */
module WheelSheet() {

}

//SheetOne();
SheetTwo();
//SheetThree();
//WheelSheet();
