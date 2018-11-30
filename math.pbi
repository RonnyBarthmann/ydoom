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

Procedure.f arcsin(x.f)
  ProcedureReturn Degree(ASin(x))
EndProcedure
Procedure.f arccos(x.f)
  ProcedureReturn Degree(ACos(x))
EndProcedure
Procedure.f ClipF(x.f,min.f,max.f)
  If x < min
    ProcedureReturn min
  ElseIf x > max
    ProcedureReturn max
  Else
    ProcedureReturn x
  EndIf
EndProcedure
Procedure.f PageF(x.f,min.f,max.f)
  Repeat
    If x < min
      x + ( max - min )
    ElseIf x > max
      x - ( max - min )
    Else
      ProcedureReturn x
    EndIf
  ForEver
EndProcedure

Global Dim CosR.f(360000)
Global Dim SinR.f(360000)
Define i
For i = 0 To 359999
  CosR(i) = Cos(Radian(i/1000))
  SinR(i) = Sin(Radian(i/1000))
Next


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = --
; EnableXP