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
; CursorPosition = 44
; FirstLine = 2
; Folding = -
; EnableXP