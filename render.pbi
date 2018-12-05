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
XIncludeFile "renderMath.pbi"

Global Scale.f = height / 200
Global Dim ZBuffer.d(7679,4319) ; Max 8k ( 4320p )

If width > 7680
      PrintN("Unable to init Render")
      PrintN("This Version support only")
      PrintN("up to 7680x4320 ( 8k )")
      PrintN("... end") : End
EndIf
If height > 4320
EndIf

Procedure ClearScene(color=0)
  Define x,y
  For y = 0 To height-1
    For x = 0 To width-1
      ZBuffer(x,y) = 16777215
    Next
  Next
  Box(0,0,width,height,color)
EndProcedure

Procedure _DrawLineX(x1,x2,y,z.d,cell,tex)
  Define i,tx,ty
  If x1 < 0 : x1 = 0 : EndIf
  If x2 > width-1 : x2 = width-1 : EndIf
  If x1 > x2 : Swap x1,x2 : EndIf
  If x2 < x1 : Swap x1,x2 : EndIf
  If y < 0 : ProcedureReturn : EndIf
  If y > height-1 : ProcedureReturn : EndIf
  If RenderFlatTex
    If cell
      For i = x1 To x2
        If -1 < i And i < width
          ty = GetCeiling3Dy(width,height,i,y,z,0)
          If ZBuffer(i,y) > ty
            ZBuffer(i,y) = ty
            tx = GetCeiling3Dx(width,height,i,y,z,ty)
            Plot(i,y,GetTexPixel(tex,tx,ty))
          EndIf
        EndIf
      Next
    Else
      For i = x1 To x2
        If -1 < i And i < width
          ty = GetFlat3Dy(width,height,i,y,z,0)
          If ZBuffer(i,y) > ty
            ZBuffer(i,y) = ty
            tx = GetFlat3Dx(width,height,i,y,z,ty)
            Plot(i,y,GetTexPixel(tex,tx,ty))
          EndIf
        EndIf
      Next
    EndIf
  Else
    tex = GetTexPixel(tex,0,0)
    If cell
      For i = x1 To x2
        If -1 < i And i < width
          ty = GetCeiling3Dy(width,height,i,y,z,0)
          If ZBuffer(i,y) > ty
            ZBuffer(i,y) = ty
            Plot(i,y,tex)
          EndIf
        EndIf
      Next
    Else
      For i = x1 To x2
        If -1 < i And i < width
          ty = GetFlat3Dy(width,height,i,y,z,0)
          If ZBuffer(i,y) > ty
            ZBuffer(i,y) = ty
            Plot(i,y,tex)
          EndIf
        EndIf
      Next
    EndIf
  EndIf
EndProcedure

Procedure _DrawLineY(x,y1,y2,d.d,tx.d,h.d,tex)
  Define i,ty.d,yTexStep.d,c
  If y1 < 0 : y1 = 0 : EndIf
  If y2 > height-1 : y2 = height-1 : EndIf
  If y1 > y2 : ProcedureReturn : EndIf
  If y2 < y1 : ProcedureReturn : EndIf
  If x < 0 : ProcedureReturn : EndIf
  If x > width-1 : ProcedureReturn : EndIf
  yTexStep = h / ( y2 - y1 )
  If RenderWallTex
    For i = y1 To y2
      If -1 < i And i < height
        If ZBuffer(x,i) > d
          ZBuffer(x,i) = d
          Plot(x,i,GetTexPixel(tex,tx,ty))
        EndIf
        ty + yTexStep
      EndIf
    Next
  Else
    tex = GetTexPixel(tex,0,0)
    For i = y1 To y2
      If -1 < i And i < height
        If ZBuffer(x,i) > d
          ZBuffer(x,i) = d
          Plot(x,i,tex)
        EndIf
      EndIf
    Next
  EndIf
EndProcedure

Procedure _DrawFlat2(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,z.d,tex,cell)
  Define aTriHigh,aLeftStep.d,aRightStep.d,vTriHigh,vLeftStep.d,vRightStep.d
  Define ox1,oy1,ox2,oy2,ox3,oy3,TriMode,i,oxL.d,oxR.d,ox4,oy4,oy,behindCam
  If y1 > 0
    ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
    oy1 = ( ( z * ( height / 2 ) ) / y1 ) + ( height / 2 )
  Else
    behindCam = 1
  EndIf
  If y2 > 0
    ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
    oy2 = ( ( z * ( height / 2 ) ) / y2 ) + ( height / 2 )
  Else
    behindCam = 1
  EndIf
  If y3 > 0
    ox3 = ( ( x3 * ( height / 2 ) ) / y3 ) + ( width / 2 )
    oy3 = ( ( z * ( height / 2 ) ) / y3 ) + ( height / 2 )
  Else
    behindCam = 1
  EndIf
  If DebugModeFlat
    If y1 > 0 And y2 > 0
      LineXY(ox1,oy1,ox2,oy2,255)
    EndIf
    If y2 > 0 And y3 > 0
      LineXY(ox2,oy2,ox3,oy3,255)
    EndIf
    If y3 > 0 And y1 > 0
      LineXY(ox3,oy3,ox1,oy1,255)
    EndIf
    If y1 > 0
      Box(ox1-2,oy1-2,5,5,255)
    EndIf
    If y1 > 0
      Box(ox2-2,oy2-2,5,5,255)
    EndIf
    If y1 > 0
      Box(ox3-2,oy3-2,5,5,255)
    EndIf
  EndIf
  If behindCam
    ProcedureReturn
  EndIf
  If oy1 > oy2
    Swap ox1, ox2
    Swap oy1, oy2
  EndIf
  If oy1 > oy3
    Swap ox1, ox3
    Swap oy1, oy3
  EndIf
  If oy2 > oy3
    Swap ox2, ox3
    Swap oy2, oy3
  EndIf
  If oy1 = oy3
    TriMode = 3      ; Line
    If ox1 > ox2
      Swap ox1, ox2
    EndIf
    If ox1 > ox3
      Swap ox1, ox3
    EndIf
    If ox2 > ox3
      Swap ox2, ox3
    EndIf
  ElseIf oy1 = oy2
    TriMode = 2      ; Down   V
    If ox1 > ox2
      Swap ox1, ox2
    EndIf
  ElseIf oy2 = oy3
    TriMode = 1      ; Up     A
    If ox2 > ox3
      Swap ox2, ox3
    EndIf
  Else
    TriMode = 0      ; Side   < or >
  EndIf
  Select TriMode
    Case 0
      i = oy3 - oy1
      aTriHigh = oy2 - oy1
      vTriHigh = oy3 - oy2
      ox4 = ((ox1*vTriHigh)+(ox3*aTriHigh)) / i
      oy4 = oy2
      
      aTriHigh = oy2 - oy1
      aLeftStep = (ox2-ox1)/aTriHigh
      aRightStep = (ox4-ox1)/aTriHigh
      oxL = ox1 : oxR = ox1
      For i = oy1 To oy2
        _DrawLineX(oxL,oxR,i,z,cell,tex)
        oxL+aLeftStep : oxR+aRightStep
      Next
      vTriHigh = oy3 - oy2
      vLeftStep = (ox3-ox2)/vTriHigh
      vRightStep = (ox3-ox4)/vTriHigh
      oxL = ox2 : oxR = ox4
      For i = oy2 To oy3
        _DrawLineX(oxL,oxR,i,z,cell,tex)
        oxL+vLeftStep : oxR+vRightStep
      Next
    Case 1
      aTriHigh = oy2 - oy1
      aLeftStep = (ox2-ox1)/aTriHigh
      aRightStep = (ox3-ox1)/aTriHigh
      oxL = ox1 : oxR = ox1
      For i = oy1 To oy2
        _DrawLineX(oxL,oxR,i,z,cell,tex)
        oxL+aLeftStep : oxR+aRightStep
      Next
    Case 2
      vTriHigh = oy3 - oy1
      vLeftStep = (ox3-ox1)/vTriHigh
      vRightStep = (ox3-ox2)/vTriHigh
      oxL = ox1 : oxR = ox2
      For i = oy1 To oy3
        _DrawLineX(oxL,oxR,i,z,cell,tex)
        oxL+vLeftStep : oxR+vRightStep
      Next
    Case 3
  EndSelect
  If DebugModeFlat
    If y1 > 0 And y2 > 0
      LineXY(ox1,oy1,ox2,oy2,255)
    EndIf
    If y2 > 0 And y3 > 0
      LineXY(ox2,oy2,ox3,oy3,255)
    EndIf
    If y3 > 0 And y1 > 0
      LineXY(ox3,oy3,ox1,oy1,255)
    EndIf
    If y1 > 0
      Box(ox1-2,oy1-2,5,5,255)
    EndIf
    If y1 > 0
      Box(ox2-2,oy2-2,5,5,255)
    EndIf
    If y1 > 0
      Box(ox3-2,oy3-2,5,5,255)
    EndIf
  EndIf
EndProcedure

Procedure IfLineVis(x1.d,y1.d,x2.d,y2.d)
  Define ox1,ox2,y1end,y2end
  If y1 > 0
    ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
  Else
    y1end = 1
  EndIf
  If y2 > 0
    ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
  Else
    y2end = 1
  EndIf
  If y1end+y2end = 0
    If ox2 > ox1
      If ox2 > 0
        If ox1 < width
          ProcedureReturn 1
        EndIf
      EndIf
    EndIf
  ElseIf y1end+y2end = 1
    If y1end = 0
      If ox1 < width
        ProcedureReturn 1
      EndIf
    ElseIf y2end = 0
      If ox2 > 0
        ProcedureReturn 1
      EndIf
    EndIf
  EndIf
  ProcedureReturn 0
EndProcedure

Procedure _DrawWall2(x1.d,y1.d,x2.d,y2.d,z.d,h.d,tex)
  Define ox1,oy1,oh1,ox2,oy2,oh2,yWallStep.d,hWallStep.d,dWallStep.d,xTexStep.d,oy.d,oh.d,od.d,i,tx.d,reverse
  ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
  oy1 = ( ( z * ( height / 2 ) ) / y1 ) + ( height / 2 )
  oh1 =   ( h * ( height / 2 ) ) / y1
  ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
  oy2 = ( ( z * ( height / 2 ) ) / y2 ) + ( height / 2 )
  oh2 =   ( h * ( height / 2 ) ) / y2
  If DebugModeWall
    If y1 > 0
      Box(ox1-2,oy1-2,5,5,255)
      Box(ox1-2,oy1-oh1-2,5,5,255)
      Line(ox1,oy1,1,-oh1,255)
    EndIf
    If y2 > 0
      Box(ox2-2,oy2-2,5,5,255)
      Box(ox2-2,oy2-oh2-2,5,5,255)
      Line(ox2,oy2,1,-oh2,255)
    EndIf
    If y1 > 0 And y2 > 0
      LineXY(ox1,oy1,ox2,oy2,255)
      LineXY(ox1,oy1-oh1,ox2,oy2-oh2,255)
    EndIf
  EndIf
  If ox1 = ox2
    ProcedureReturn
  EndIf
  reverse = 0
  If ox1 > ox2
;     Swap ox1, ox2
;     Swap oy1, oy2
;     Swap oh1, oh2
;     reverse = 1
    ProcedureReturn ; Draw only one side
  EndIf
  yWallStep = ( oy2 - oy1 ) / ( ox2 - ox1 )
  hWallStep = ( oh2 - oh1 ) / ( ox2 - ox1 )
  dWallStep = ( y2 - y1 ) / ( ox2 - ox1 )
  oy = oy1
  oh = oh1
  od = y1
  If reverse
    xTexStep = 0 - ( Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) ) / ( ox2 - ox1 ) )
    tx = Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) )
  Else
    xTexStep = Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) ) / ( ox2 - ox1 )
    tx = 0
  EndIf
  For i = ox1 To ox2
    _DrawLineY(i,oy-oh,oy,od,tx,h,tex)
    oy + yWallStep
    oh + hWallStep
    od + dWallStep
    tx + xTexStep
  Next
  If DebugModeWall
    If y1 > 0
      Box(ox1-2,oy1-2,5,5,255)
      Box(ox1-2,oy1-oh1-2,5,5,255)
      Line(ox1,oy1,1,-oh1,255)
    EndIf
    If y2 > 0
      Box(ox2-2,oy2-2,5,5,255)
      Box(ox2-2,oy2-oh2-2,5,5,255)
      Line(ox2,oy2,1,-oh2,255)
    EndIf
    If y1 > 0 And y2 > 0
      LineXY(ox1,oy1,ox2,oy2,255)
      LineXY(ox1,oy1-oh1,ox2,oy2-oh2,255)
    EndIf
  EndIf
EndProcedure

Procedure _DrawSprite2(x.d,y.d,z.d,tex,rot=0)
  Define ox,oy,ox1,oy1,ox2,oy2,ox3,oy3,ox4,oy4,sScale.d,sStep.d,xPos.d,yPos.d
  If y > 0
    ox = ( ( x * ( height / 2 ) ) / y ) + ( width / 2 )
    oy = ( ( z * ( height / 2 ) ) / y ) + ( height / 2 )
    sScale = 1 / y : sStep = y
    ox1 = ox - GetTexX(tex)*sScale*(height/2)
    oy1 = oy - GetTexY(tex)*sScale*(height/2)
    ox2 = ox1 + ( GetTexWigth(tex)*sScale*(height/2) )
    oy2 = oy1
    ox3 = ox1 + ( GetTexWigth(tex)*sScale*(height/2) )
    oy3 = oy1 + ( GetTexHeight(tex)*sScale*(height/2) )
    ox4 = ox1
    oy4 = oy1 + ( GetTexHeight(tex)*sScale*(height/2) )
    If DebugModeSprite
      Box(ox1-2,oy1-2,5,5,255)
      Box(ox2-2,oy2-2,5,5,255)
      Box(ox3-2,oy3-2,5,5,255)
      Box(ox4-2,oy4-2,5,5,255)
      LineXY(ox1,oy1,ox2,oy2,255)
      LineXY(ox2,oy2,ox3,oy3,255)
      LineXY(ox3,oy3,ox4,oy4,255)
      LineXY(ox4,oy4,ox1,oy1,255)
    EndIf
    
    If ox1 < 0 : ox1 = 0 : EndIf
    If ox1 > width-1 : ProcedureReturn : EndIf
    If ox2 < 0 : ProcedureReturn : EndIf
    If ox2 > width-1 : ox2 = width-1 : EndIf
    If ox3 < 0 : ProcedureReturn : EndIf
    If ox3 > width-1 : ox3 = width-1 : EndIf
    If ox4 < 0 : ox4 = 0 : EndIf
    If ox4 > width-1 : ProcedureReturn : EndIf
    If oy1 < 0 : oy1 = 0 : EndIf
    If oy1 > height-1 : ProcedureReturn : EndIf
    If oy2 < 0 : oy2 = 0 : EndIf
    If oy2 > height-1 : ProcedureReturn : EndIf
    If oy3 < 0 : ProcedureReturn : EndIf
    If oy3 > height-1 : oy1 = height-1 : EndIf
    If oy4 < 0 : ProcedureReturn : EndIf
    If oy4 > height-1 : oy1 = height-1 : EndIf
      
    If RenderSpriteTex
      xPos = 0
      For ox = ox1 To ox2
        yPos = 0
        For oy = oy1 To oy4
          If ZBuffer(ox,oy) > y
            ZBuffer(ox,oy) = y
            Plot(ox,oy,GetTexPixel(tex,xPos,yPos,rot))
          EndIf
          yPos + sStep
        Next
        xPos + sStep
      Next
    Else
      tex = GetTexPixel(tex,0,0)
      For ox = ox1 To ox2
        For oy = oy1 To oy4
          If ZBuffer(ox,oy) > y
            ZBuffer(ox,oy) = y
            Plot(ox,oy,tex)
          EndIf
        Next
      Next
    EndIf
  EndIf
EndProcedure

Procedure _DrawFlat(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,z.d,tex,cell)
  If cell
    If z < 0
      _DrawFlat2(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,z.d,tex,cell) ; Camera, Cropping etc.
    EndIf
  Else
    If z > 0
      _DrawFlat2(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,z.d,tex,cell) ; Camera, Cropping etc.
    EndIf
  EndIf
EndProcedure

Procedure _DrawWall(x1.d,y1.d,x2.d,y2.d,z.d,h.d,tex)
  _DrawWall2(x1,y1,x2,y2,z,h,tex)
EndProcedure

Procedure _DrawSprite(x.d,y.d,z.d,tex,rot=0)
  _DrawSprite2(x,y,z,tex,rot)
EndProcedure

Procedure DrawCelling(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,x4.d,y4.d,z.d,tex)
  _DrawFlat(x4,y4,x1,y1,x2,y2,z,tex,1)
  _DrawFlat(x2,y2,x3,y3,x4,y4,z,tex,1)
EndProcedure

Procedure DrawFlat(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,x4.d,y4.d,z.d,tex)
  _DrawFlat(x4,y4,x1,y1,x2,y2,z,tex,0)
  _DrawFlat(x2,y2,x3,y3,x4,y4,z,tex,0)
EndProcedure

Procedure DrawWall(x1.d,y1.d,x2.d,y2.d,z.d,h.d,tex)
  _DrawWall(x1,y1,x2,y2,z,h,tex)
EndProcedure

Procedure DrawSprite(x.d,y.d,z.d,tex,rot=0)
  _DrawSprite(x,y,z,tex,rot)
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 155
; FirstLine = 146
; Folding = ---
; EnableXP