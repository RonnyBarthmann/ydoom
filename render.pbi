XIncludeFile "math.pbi"
XIncludeFile "renderMath.pbi"

Global Scale.f = height / 200
Global Dim ZBuffer.l(7679,4319) ; Max 8k ( 4320p )

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
      ZBuffer.l(x,y) = 16777215
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
      If RenderFailsafe
        For i = x1 To x2
          ty = GetCeiling3Dy(width,height,i,y,z,0)
          tx = GetCeiling3Dx(width,height,i,y,z,ty)
          Box(i,y,1,1,GetTexPixel(tex,tx,ty))
        Next
      Else
        For i = x1 To x2
          ty = GetCeiling3Dy(width,height,i,y,z,0)
          tx = GetCeiling3Dx(width,height,i,y,z,ty)
          Plot(i,y,GetTexPixel(tex,tx,ty))
        Next
      EndIf
    Else
      If RenderFailsafe
        For i = x1 To x2
          ty = GetFlat3Dy(width,height,i,y,z,0)
          tx = GetFlat3Dx(width,height,i,y,z,ty)
          Box(i,y,1,1,GetTexPixel(tex,tx,ty))
        Next
      Else
        For i = x1 To x2
          ty = GetFlat3Dy(width,height,i,y,z,0)
          tx = GetFlat3Dx(width,height,i,y,z,ty)
          Plot(i,y,GetTexPixel(tex,tx,ty))
        Next
      EndIf
    EndIf
  Else
    LineXY(x1,y,x2,y,GetTexPixel(tex,0,0))
  EndIf
EndProcedure

Procedure _DrawLineY(x,y1,y2,tx.d,h.d,tex)
  Define i,ty.d,yTexStep.d,c
  If y1 < 0 : y1 = 0 : EndIf
  If y2 > height-1 : y2 = height-1 : EndIf
  If y1 > y2 : ProcedureReturn : EndIf
  If y2 < y1 : ProcedureReturn : EndIf
  If x < 0 : ProcedureReturn : EndIf
  If x > width-1 : ProcedureReturn : EndIf
  yTexStep = h / ( y2 - y1 )
  If RenderWallTex
    If RenderFailsafe
      For i = y1 To y2
        Box(x,i,1,1,GetTexPixel(tex,tx,ty))
        ty + yTexStep
      Next
    Else
      For i = y1 To y2
        Plot(x,i,GetTexPixel(tex,tx,ty))
        ty + yTexStep
      Next
    EndIf
  Else
    LineXY(x,y1,x,y2,GetTexPixel(tex,0,0))
  EndIf
EndProcedure

Procedure _DrawFlat2(x1.d,y1.d,x2.d,y2.d,x3.d,y3.d,z.d,tex,cell)
  Define aTriHigh,aLeftStep.d,aRightStep.d,vTriHigh,vLeftStep.d,vRightStep.d
  Define ox1,oy1,ox2,oy2,ox3,oy3,TriMode,i,oxL.d,oxR.d,ox4,oy4,oy
  If y1 > 0
    ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
    oy1 = ( ( z * ( height / 2 ) ) / y1 ) + ( height / 2 )
  Else
    ProcedureReturn
  EndIf
  If y2 > 0
    ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
    oy2 = ( ( z * ( height / 2 ) ) / y2 ) + ( height / 2 )
  Else
    ProcedureReturn
  EndIf
  If y3 > 0
    ox3 = ( ( x3 * ( height / 2 ) ) / y3 ) + ( width / 2 )
    oy3 = ( ( z * ( height / 2 ) ) / y3 ) + ( height / 2 )
  Else
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
  If DebugMode
    Box(ox1-2,oy1-2,5,5,255)
    Box(ox2-2,oy2-2,5,5,255)
    Box(ox3-2,oy3-2,5,5,255)
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
EndProcedure

Procedure IfLineVis(x1.d,y1.d,x2.d,y2.d)
  Define ox1,ox2
  If y1 > 0
    ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
  Else
    ProcedureReturn 0
  EndIf
  If y2 > 0
    ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
  Else
    ProcedureReturn 0
  EndIf
  If ox2 > ox1
    If ox2 > 0
      If ox1 < width
        ProcedureReturn 1
      EndIf
    EndIf
  EndIf
  ProcedureReturn 0
EndProcedure

Procedure _DrawWall2(x1.d,y1.d,x2.d,y2.d,z.d,h.d,tex)
  Define ox1,oy1,oh1,ox2,oy2,oh2,yWallStep.d,hWallStep.d,xTexStep.d,oy.d,oh.d,i,tx.d,reverse
  ox1 = ( ( x1 * ( height / 2 ) ) / y1 ) + ( width / 2 )
  oy1 = ( ( z * ( height / 2 ) ) / y1 ) + ( height / 2 )
  oh1 =   ( h * ( height / 2 ) ) / y1
  ox2 = ( ( x2 * ( height / 2 ) ) / y2 ) + ( width / 2 )
  oy2 = ( ( z * ( height / 2 ) ) / y2 ) + ( height / 2 )
  oh2 =   ( h * ( height / 2 ) ) / y2
  If DebugMode
    Line(ox1,oy1,1,-oh1,255)
    Line(ox2,oy2,1,-oh2,255)
  EndIf
  If ox1 = ox2
    ProcedureReturn
  EndIf
  reverse = 0
  If ox1 > ox2
    Swap ox1, ox2
    Swap oy1, oy2
    Swap oh1, oh2
    reverse = 1
    ProcedureReturn ; Draw only one side
  EndIf
  yWallStep = ( oy2 - oy1 ) / ( ox2 - ox1 )
  hWallStep = ( oh2 - oh1 ) / ( ox2 - ox1 )
  oy = oy1
  oh = oh1
  If reverse
    xTexStep = 0 - ( Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) ) / ( ox2 - ox1 ) )
    tx = Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) )
  Else
    xTexStep = Sqr( ( ( x1 - x2 ) * ( x1 - x2 ) ) + ( ( y1 - y2 ) * ( y1 - y2 ) ) ) / ( ox2 - ox1 )
    tx = 0
  EndIf
  For i = ox1 To ox2
    _DrawLineY(i,oy-oh,oy,tx,h,tex)
    oy + yWallStep
    oh + hWallStep
    tx + xTexStep
  Next
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


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 88
; FirstLine = 41
; Folding = --
; EnableXP