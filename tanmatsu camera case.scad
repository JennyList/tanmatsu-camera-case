/*

A rear case for the Tanmatsu handheld computer,
designed to hold a Raspberry Pi camera module.

Jenny List 2026
CERN-OHL-P

*/

//Pi camera cutout dimensions, origin on lens
//Mounting holes array of 3D points
//for(i=[0:len(piCameraMountingHoles)-1]){
//    translate(piCameraMountingHoles[i])  cylinder([5,1,1]);
//}
piCameraMountingHoles = [[-10.4,0,0],[10.4,0,0],[10.4,12.5,0],[-10.4,12.5,0]];
//Pi camera lens cutout, array of 2D points
//linear_extrude(5) polygon(piCameraLensCutout);
piCameraLensCutout = [[-6,-6],[6,-6],[6,6],[-6,6]];

//Define the protrusion shape
addonCorners = [[1.5,0,0],[110.5,0,0],[110.5,55,0],[1.5,55,0],[1.5,10,-7.5],[110.5,10,-7.5],[110.5,45,-7.5],[1.5,45,-7.5]];
addonInsideCorners = [[4,1.5,1],[108,1.5,1],[108,53.5,1],[4,53.5,1],[4,12.5,-6],[108,12.5,-6],[108,42.5,-6],[4,42.5,-6]];

$fn=45;

//Brings in the case STL file
//Source: https://github.com/Nicolai-Electronics/tanmatsu-mechanical/releases
//These may need some fixing in MeshLab to make them work.
module TanmatsuCase(){
    import("case-fixed.stl", convexity=3); //pre-made tanmatsu back
    //import("old_case_fixed.stl", convexity=3); //pre-made tanmatsu back for early Tanmatsu versions
}

//Makes the Tanmatsu back itself
module TanmatsuPiCameraBack(){
    difference(){
        TanmatsuCase();
        translate([14,78,-5]){
            cube([93,35,30]); //cut-out for access to camera
        }
        translate([0,68,0]){
            translate([10,16,-5]) cylinder(20,1.25,1.25); // mounting holes
            translate([10,40,-5]) cylinder(20,1.25,1.25);
            translate([111,16,-5]) cylinder(20,1.25,1.25);
            translate([111,40,-5]) cylinder(20,1.25,1.25);
        }
    }   
}

//This is the bit on the back that takes the Pi camera.
//Attaches to camera back with self tapping screws.
module TanmatsuPiCameraProtrusion(){
    difference(){
        translate([4,0,0]){
            hull(){ // outside of protrusion
                for(i=[0:len(addonCorners)-1]){ 
                    translate(addonCorners[i]) sphere(1.5);
                }
            }
        }
        translate([0,-10,0]) cube([120,70,10]); //slice off rounded edge to make flush with back of tanmatsu
        translate([4,0,0]){
            hull(){ // cut out protrusion inside
                for(i=[0:len(addonInsideCorners)-1]){ 
                    translate(addonInsideCorners[i]) sphere(1.5);
                }
            }
            translate([84,28,-15]){ 
                //cut-outs for camera module itself
                for(i=[0:len(piCameraMountingHoles)-1]){ //Mounting holes for camera module standoffs
                    translate(piCameraMountingHoles[i]) cylinder(30,2,2,$fn=90);
                }
                linear_extrude(30) polygon(piCameraLensCutout); //cutout for module lens
            }
        }
    }
    translate([88,28,-8]){ 
        //standoffs for camera
        for(i=[0:len(piCameraMountingHoles)-1]){ //standoffs for camera module
            difference(){
                translate(piCameraMountingHoles[i]) cylinder(3.5,2.5,2.5,$fn=90);
                translate(piCameraMountingHoles[i]) cylinder(30,1.1,1.1,$fn=90);
            }
        }
    }
    difference(){ //screw pillars to attach to Tanmatsu
        union(){
            translate([10,16,-8]) cylinder(8,3,3);
            translate([10,40,-8]) cylinder(8,3,3);
            translate([111,16,-8]) cylinder(8,3,3);
            translate([111,40,-8]) cylinder(8,3,3);
        }
        translate([10,16,-8]) cylinder(8,1,1);
        translate([10,40,-8]) cylinder(8,1,1);
        translate([111,16,-8]) cylinder(8,1,1);
        translate([111,40,-8]) cylinder(8,1,1);
    }
    
}

//Camera mounting bracket, sits behind module for screws to attach to
module zeroCameraBracket(){
    for(i=[0:len(piCameraMountingHoles)-1]){ //stand-offs for screws
        translate([0,0,1]){
            difference(){
                translate(piCameraMountingHoles[i]) cylinder(8,2.375,2.375,$fn=90);
                translate(piCameraMountingHoles[i]) cylinder(8,1,1);
            }
        }
    }
    translate([-13,-2,0]) cube([26,17,1.5]);
}

//uncomment the line for the part you want to render.
//TanmatsuPiCameraBack();
//translate([0,0,9]) TanmatsuPiCameraProtrusion();
//zeroCameraBracket(); 

//Following code displays all three parts roughly as they line up.
/* 
translate([0,0,60])TanmatsuPiCameraBack();
translate([0,68,0]) translate([0,0,9]) TanmatsuPiCameraProtrusion();
translate([89,108,35]) rotate([180,0,0]) zeroCameraBracket(); 
*/