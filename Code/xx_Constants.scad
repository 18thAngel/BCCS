///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: xx_Constants.scad                                   //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

// This file generates all important values that are needed to be compatible with most
// modual brick systems.
// The core values have been take from Wikipedia article as of 2024-10-05:
// - https://en.wikipedia.org/wiki/Lego#Design
// - https://en.wikipedia.org/wiki/Lego#/media/File:Lego_dimensions.svg
// some might have been slightly modified to match printers offset


/*[Hidden]*/
///////////////////////
///////////////////////
//// Brick Related ////
///////////////////////
///////////////////////

// as found in Wiki
SmallHeight_of_a_Brick = 3.2; 

// as found in Wiki
Height_of_a_BrickHead = 1.7;

// as found in Wiki
Diameter_of_a_BrickHead = 4.8;

// as found in Wiki
Clearance_of_a_Brick = 0.2;

// messured from a brick on my desk
InnerWallStrength_of_a_Brick = 0.85;

// assumed
TopWallStrength_of_a_Brick = 1.2;

//////////////////////////
// Precalculated Values //
//////////////////////////

// A brick can be cutted in three parts / layers 
// and is allowed to be any non decimal multiplication of that layer height
// Original the normal brick is SmallHeight_of_a_Brick * 3;
Height_of_a_Brick = SmallHeight_of_a_Brick * 3;

// Values, that are related to width and depth of a brick are fixed to brick units
// 1 brick unit is calculated by SmallHeight_of_a_Brick * 2.5;
// Values [Width] and [Depth] of a brick must match a non decimal multiplication of a brick unit
Size_of_a_BrickUnit = SmallHeight_of_a_Brick * 2.5;

// Value that is used for any outter walls regarding [Width] and [Depth], most likely it could also be used for height
// Calculation:
// ([Size of a single brick unit] - [clearance of a brick] - [diameter of a brick head]) / 2
OutterWallStrength_of_a_Brick = (Size_of_a_BrickUnit - Clearance_of_a_Brick - Diameter_of_a_BrickHead) / 2;

// For better fitting, the total [Width] and [Depth] of a brick will be lowered by 0.2 mm
// that helps to stack those bricks, or tear them apart
Width_of_a_Brick = Size_of_a_BrickUnit - Clearance_of_a_Brick;

// Simple Diameter => Radius calc
Radius_of_a_BrickHead = Diameter_of_a_BrickHead / 2;

// According to the Specs, it should be +0.1,
// as it doubles up when we convert it back to a radius
// but in this case it did not worked with my printer! 
// this value will be substracted (difference) from [OutterRadius_of_a_BrickHole]
InnerRadius_of_a_BrickHole = Radius_of_a_BrickHead + 0.2;

// Size of a brickhead increased the strength of inner walls
OutterRadius_of_a_BrickHole = Radius_of_a_BrickHead + InnerWallStrength_of_a_Brick;

////////////////////////
////////////////////////
//// Bottle Related ////
////////////////////////
////////////////////////

////////////////////
// Bottle_presets //
////////////////////
_v_diameter = 25;
_gb26_diameter = 26;
_gb30_diameter = 30;
_gb32_diameter = 32;
_gb35_diameter = 35;
_gb37_diameter = 37;


// Not a const, i know! 
// returns the Diameter for the given string
function GetBottleDiameter(bottleType,userDefindedBottleDiameter) = 
  bottleType=="v" ? _v_diameter
: bottleType=="gb26" ? _gb26_diameter
: bottleType=="gb30" ? _gb30_diameter
: bottleType=="gb32" ? _gb32_diameter
: bottleType=="gb35" ? _gb35_diameter
: bottleType=="gb37" ? _gb37_diameter
:userDefindedBottleDiameter;
