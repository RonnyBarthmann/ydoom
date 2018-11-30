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

Procedure.d GetFlat3Dy(ScreenWidth,ScreenHeight,ScreenX,ScreenY,z.d,ignore.d=0)
  Define y.d
  If z < 0
    ProcedureReturn -1
  EndIf
  y = ScreenY - (ScreenHeight/2)
  y / (ScreenHeight/2)
  y = z / y
  ProcedureReturn y
EndProcedure

Procedure.d GetFlat3Dx(ScreenWidth,ScreenHeight,ScreenX,ScreenY,z.d,y.d)
  Define x.d, y.d
  x = ScreenX - (ScreenWidth/2)
  y = ScreenY - (ScreenHeight/2)
  x / (ScreenHeight/2)
  y / (ScreenHeight/2)
  y = z / y
  x = x * y
  ProcedureReturn x
EndProcedure

Procedure.d GetCeiling3Dy(ScreenWidth,ScreenHeight,ScreenX,ScreenY,z.d,ignore.d=0)
  Define y.d
  If z > 0
    ProcedureReturn -1
  EndIf
  y = ScreenY - (ScreenHeight/2)
  y / (ScreenHeight/2)
  y = z / y
  ProcedureReturn y
EndProcedure

Procedure.d GetCeiling3Dx(ScreenWidth,ScreenHeight,ScreenX,ScreenY,z.d,y.d)
  Define x.d, y.d
  x = ScreenX - (ScreenWidth/2)
  y = ScreenY - (ScreenHeight/2)
  x / (ScreenHeight/2)
  y / (ScreenHeight/2)
  y = z / y
  x = x * y
  ProcedureReturn x
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = --
; EnableXP