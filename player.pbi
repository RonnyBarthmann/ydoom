;{  English File-Header
; 
; This file is part of yDOOM.
; 
; yDOOM is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; yDOOM is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with yDOOM.  If not, see <http://www.gnu.org/licenses/>.
; 
;}

;{  Deutscher Dateikopf
; 
; Diese Datei ist Teil von yDOOM.
; 
; yDOOM ist Freie Software: Sie können es unter den Bedingungen
; der GNU General Public License, wie von der Free Software Foundation,
; Version 3 der Lizenz oder (nach Ihrer Wahl) jeder neueren
; veröffentlichten Version, weiter verteilen und/oder modifizieren.
; 
; yDOOM wird in der Hoffnung, dass es nützlich sein wird, aber
; OHNE JEDE GEWÄHRLEISTUNG, bereitgestellt; sogar ohne die implizite
; Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK.
; Siehe die GNU General Public License für weitere Details.
; 
; Sie sollten eine Kopie der GNU General Public License zusammen mit yDOOM
; erhalten haben. Wenn nicht, siehe <https://www.gnu.org/licenses/>.
; 
;}

XIncludeFile "math.pbi"

Procedure DrawFlatPOV(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,x4.d,y4.d,z.d,tex)
  Define ox1.d,oy1.d,ox2.d,oy2.d,ox3.d,oy3.d,ox4.d,oy4.d
  x1 - px : x2 - px : x3 - px : x4 - px
  y1 - py : y2 - py : y3 - py : y4 - py
  
  ox1 = 0 + ( x1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy1 = 0 + ( y1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox2 = 0 + ( x2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy2 = 0 + ( y2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox3 = 0 + ( x3 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y3 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy3 = 0 + ( y3 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x3 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox4 = 0 + ( x4 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y4 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy4 = 0 + ( y4 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x4 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  
  DrawFlat(ox1,oy1,ox2,oy2,ox3,oy3,ox4,oy4,z,tex)
EndProcedure

Procedure DrawCellingPOV(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,x4.d,y4.d,z.d,tex)
  Define ox1.d,oy1.d,ox2.d,oy2.d,ox3.d,oy3.d,ox4.d,oy4.d
  x1 - px : x2 - px : x3 - px : x4 - px
  y1 - py : y2 - py : y3 - py : y4 - py
  
  ox1 = 0 + ( x1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy1 = 0 + ( y1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox2 = 0 + ( x2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy2 = 0 + ( y2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox3 = 0 + ( x3 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y3 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy3 = 0 + ( y3 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x3 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox4 = 0 + ( x4 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y4 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy4 = 0 + ( y4 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x4 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  
  DrawCelling(ox1,oy1,ox2,oy2,ox3,oy3,ox4,oy4,z,tex)
EndProcedure

Procedure DrawWallPOV(x1.d,y1.d,x2.d,y2.d,h.d,z.d,tex)
  Define ox1.d,oy1.d,ox2.d,oy2.d
  x1 - px : x2 - px : y1 - py : y2 - py
  
  ox1 = 0 + ( x1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy1 = 0 + ( y1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox2 = 0 + ( x2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy2 = 0 + ( y2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  
  DrawWall(ox1,oy1,ox2,oy2,z,h,tex)
EndProcedure

Procedure DrawSpritePOV(x.d,y.d,z.d,tex,rot=0)
  Define ox.d,oy.d
  x - px : y - py
  
  ox = 0 + ( x * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy = 0 + ( y * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x * SinR(Int(PageF(0-pa,0,360)*1000)) )
  
  DrawSprite(ox,oy,z,tex,rot)
EndProcedure

Procedure IfLineVisPOV(x1.d,y1.d,x2.d,y2.d)
  Define ox1.d,oy1.d,ox2.d,oy2.d
  x1 - px : x2 - px : y1 - py : y2 - py
  
  ox1 = 0 + ( x1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy1 = 0 + ( y1 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x1 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  ox2 = 0 + ( x2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) - ( y2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  oy2 = 0 + ( y2 * CosR(Int(PageF(0-pa,0,360)*1000)) ) + ( x2 * SinR(Int(PageF(0-pa,0,360)*1000)) )
  
 ProcedureReturn IfLineVis(ox1,oy1,ox2,oy2)
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 106
; FirstLine = 51
; Folding = --
; EnableXP