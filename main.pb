Global width = 640
Global height = 400
Global px.f,py.f,ph.f=100,pa.f
Global OutputDriver = 2 ; 0 = ImageGadget
                         ; 1 = WindowOutput
                         ; 2 = WindowedScreen ( stable / default )
                         ; 3 = Fullscreen
                         ; 4 = FBdev ( Z:\dev\fb0 ) ( not implimented yet )
                         ; 5 = CanvasGadget
Global DebugMode = 0
Global RenderWallTex = 0
Global RenderFlatTex = 0
Global RenderFailsafe = 1
EnableExplicit

XIncludeFile "output.pbi"
XIncludeFile "textures.pbi"
XIncludeFile "render.pbi"
XIncludeFile "player.pbi"
XIncludeFile "map.pbi"

OpenConsole()
UsePNGImageDecoder()
InitKeyboard()

Define eTime, time, delay

If Not InitOutput(OutputDriver,#DOOM_OutputFeature_Resizable)
  End
EndIf

DummyTex(0,32,RGB(85,85,85),RGB(170,170,170))
DummyTex(1,32,RGB(0,0,170),RGB(85,85,255))
DummyTex(2,32,RGB(0,170,0),RGB(85,255,85))
DummyTex(3,32,RGB(170,0,0),RGB(255,85,85))
DummyTex(4,32,RGB(0,170,170),RGB(85,255,255))
DummyTex(5,32,RGB(170,170,0),RGB(255,255,85))
DummyTex(6,32,RGB(170,0,170),RGB(255,85,255))
  
Define d.d = -45 , oy.l, ox.l, y.d, x.d

InitIWAD("")
LoadMap("map03")
Repeat
  eTime = ElapsedMilliseconds()+1000
  delay = eTime - time
  time = eTime
  SetOutputTitle(OutputDriver,StrF(1000/delay,2))
  
  
  If Not InitOutputDrawing(OutputDriver) : MessageRequester("","StartDrawing()",16) : End : EndIf
  ClearScene()
  
  d = ElapsedMilliseconds()/100
  
  DrawRooms(getNearestRoom(1))
  StopOutputDrawing(OutputDriver)
  
  ExamineKeyboard()
  If KeyboardPushed(#PB_Key_A)
    If KeyboardPushed(#PB_Key_E)
      py - Sin(Radian(pa))*delay/2
      px - Cos(Radian(pa))*delay/2
    Else
      py - Sin(Radian(pa))*delay/5
      px - Cos(Radian(pa))*delay/5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_D)
    If KeyboardPushed(#PB_Key_E)
      py + Sin(Radian(pa))*delay/2
      px + Cos(Radian(pa))*delay/2
    Else
      py + Sin(Radian(pa))*delay/5
      px + Cos(Radian(pa))*delay/5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_W) Or KeyboardPushed(#PB_Key_Up)
    If KeyboardPushed(#PB_Key_E)
      px - Sin(Radian(pa))*delay/2
      py + Cos(Radian(pa))*delay/2
    Else
      px - Sin(Radian(pa))*delay/5
      py + Cos(Radian(pa))*delay/5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_S) Or KeyboardPushed(#PB_Key_Down)
    If KeyboardPushed(#PB_Key_E)
      px + Sin(Radian(pa))*delay/2
      py - Cos(Radian(pa))*delay/2
    Else
      px + Sin(Radian(pa))*delay/5
      py - Cos(Radian(pa))*delay/5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Left)
    pa + delay/10
  EndIf
  If KeyboardPushed(#PB_Key_Right)
    pa - delay/10
  EndIf
  If KeyboardPushed(#PB_Key_Escape)
    End
  EndIf
  OutputStuff(OutputDriver)
ForEver


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 42
; FirstLine = 14
; EnableXP