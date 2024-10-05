///////////////////////////////////////////////////////////////
// Part of the "Brick compatible color shelf" (BCCS) project //
// File: xx_SharedStuff.scad                                 //
//                                                           //
// By: Alexander Szymanski / 18thAngel                       //
///////////////////////////////////////////////////////////////

///////////////
// Functions //
///////////////
function CalcRealSize(currentSize, unitSize = 8, roundToEven = false) = (ceil(currentSize/unitSize) + (roundToEven?( ceil(currentSize/unitSize)%2 ):0)) * unitSize;
function NotZero(number) = number == 0 ? 1: number;

/////////////
// Modules //
/////////////