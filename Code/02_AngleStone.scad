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
HeightLayers=1;

translate([-GetSizeByBrickUnits(BrickWidth)/2 - Radius_of_a_BrickHead,-GetSizeByBrickUnits(BrickDepth)/2,0]) 

Base(BrickWidth,BrickDepth, HeightLayers,true);
