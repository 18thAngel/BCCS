///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: xx_SharedStuff.scad                                 //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

///////////////
// Functions //
///////////////
// Calculates the real val for [Width] and [Depth] to ensure the compatiblity to
// brick systems, by a given size
function CalcRealSize(currentSize, unitSize = 8, roundToEven = false) =
    ((ceil(currentSize / unitSize) +
      (roundToEven ? (ceil(currentSize / unitSize) % 2) : 0)) *
     unitSize) -
    Clearance_of_a_Brick;

// Calculates the real val for [Width] and [Depth] to ensure the compatiblity to
// brick systems, by a given amount of units
function GetSizeByBrickUnits(numOfUnits,
                             unitSize = 8) = CalcRealSize(numOfUnits * unitSize,
                                                          unitSize, false);

// simple prevent function for div by 0. obsolete, technicaly wrong!
function NotZero(number) = number == 0 ? 1 : number;

// Calc the translation of a point after it has been rotated
function CalcTanslationAfterRotation(point, angle) = [
  point[0], -(point[1] * cos(angle) - point[2] * sin(angle)),
  (point[2] - (point[1] * sin(angle) + point[2] * cos(angle)))
];

// Calc the translation of a point after it has been rotated
function CalcPositionAfterRotation(point, angle) = [
  point[0], (point[1] * cos(angle) - point[2] * sin(angle)),
  ((point[1] * sin(angle) + point[2] * cos(angle)))
];

/////////////
// Modules //
/////////////
module AddHeads(unitsWidth = 4, unitsDepth = 2, layersHeight = 1) {
  _width = GetSizeByBrickUnits(unitsWidth, Size_of_a_BrickUnit);
  _depth = GetSizeByBrickUnits(unitsDepth, Size_of_a_BrickUnit);
  _height = layersHeight * SmallHeight_of_a_Brick;
  for (row = [1:1:unitsDepth]) {
    for (col = [1:1:unitsWidth]) {
      _x = (Size_of_a_BrickUnit / 2 * col) - Clearance_of_a_Brick / 2;
      _y = (Size_of_a_BrickUnit / 2 * row) - Clearance_of_a_Brick / 2;
      translate([ _x, _y, 0 ]) {
        _headX = _x - Size_of_a_BrickUnit / 2;
        _headY = _y - Size_of_a_BrickUnit / 2;
        translate([ _headX, _headY, _height ])
            cylinder(Height_of_a_BrickHead, Diameter_of_a_BrickHead / 2,
                     Diameter_of_a_BrickHead / 2);
      }
    }
  }
}

module AddInfill(unitsWidth = 4, unitsDepth = 2, layersHeight = 1) {
  for (row = [1:1:unitsDepth - 1]) {
    for (col = [1:1:unitsWidth - 1]) {
      _x = Size_of_a_BrickUnit * col - Clearance_of_a_Brick / 2;
      _y = Size_of_a_BrickUnit * row - Clearance_of_a_Brick / 2;
      translate([ _x, _y, 0 ]) { SingleBrickInlay(layersHeight); }
    }
  }
}

// generates a base by given values
module Base(unitsWidth = 4, unitsDepth = 2, layersHeight = 1, addHeads = false,
            cutInfill = true, addInfill = true) {
  _width = GetSizeByBrickUnits(unitsWidth, Size_of_a_BrickUnit);
  _depth = GetSizeByBrickUnits(unitsDepth, Size_of_a_BrickUnit);
  _height = layersHeight * SmallHeight_of_a_Brick;

  if (!cutInfill) {
    cube([ _width, _depth, _height ]);
  } else {
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
    if (addInfill) {
      color("red") for (row = [1:1:unitsDepth - 1]) {
        for (col = [1:1:unitsWidth - 1]) {
          _x = Size_of_a_BrickUnit * col - Clearance_of_a_Brick / 2;
          _y = Size_of_a_BrickUnit * row - Clearance_of_a_Brick / 2;
          translate([ _x, _y, 0 ]) { SingleBrickInlay(layersHeight); }
        }
      }
      // Adding a bottom plate
      if(layersHeight > 3)
      {
        translate([0,0,3 * SmallHeight_of_a_Brick]) 
        cube([ _width, _depth, 1 ]);
      }
    }
  }

  if (addHeads)
    AddHeads(unitsWidth, unitsDepth, layersHeight);
}

module SingleBrickInlay(layersHeight = 1) {
  _height = layersHeight * SmallHeight_of_a_Brick;
  difference() {
    cylinder(_height - TopWallStrength_of_a_Brick, OutterRadius_of_a_BrickHole,
             OutterRadius_of_a_BrickHole);
    cylinder(_height - TopWallStrength_of_a_Brick, InnerRadius_of_a_BrickHole,
             InnerRadius_of_a_BrickHole);
  }
}