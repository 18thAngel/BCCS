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
// [Width] (X-Coordinate) of the brick in brick units.
BrickWidth = 4;
// [Depth] (Y-Coordinate) of the brick in brick units.
BrickDepth = 4;

// Thickness used for the [Thickness:Z] of the tile base. For Historical Reasons!
Thickness_of_tile_base = SmallHeight_of_a_Brick;
Base(BrickWidth,BrickDepth);