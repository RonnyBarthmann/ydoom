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

Global Dim ImageMemory(255,6)

Procedure LoadTex(num,name$)
  Define y,x,success
  Print("Loading Texture "+Chr(34)+name$+Chr(34)+" ... ")
  If LoadImage(1,name$)
    If StartDrawing(ImageOutput(1))
      ImageMemory(num,0) = 0
      ImageMemory(num,3) = AllocateMemory(ImageWidth(1)*ImageHeight(1)*4)
      If ImageMemory(num,3)
        ImageMemory(num,0) = 1
        ImageMemory(num,1) = ImageWidth(1)
        ImageMemory(num,2) = ImageHeight(1)
        For y = 0 To ImageMemory(num,2)-1
          For x = 0 To ImageMemory(num,1)-1
            PokeL(ImageMemory(num,3)+ImageMemory(num,1)*y*4+x*4,Point(x,y))
          Next
        Next
        ImageMemory(num,4) = ImageWidth(1)/2
        ImageMemory(num,5) = ImageHeight(1)
        PrintN("done")
        success = 1
      EndIf
      StopDrawing()
    EndIf
  EndIf
  If success
    ProcedureReturn 1
  Else
    PrintN("failed")
    End
  EndIf
EndProcedure
  
Procedure DummyTex(num,size,c1,c2)
  Define x,y
  Print("Create Texture ... ")
  ImageMemory(num,0) = 0
  ImageMemory(num,3) = AllocateMemory(size*size*4)
  If ImageMemory(num,3)
    ImageMemory(num,0) = 1
    ImageMemory(num,1) = size
    ImageMemory(num,2) = size
    For y = 0 To (size/2)-1
      For x = 0 To (size/2)-1
        PokeL(ImageMemory(num,3)+ImageMemory(num,1)*y*4+x*4,c1)
      Next
    Next
    For y = size/2 To size-1
      For x = size/2 To size-1
        PokeL(ImageMemory(num,3)+ImageMemory(num,1)*y*4+x*4,c1)
      Next
    Next
    For y = 0 To (size/2)-1
      For x = size/2 To size-1
        PokeL(ImageMemory(num,3)+ImageMemory(num,1)*y*4+x*4,c2)
      Next
    Next
    For y = size/2 To size-1
      For x = 0 To (size/2)-1
        PokeL(ImageMemory(num,3)+ImageMemory(num,1)*y*4+x*4,c2)
      Next
    Next
    ImageMemory(num,4) = size/2
    ImageMemory(num,5) = size
    PrintN("done")
    ProcedureReturn 1
  Else
    PrintN("failed")
    End
  EndIf
EndProcedure
  
Procedure GetTexPixel(tex,x,y,rot=0)
  Define xt.f, yt.f
  If ImageMemory(tex,0)
    x + 1000000000
    y + 1000000000
    x % ImageMemory(tex,1)
    y % ImageMemory(tex,2)
    If rot
;     PrintN("Rotation is not god implimented") : End
      xt = x : yt = y
      x = xt*CosR(Int(PageF(rot*1000,0,360000)))-yt*SinR(Int(PageF(rot*1000,0,360000))) ; Rotate Cordinates
      y = xt*SinR(Int(PageF(rot*1000,0,360000)))+yt*CosR(Int(PageF(rot*1000,0,360000)))
      ProcedureReturn PeekL(ImageMemory(tex,3)+(y*ImageMemory(tex,1)*4)+(x*4))
    Else
      ProcedureReturn PeekL(ImageMemory(tex,3)+(y*ImageMemory(tex,1)*4)+(x*4))
    EndIf
  EndIf
EndProcedure
  
Procedure GetTexWigth(tex)
  ProcedureReturn ImageMemory(tex,1)
EndProcedure
  
Procedure GetTexHeight(tex)
  ProcedureReturn ImageMemory(tex,2)
EndProcedure
  
Procedure GetTexX(tex)
  ProcedureReturn ImageMemory(tex,4)
EndProcedure
  
Procedure GetTexY(tex)
  ProcedureReturn ImageMemory(tex,5)
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = --
; EnableXP