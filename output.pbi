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

Global OutputFeature

#DOOM_OutputFeature_None = 0
#DOOM_OutputFeature_Resizable = 1

Enumeration
  #DOOM_OutputDriver_ImageGadget
  #DOOM_OutputDriver_Window
  #DOOM_OutputDriver_WindowedScreen
  #DOOM_OutputDriver_Fullscreen
  #DOOM_OutputDriver_FBDev
  #DOOM_OutputDriver_CanvasGadget
EndEnumeration

Procedure InitOutput(OutputDriver,Feature=0)
  Define Features = 0
  If Feature & #DOOM_OutputFeature_Resizable
    Features | #PB_Window_SizeGadget
    Features | #PB_Window_MaximizeGadget
  EndIf
  Select OutputDriver
    Case #DOOM_OutputDriver_ImageGadget
      PrintN("Use ImageGadgetOutput")
      If OpenWindow(0,0,0,width,height,"",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|Features)
        If CreateImage(0,width,height)
          If ImageGadget(0,0,0,0,0,ImageID(0))
            PrintN("Open ImageGadgetOutput successful")
            ProcedureReturn 1
          EndIf
        EndIf
      EndIf
      PrintN("Cannot open ImageGadgetOutput") : End
    Case #DOOM_OutputDriver_Window
      PrintN("Use WindowOutput")
      If OpenWindow(0,0,0,width,height,"",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|Features)
        PrintN("Open WindowOutput successful")
        ProcedureReturn 1
      EndIf
      PrintN("Cannot open WindowOutput") : End
    Case #DOOM_OutputDriver_WindowedScreen
      PrintN("Use WindowedScreenOutput")
      If InitSprite()
        If OpenWindow(0,0,0,width,height,"",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|Features)
          If OpenWindowedScreen(WindowID(0),0,0,width,height)
            PrintN("Open WindowedScreenOutput successful")
            ProcedureReturn 1
          EndIf
        EndIf
      EndIf
      PrintN("Cannot open WindowedScreenOutput") : End
    Case #DOOM_OutputDriver_Fullscreen
      PrintN("Use FullscreenOutput")
      If InitSprite()
        If OpenScreen(width,height,32,"")
          PrintN("Open FullscreenOutput successful")
          ProcedureReturn 1
        EndIf
      EndIf
      PrintN("Cannot open FullscreenOutput") : End
    Case #DOOM_OutputDriver_FBDev
      PrintN("Use FBDevOutput")
      PrintN("FBDevOutput not implimented yet -> exit") : End
    Case #DOOM_OutputDriver_CanvasGadget
      PrintN("Use CanvasGadgetOutput")
      If OpenWindow(0,0,0,width,height,"",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|Features)
        If CanvasGadget(0,0,0,width,height)
          PrintN("Open CanvasGadgetOutput successful")
          ProcedureReturn 1
        EndIf
      EndIf
      PrintN("Cannot open CanvasGadgetOutput") : End
    Default 
      PrintN("Selected Output not implimented yet -> exit") : End
  EndSelect
EndProcedure

Procedure SetOutputTitle(OutputDriver,str$)
  Select OutputDriver
    Case #DOOM_OutputDriver_ImageGadget
      SetWindowTitle(0,str$)
    Case #DOOM_OutputDriver_Window
      SetWindowTitle(0,str$)
    Case #DOOM_OutputDriver_WindowedScreen
      SetWindowTitle(0,str$)
    Case #DOOM_OutputDriver_CanvasGadget
      SetWindowTitle(0,str$)
  EndSelect
EndProcedure

Procedure InitOutputDrawing(OutputDriver)
  Select OutputDriver
    Case #DOOM_OutputDriver_ImageGadget
      ProcedureReturn StartDrawing(ImageOutput(0))
    Case #DOOM_OutputDriver_Window
      ProcedureReturn StartDrawing(WindowOutput(0))
    Case #DOOM_OutputDriver_WindowedScreen
      ProcedureReturn StartDrawing(ScreenOutput())
    Case #DOOM_OutputDriver_Fullscreen
      ProcedureReturn StartDrawing(ScreenOutput())
    Case #DOOM_OutputDriver_CanvasGadget
      ProcedureReturn StartDrawing(CanvasOutput(0))
  EndSelect
EndProcedure

Procedure StopOutputDrawing(OutputDriver)
  
  If Not OutputDriver
    
  EndIf
  Select OutputDriver
    Case #DOOM_OutputDriver_ImageGadget
      StopDrawing()
      SetGadgetState(0,ImageID(0))
    Case #DOOM_OutputDriver_Window
      StopDrawing()
    Case #DOOM_OutputDriver_WindowedScreen
      StopDrawing()
      FlipBuffers()
    Case #DOOM_OutputDriver_Fullscreen
      StopDrawing()
      FlipBuffers()
    Case #DOOM_OutputDriver_CanvasGadget
      StopDrawing()
  EndSelect
EndProcedure

Procedure OutputStuff(OutputDriver)
  Define success.l
  If MouseSupport
    Select OutputDriver
      Case #DOOM_OutputDriver_ImageGadget, #DOOM_OutputDriver_Window, #DOOM_OutputDriver_WindowedScreen, #DOOM_OutputDriver_CanvasGadget
        If KeyboardPushed(#PB_Key_Tab)
          Repeat
            ExamineKeyboard()
            If KeyboardReleased(#PB_Key_Tab)
              MouseLook = 1 - MouseLook
              Break
            EndIf
            Delay(10)
          ForEver
          ReleaseMouse(1-MouseLook)
        EndIf
      Case #DOOM_OutputDriver_Fullscreen
        ReleaseMouse(1-IsScreenActive())
    EndSelect
  EndIf
  Repeat
    Select WindowEvent()
      Case #PB_Event_SizeWindow
        Select OutputDriver
          Case #DOOM_OutputDriver_ImageGadget
            FreeImage(0)
            width = WindowWidth(0)
            height = WindowHeight(0)
            If CreateImage(0,width,height)
              PrintN("Resize ImageGadgetOutput successful")
            Else
              PrintN("Error when resizing ImageGadgetOutput") : End
            EndIf
          Case #DOOM_OutputDriver_Window
            width = WindowWidth(0)
            height = WindowHeight(0)
            PrintN("Resize WindowOutput successful")
          Case #DOOM_OutputDriver_WindowedScreen
            CloseScreen()
            width = WindowWidth(0)
            height = WindowHeight(0)
            If OpenWindowedScreen(WindowID(0),0,0,width,height)
              PrintN("Resize WindowedScreenOutput successful")
            Else
              PrintN("Error when resizing WindowedScreenOutput") : End
            EndIf
          Case #DOOM_OutputDriver_CanvasGadget
            width = WindowWidth(0)
            height = WindowHeight(0)
            ResizeGadget(0,0,0,width,height)
            PrintN("Resize CanvasGadgetOutput successful")
        EndSelect
      Case #PB_Event_CloseWindow
        End
      Case 0
        ;Delay(10)
        Break
    EndSelect
  ForEver
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = --
; EnableXP