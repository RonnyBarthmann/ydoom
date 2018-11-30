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

Global width = 640
Global height = 400
Global px.f,py.f,ph.f=100,pa.f
Global OutputDriver = 5 ; 0 = ImageGadget
                         ; 1 = WindowOutput
                         ; 2 = WindowedScreen ( stable / default )
                         ; 3 = Fullscreen
                         ; 4 = FBdev ( Z:\dev\fb0 ) ( not implimented yet )
                         ; 5 = CanvasGadget
Global DebugMode = 1
Global RenderWallTex = 0
Global RenderFlatTex = 0
EnableExplicit

XIncludeFile "output.pbi"
XIncludeFile "textures.pbi"
XIncludeFile "render.pbi"

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

Repeat
  eTime = ElapsedMilliseconds()+1000
  delay = eTime - time
  time = eTime
  SetOutputTitle(OutputDriver,StrF(1000/delay,2))
  
  
  If Not InitOutputDrawing(OutputDriver) : MessageRequester("","StartDrawing()",16) : End : EndIf
  ClearScene()
  
  d = ElapsedMilliseconds()/100
  
  DrawWall(Sin(Radian(d))*300,400+(Cos(Radian(d))*300),Sin(Radian(d+90))*300,400+(Cos(Radian(d+90))*300),100,200,1)
  DrawWall(Sin(Radian(d+90))*300,400+(Cos(Radian(d+90))*300),Sin(Radian(d+180))*300,400+(Cos(Radian(d+180))*300),100,200,2)
  DrawWall(Sin(Radian(d+180))*300,400+(Cos(Radian(d+180))*300),Sin(Radian(d+270))*300,400+(Cos(Radian(d+270))*300),100,200,3)
  DrawWall(Sin(Radian(d+270))*300,400+(Cos(Radian(d+270))*300),Sin(Radian(d))*300,400+(Cos(Radian(d))*300),100,200,4)
  DrawFlat(Sin(Radian(d))*300,400+(Cos(Radian(d))*300),Sin(Radian(d+90))*300,400+(Cos(Radian(d+90))*300),Sin(Radian(d+180))*300,400+(Cos(Radian(d+180))*300),Sin(Radian(d+270))*300,400+(Cos(Radian(d+270))*300),100,5)
  DrawCelling(Sin(Radian(d))*300,400+(Cos(Radian(d))*300),Sin(Radian(d+90))*300,400+(Cos(Radian(d+90))*300),Sin(Radian(d+180))*300,400+(Cos(Radian(d+180))*300),Sin(Radian(d+270))*300,400+(Cos(Radian(d+270))*300),-100,6)
  StopOutputDrawing(OutputDriver)
  
  ExamineKeyboard()
  If KeyboardPushed(#PB_Key_A)
    If KeyboardPushed(#PB_Key_E)
      py + Sin(Radian(pa))*delay/2
      px + Cos(Radian(pa))*delay/2
    Else
      py + Sin(Radian(pa))*delay/5
      px + Cos(Radian(pa))*delay/5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_D)
    If KeyboardPushed(#PB_Key_E)
      py - Sin(Radian(pa))*delay/2
      px - Cos(Radian(pa))*delay/2
    Else
      py - Sin(Radian(pa))*delay/5
      px - Cos(Radian(pa))*delay/5
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
    pa - delay/10
  EndIf
  If KeyboardPushed(#PB_Key_Right)
    pa + delay/10
  EndIf
  If KeyboardPushed(#PB_Key_Escape)
    End
  EndIf
  OutputStuff(OutputDriver)
ForEver


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = -
; EnableXP
; DisableDebugger