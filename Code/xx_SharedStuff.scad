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

// 
function CalcTanslationAfterRotation(z, angle) = [
     0,
     z * sin(angle),
    z- z * cos(angle)
];

/////////////
// Modules //
/////////////

//generates a base by given values
module Base(unitsWidth=4,unitsDepth=2,layersHeight=1,addHeads=false) {
  _width = GetSizeByBrickUnits(unitsWidth, Size_of_a_BrickUnit);
  _depth = GetSizeByBrickUnits(unitsDepth, Size_of_a_BrickUnit);
  _height = layersHeight * SmallHeight_of_a_Brick;
  difference() {
    cube([ _width, _depth, _height ]);
    translate([
      OutterWallStrength_of_a_Brick, OutterWallStrength_of_a_Brick, -
      TopWallStrength_of_a_Brick
    ])
        cube([
          _width - 2 * OutterWallStrength_of_a_Brick,
          _depth - 2 * OutterWallStrength_of_a_Brick,
          _height
        ]);
  }
  color("red") 
  for (row = [1:1:unitsDepth - 1]) {
    for (col = [1:1:unitsWidth - 1]) {
        _x = Size_of_a_BrickUnit * col - Clearance_of_a_Brick/2;
        _y = Size_of_a_BrickUnit * row - Clearance_of_a_Brick/2;
        translate([_x, _y, 0 ])
        {
            SingleBrickInlay();
            if(addHeads)
            {
                translate([0, 0, _height])
                    cylinder(Height_of_a_BrickHead,Diameter_of_a_BrickHead/2,Diameter_of_a_BrickHead/2);
            }
        }
    }
  }
}


module SingleBrickInlay(layersHeight=1) {
   _height = layersHeight * SmallHeight_of_a_Brick;
  difference() {
    cylinder(_height - TopWallStrength_of_a_Brick,
             OutterRadius_of_a_BrickHole, OutterRadius_of_a_BrickHole);
    cylinder(_height - TopWallStrength_of_a_Brick,
             InnerRadius_of_a_BrickHole, InnerRadius_of_a_BrickHole);
  }
}