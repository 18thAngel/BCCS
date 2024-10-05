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
BrickWidth = 2;
// [Depth] (Y-Coordinate) of the brick in brick units. Must be positive, not decimal, not zero value.
BrickDepth = 4;
// [HeightLayers used for the Base] before adding the angle. Must be positive, not decimal, not zero value.
HeightLayers = 1;

Angle = 40;
// General
$fn = $preview ? Num_Of_Fragments_DebugMode : Num_Of_Fragments_ProductMode;


_origin_x = GetSizeByBrickUnits(BrickWidth, Size_of_a_BrickUnit);
_origin_y = GetSizeByBrickUnits(BrickDepth, Size_of_a_BrickUnit);
_origin_z = SmallHeight_of_a_Brick * HeightLayers;


correctedPosition = CalcTanslationAfterRotation([0,0,_origin_z], Angle);
topLocation = CalcPositionAfterRotation([0,_origin_y,_origin_z], Angle) + correctedPosition ;
bottomLocation = CalcPositionAfterRotation([0,0,0], Angle) + correctedPosition;

// filling the gap
module GapFill() {

    _fillPoints=[
     [  0,  bottomLocation[1], bottomLocation[2] ],  //0 
     [  _origin_x,  bottomLocation[1], bottomLocation[2] ],  //1 
    [  _origin_x,  _origin_y, _origin_z ],  //2 
     [  0,  _origin_y, _origin_z ],  //3
     [  0,  topLocation[1], topLocation[2] ],  //4 
     [  _origin_x,  topLocation[1], topLocation[2] ],  //5 
     ];

    _fillFaces= [
        [0,1,2,3], // bottom
        [4,5,1,0], //Front
        [5,4,3,2],  // back
        [0,3,4],  // Left
        [1,2,5],  // right
    ];
hull() {
   polyhedron( _fillPoints, _fillFaces );
}
    if($preview)
        for(point = _fillPoints)
            color("red",0.3) 
              translate(point)     
                cube(size = 1, center=true);
}

module buildTheBasic()
{
    color("yellow",0.5) 
    Base(BrickWidth,BrickDepth, HeightLayers,false);
    
    translate(correctedPosition)
        rotate([Angle,0,0])
          color("green",0.5) 
            Base(BrickWidth,BrickDepth, HeightLayers,true);
}

module Brick() {
  buildTheBasic();
  GapFill();
        
}

module FinalBrick() {
  difference() {
    Brick();
  BuildTheCutter();
  
    
    }
}

module BuildTheCutter() {
    _cutterPoints=[         
        [  0,  _origin_y, _origin_z ],  //1
        [  _origin_x,  _origin_y, _origin_z ],  //0 
        [  _origin_x,  _origin_y, _origin_z ]+ correctedPosition,  //3
        [  0,  _origin_y, _origin_z ] + correctedPosition,  //2
        [  0,  topLocation[1], topLocation[2] ],  //4 
        [  _origin_x,  topLocation[1], topLocation[2] ],  //5 
        [  _origin_x,  topLocation[1], topLocation[2] ]+ correctedPosition,  //6
        [  0,  topLocation[1], topLocation[2] ]+ correctedPosition,  //7
    ];

    _cutterFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
    
    if($preview)
        for(point = _cutterPoints)
            color("blue",0.5) 
              translate(point)     
                cube(size = 1, center=true);

    polyhedron( _cutterPoints, _cutterFaces );

}

 //Brick();

//   BuildTheCutter();
   //GapFill();
   FinalBrick();
