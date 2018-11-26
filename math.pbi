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
; CursorPosition = 29
; Folding = -
; EnableXP