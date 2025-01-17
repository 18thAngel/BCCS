///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: 01_ColorHolder.scad                                 //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

include <xx_Constants.scad>
include <xx_SharedStuff.scad>

/*[Explaination]*/
// The [value] of this parameter are ignored and are just for displaying this Lines!!! The [value] of this parameter are ignored and are just for displaying this Lines!!!
Note_on_notes = 1;
// All values regarding sizes, are in [mm] as long as nothing else is stated.
Note_on_sizes = 1;

/*[General Settings]*/
// Used for fast rendering
Num_Of_Fragments_DebugMode = 12;

// Used for print version, more fragments resolve in LONGER rendering time but smother curves
Num_Of_Fragments_ProductMode = 72;

// Always ceil to even number of Brick Units. If the ceiled value for [ ([Bottle_Diameter] + 2*[Wall_Strength] + [Space_between_Columns]) / [Size_of_a_BrickUnit] ] resolves into an odd number, you can force the script to ceil to next even number of units. the Extra Space will be added to the [Space_between_Columns] value!
Even_number_of_BrickUnits = true;

// Shows additional elements, like position points or additional Outputs in console! Those objects will not ne there in final Object!
Show_Debug_output_and_objects = true;

/*[Single Bottle Holder Settings]*/
// Value that will be added to the [Bottle_Diameter] to ensure that the bottles can be inserted and removed quite smoothly. MIGHT BE NEGATIVE IF YOU WANT THEM TO BE SQUEEZED.
Bottle_Clearance = 1;

// Bottle Type, used to preset some [values]
Bottle_Type =  "v"; // [ud:User Defined, v:Valjero Paint(25mm), gb26:Generic 26mm Bottle, gb30:Generic 30mm Bottle, gb32:Generic 32mm Bottle, gb35:Generic 35mm Bottle, gb37:Generic 37mm Bottle]

// User definded diameter of a bottle. ONLY USED IF [Bottle Type] equals "User Defined"! Ensure that you do not include a clearance twice!
UserDefinded_Bottle_Diameter = 15;

// determied by previous selections - not visible in Customizer!
Bottle_Diameter = GetBottleDiameter(Bottle_Type, UserDefinded_Bottle_Diameter) + Bottle_Clearance;

// Strength used for the wall of the bottle holder
Wall_Strength = 1.5;

// Height used for the wall of the bottle holder
Wall_Height = 15;

/*[Column Settings]*/
// Number of [bottles] per [row]
Num_of_Columns = 5;
// Space between [bottles] in a [row]. May be negative but only by [real space between bottle holders] + 1 * [Wall Strength]
Space_between_Columns = 1;


//////////////////////////////
// !!! No changes below !!! //
//////////////////////////////
include <xx_lateCalculatedValues.scad>
///////////////////////
// Value Calculation //
///////////////////////

// General
$fn = $preview ? Num_Of_Fragments_DebugMode : Num_Of_Fragments_ProductMode;

// Tile Related
// Size that is used for [Length:X] and [Depth:Y] of the tile
Size_of_Tile = Bottle_Diameter + 2 * Wall_Strength;

minSpaceBetweenColumns = (Bottle_Diameter + Wall_Strength) - Size_of_Tile;

tileDepth =
    CalcRealSize(Size_of_Tile, Size_of_a_BrickUnit, Even_number_of_BrickUnits);
tileDepthOverhead = tileDepth - Size_of_Tile;

///////////////////////
// Value Calculation //
///////////////////////

// Bottle related
BottleHolder_OutterRadius = Bottle_Diameter / 2 + Wall_Strength;
BottleHolder_InnerRadius = Bottle_Diameter / 2;

// Tile Related
BaseSizeWidth_tmp = (BottleHolder_OutterRadius * 2 * Num_of_Columns) +
                    ((Num_of_Columns)*Space_between_Columns);

BaseSizeWidth = CalcRealSize(BaseSizeWidth_tmp, Size_of_a_BrickUnit,
                             Even_number_of_BrickUnits);

BaseSizeWidth_overhead = BaseSizeWidth - BaseSizeWidth_tmp;

CalcedSpaceBetween =
    Space_between_Columns + (BaseSizeWidth_overhead / NotZero(Num_of_Columns));

///////////////////////////
unitsWidth = (BaseSizeWidth + Clearance_of_a_Brick) / Size_of_a_BrickUnit;
unitsDepth = (tileDepth+Clearance_of_a_Brick) / Size_of_a_BrickUnit;
///////////////////////////

if (DebugMode) {
  echo("");
  echo("----------------------------");
  echo("Important calculation results:");
  echo("");

  echo(str("The real base width for ", BaseSizeWidth_tmp,
           "mm has been calced to: ", BaseSizeWidth, "mm"));
  echo(str("CalcedSpaceBetween has been calced to ", CalcedSpaceBetween, "mm"));
  echo("");
  echo("----------------------------");
  echo("");

  echo("");
  echo("----------------------------");
  echo("Settings for a bottle:");
  echo("");
  echo(str("[Bottle Diameter] for [Bottle_Type]: ", Bottle_Type,
           " have been set to: ", Bottle_Diameter,
           "mm, including: ", Bottle_Clearance,
           "mm [Bottle Clearance], based on user preferences"));
  echo("");
  echo("----------------------------");
  echo("");

  echo("");
  echo("----------------------------");
  echo("Messures of a brick:");
  echo("");

  echo(str("Small height of a brick: ", SmallHeight_of_a_Brick, "mm (given)"));
  echo(str("Height of a brick head: ", Height_of_a_BrickHead, "mm (given)"));
  echo(
      str("Diameter of a brick head: ", Diameter_of_a_BrickHead, "mm (given)"));
  echo(str("Height of a brick: ", Height_of_a_Brick, "mm (calc)"));
  echo(str("Size of a brick unit: ", Size_of_a_BrickUnit, "mm (calc)"));
  echo(str("Width of a brick:  ", Width_of_a_Brick, "mm (calc)"));
  echo(str("Radius_of_a_BrickHead:  ", Radius_of_a_BrickHead, "mm (calc)"));
  echo(str("InnerRadius of a BrickHole:  ", InnerRadius_of_a_BrickHole,
           "mm (calc)"));
  echo(str("OutterRadius of a BrickHole:  ", OutterRadius_of_a_BrickHole,
           "mm (calc)"));
  echo("");

  echo("Messures the Holder:");
  echo("");
  echo(str("The real tile depth for ", Size_of_Tile,
           "mm has been calced to: ", tileDepth, "mm"));
  echo(str("The real base width for ", BaseSizeWidth_tmp,
           "mm has been calced to: ", BaseSizeWidth, "mm"));
  echo(str("Tile depth:  ", tileDepth, "mm (calc)"));
  echo(str("Tile width:  ", BaseSizeWidth, "mm (calc)"));
  echo(str("Tile depth:  ", unitsDepth, "units (calc)"));
  echo(str("Tile width:  ", unitsWidth, "units (calc)"));
  echo("");
  echo("----------------------------");
  echo("");

  echo(str("The real tile depth for ", Size_of_Tile,
           "mm has been calced to: ", tileDepth, "mm"));
}
// generates a single Holder
module BottleHolder() {
  translate([ 0, BottleHolder_OutterRadius + tileDepthOverhead / 2, 0 ]) {
    difference() {
      cylinder(Wall_Height, BottleHolder_OutterRadius,
               BottleHolder_OutterRadius);
      cylinder(Wall_Height + 0.1, BottleHolder_InnerRadius,
               BottleHolder_InnerRadius);
    }
  }
}
// generates a single Holder
module BottleHolders() {
  for (holder = [0:Num_of_Columns - 1]) {
    translate([
      (holder * (BottleHolder_OutterRadius * 2 + CalcedSpaceBetween)) +
          BottleHolder_OutterRadius,
      0,
      Thickness_of_tile_base
    ]) BottleHolder();
  }
}

// Generates a Single Row, in original version there were a multiple rows option!
module SolidHolder() {
  Base(unitsWidth,unitsDepth);
  translate([ CalcedSpaceBetween / 2, 0, 0 ]) BottleHolders();
}



/////////////////

/////////////
// Program //
/////////////

// in original version there were a multiple rows option!
SolidHolder();  

