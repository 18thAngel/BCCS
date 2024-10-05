///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: 02_AngleStone.scad                                  //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

include <xx_Constants.scad>
include <xx_SharedStuff.scad>

/*[General Settings]*/
// Used for fast rendering
Num_Of_Fragments_DebugMode = 12;

// Used for print version, more fragments resolve in LONGER rendering time but smother curves
Num_Of_Fragments_ProductMode = 72;

/*[Brick Settings]*/
// [Width] (X-Coordinate) of the brick in brick units. Must be positive, not decimal, not zero value.
BrickWidth = 4;
// [Depth] (Y-Coordinate) of the brick in brick units. Must be positive, not decimal, not zero value.
BrickDepth = 4;
// [HeightLayers used for the Base] before adding the angle. Must be positive, not decimal, not zero value.
HeightLayers = 1;

Angle = 40;

_origin_x = GetSizeByBrickUnits(BrickWidth, Size_of_a_BrickUnit);
_origin_z = SmallHeight_of_a_Brick * HeightLayers;
echo(_origin_x);
echo(_origin_z);

correctedPosition = CalcTanslationAfterRotation([0,0,_origin_z], Angle);
newEnd= CalcPositionAfterRotation([0,_origin_x,_origin_z], Angle) + correctedPosition ;
echo(correctedPosition);
echo(newEnd);
translate(newEnd) 
color("red",1) 
    cube(1);

color("yellow",0.5) 
Base(BrickWidth,BrickDepth, HeightLayers,false);
translate([1,0,0]) 
translate(correctedPosition)
    rotate([Angle,0,0])
    color("green",1) 
        Base(BrickWidth,BrickDepth, HeightLayers,true);
