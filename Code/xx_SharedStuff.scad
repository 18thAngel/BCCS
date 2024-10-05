///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: xx_SharedStuff.scad                                 //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

///////////////
// Functions //
///////////////
function CalcRealSize(currentSize, unitSize = 8, roundToEven = false) = ((ceil(currentSize/unitSize) + (roundToEven?( ceil(currentSize/unitSize)%2 ):0)) * unitSize) - Clearance_of_a_Brick;
function NotZero(number) = number == 0 ? 1: number;
//[ud:User Defined, v:Valjero Paint(25mm), gb26:Generic 26mm Bottle, gb30:Generic 30mm Bottle, gb32:Generic 32mm Bottle, gb35:Generic 35mm Bottle, gb37:Generic 37mm Bottle]
function GetBottleDiameter(bottleType,userDefindedBottleDiameter) = bottleType=="v" ? _v_diameter: bottleType=="gb26" ? _gb26_diameter:bottleType=="gb30" ? _gb30_diameter:bottleType=="gb32" ? _gb32_diameter:bottleType=="gb35" ? _gb35_diameter:bottleType=="gb37" ? _gb37_diameter:userDefindedBottleDiameter;

/////////////
// Modules //
/////////////

module Base() {
  difference() {
    cube([ BaseSizeWidth, tileDepth, Thickness_of_tile_base ]);
    translate([
      OutterWallStrength_of_a_Brick, OutterWallStrength_of_a_Brick, -
      TopWallStrength_of_a_Brick
    ])
        cube([
          BaseSizeWidth - 2 * OutterWallStrength_of_a_Brick,
          tileDepth - 2 * OutterWallStrength_of_a_Brick,
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