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
; CursorPosition = 15
; Folding = -
; EnableXP