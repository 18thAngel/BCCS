///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: xx_SharedStuff.scad                                 //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

///////////////
// Functions //
///////////////
// Calculates the real val for [Width] and [Depth] to ensure the compatiblity to brick systems, by a given size
function CalcRealSize(currentSize, unitSize = 8, roundToEven = false) = ((ceil(currentSize/unitSize) + (roundToEven?( ceil(currentSize/unitSize)%2 ):0)) * unitSize) - Clearance_of_a_Brick;

// Calculates the real val for [Width] and [Depth] to ensure the compatiblity to brick systems, by a given amount of units
function GetSizeByBrickUnits(numOfUnits, unitSize = 8) = CalcRealSize(numOfUnits * unitSize, unitSize, false);

// simple prevent function for div by 0. obsolete, technicaly wrong!
function NotZero(number) = number == 0 ? 1: number;


/////////////
// Modules //
/////////////

//generates a base by given values
module Base(unitsWidth,unitsDepth) {
  _width = GetSizeByBrickUnits(unitsWidth, Size_of_a_BrickUnit);
  _depth = GetSizeByBrickUnits(unitsDepth, Size_of_a_BrickUnit);
  
  difference() {
    cube([ _width, _depth, Thickness_of_tile_base ]);
    translate([
      OutterWallStrength_of_a_Brick, OutterWallStrength_of_a_Brick, -
      TopWallStrength_of_a_Brick
    ])
        cube([
          _width - 2 * OutterWallStrength_of_a_Brick,
          _depth - 2 * OutterWallStrength_of_a_Brick,
          Thickness_of_tile_base
        ]);
  }
  for (row = [1:1:unitsDepth - 1]) {
    for (col = [1:1:unitsWidth - 1]) {
      translate([ Size_of_a_BrickUnit * col, Size_of_a_BrickUnit * row, 0 ])
          SingleBrickInlay();
    }
  }
}

module SingleBrickInlay() {

  difference() {
    cylinder(Thickness_of_tile_base - TopWallStrength_of_a_Brick,
             OutterRadius_of_a_BrickHole, OutterRadius_of_a_BrickHole);
    cylinder(Thickness_of_tile_base - TopWallStrength_of_a_Brick,
             InnerRadius_of_a_BrickHole, InnerRadius_of_a_BrickHole);
  }
}