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

Structure wl
  id.u:leftP.d:rightP.d:upperP.d:lowerP.d:leftTex.u:rightTex.u:upperTex.u:lowerTex.u:
EndStructure
Structure rd
  x1.d:y1.d:x2.d:y2.d:x3.d:y3.d:x4.d:y4.d:groundY.d:height.d:front.wl:right.wl:back.wl:left.wl:cover.wl:ground.wl
EndStructure
Global Dim RoomData.rd(1023)
Global Dim RoomDraw(1023)
Global Rooms

Procedure InitIWAD(name$)
  OpenPreferences(name$)
  If name$
    If UCase(ReadPreferenceString("type","")) = "IWAD"
      PrintN("Using IWAD "+name$)
      ProcedureReturn 1
    Else
      PrintN("Cannot find IWAD "+name$)
      ProcedureReturn 0
    EndIf
  EndIf
  ClosePreferences()
  OpenPreferences("yDOOM.wad")
  If UCase(ReadPreferenceString("type","")) = "IWAD"
    PrintN("Using default IWAD yDOOM.wad")
    ProcedureReturn 1
  EndIf
  ClosePreferences()
  OpenPreferences("yDOOM2.wad")
  If UCase(ReadPreferenceString("type","")) = "IWAD"
    PrintN("Using default IWAD yDOOM2.wad")
    ProcedureReturn 1
  EndIf
  ClosePreferences()
  PrintN("Cannot find default IWAD")
  PrintN("please copy yDOOM.wad or yDOOM2.wad into the program folder")
  ProcedureReturn 0
EndProcedure

Procedure LoadMap(name$)
  Define i,room$
  If Not PreferenceGroup(name$)
    PrintN("Cannot find Map "+name$)
    ProcedureReturn 0
  EndIf
  px = ReadPreferenceDouble("StartX",19283746)
  py = ReadPreferenceDouble("StartY",19283746)
  pa = ReadPreferenceDouble("StartA",19283746)
  Rooms = ReadPreferenceInteger("sectors",19283746)
  If px = 19283746 : PrintN("Map: "+name$+" - Cannot find player StartX") : ProcedureReturn 0 : EndIf
  If py = 19283746 : PrintN("Map: "+name$+" - Cannot find player StartY") : ProcedureReturn 0 : EndIf
  If pa = 19283746 : PrintN("Map: "+name$+" - Cannot find player Angle") : ProcedureReturn 0 : EndIf
  If Rooms = 19283746 : PrintN("Map: "+name$+" - Cannot find count of sectors") : ProcedureReturn 0 : EndIf
  For i = 0 To Rooms-1
    room$ = ReadPreferenceString("sec"+RSet(Str(i),5,"0"),"")
    If room$ = "" : PrintN("Map: "+name$+" - sector sec"+RSet(Str(i),5,"0")+" has no data") : ProcedureReturn 0 : EndIf
    RoomData(i)\x1 = ValD(StringField(room$,1,",")) : RoomData(i)\y1 = ValD(StringField(room$,2,","))
    RoomData(i)\x2 = ValD(StringField(room$,3,",")) : RoomData(i)\y2 = ValD(StringField(room$,4,","))
    RoomData(i)\x3 = ValD(StringField(room$,5,",")) : RoomData(i)\y3 = ValD(StringField(room$,6,","))
    RoomData(i)\x4 = ValD(StringField(room$,7,",")) : RoomData(i)\y4 = ValD(StringField(room$,8,","))
    RoomData(i)\groundY = ValD(StringField(room$,9,",")) : RoomData(i)\height = ValD(StringField(room$,10,","))
    RoomData(i)\front\id = Val(StringField(room$,11,","))
    RoomData(i)\front\leftP = ValD(StringField(room$,12,",")) : RoomData(i)\front\rightP = ValD(StringField(room$,13,","))
    RoomData(i)\front\upperP = ValD(StringField(room$,14,",")) : RoomData(i)\front\lowerP = ValD(StringField(room$,15,","))
    RoomData(i)\front\leftTex = Val(StringField(room$,16,",")) : RoomData(i)\front\rightTex = Val(StringField(room$,17,","))
    RoomData(i)\front\upperTex = Val(StringField(room$,18,",")) : RoomData(i)\front\lowerTex = Val(StringField(room$,19,","))
    RoomData(i)\right\id = Val(StringField(room$,20,","))
    RoomData(i)\right\leftP = ValD(StringField(room$,21,",")) : RoomData(i)\right\rightP = ValD(StringField(room$,22,","))
    RoomData(i)\right\upperP = ValD(StringField(room$,23,",")) : RoomData(i)\right\lowerP = ValD(StringField(room$,24,","))
    RoomData(i)\right\leftTex = Val(StringField(room$,25,",")) : RoomData(i)\right\rightTex = Val(StringField(room$,26,","))
    RoomData(i)\right\upperTex = Val(StringField(room$,27,",")) : RoomData(i)\right\lowerTex = Val(StringField(room$,28,","))
    RoomData(i)\back\id = Val(StringField(room$,29,","))
    RoomData(i)\back\leftP = ValD(StringField(room$,30,",")) : RoomData(i)\back\rightP = ValD(StringField(room$,31,","))
    RoomData(i)\back\upperP = ValD(StringField(room$,32,",")) : RoomData(i)\back\lowerP = ValD(StringField(room$,33,","))
    RoomData(i)\back\leftTex = Val(StringField(room$,34,",")) : RoomData(i)\back\rightTex = Val(StringField(room$,35,","))
    RoomData(i)\back\upperTex = Val(StringField(room$,36,",")) : RoomData(i)\back\lowerTex = Val(StringField(room$,37,","))
    RoomData(i)\left\id = Val(StringField(room$,38,","))
    RoomData(i)\left\leftP = ValD(StringField(room$,39,",")) : RoomData(i)\left\rightP = ValD(StringField(room$,40,","))
    RoomData(i)\left\upperP = ValD(StringField(room$,41,",")) : RoomData(i)\left\lowerP = ValD(StringField(room$,42,","))
    RoomData(i)\left\leftTex = Val(StringField(room$,43,",")) : RoomData(i)\left\rightTex = Val(StringField(room$,44,","))
    RoomData(i)\left\upperTex = Val(StringField(room$,45,",")) : RoomData(i)\left\lowerTex = Val(StringField(room$,46,","))
    RoomData(i)\cover\id = Val(StringField(room$,47,","))
    RoomData(i)\cover\leftP = ValD(StringField(room$,48,",")) : RoomData(i)\cover\rightP = ValD(StringField(room$,49,","))
    RoomData(i)\cover\upperP = ValD(StringField(room$,50,",")) : RoomData(i)\cover\lowerP = ValD(StringField(room$,51,","))
    RoomData(i)\cover\leftTex = Val(StringField(room$,52,",")) : RoomData(i)\cover\rightTex = Val(StringField(room$,53,","))
    RoomData(i)\cover\upperTex = Val(StringField(room$,54,",")) : RoomData(i)\cover\lowerTex = Val(StringField(room$,55,","))
    RoomData(i)\ground\id = Val(StringField(room$,56,","))
    RoomData(i)\ground\leftP = ValD(StringField(room$,57,",")) : RoomData(i)\ground\rightP = ValD(StringField(room$,58,","))
    RoomData(i)\ground\upperP = ValD(StringField(room$,59,",")) : RoomData(i)\ground\lowerP = ValD(StringField(room$,60,","))
    RoomData(i)\ground\leftTex = Val(StringField(room$,61,",")) : RoomData(i)\ground\rightTex = Val(StringField(room$,62,","))
    RoomData(i)\ground\upperTex = Val(StringField(room$,63,",")) : RoomData(i)\ground\lowerTex = Val(StringField(room$,64,","))
  Next
  PrintN("Map "+name$+" successfully loaded")
  ProcedureReturn 1
EndProcedure

Procedure getNearestRoom(init)
  Define i,dist.d=99999999,room,a.d,b.d,c.d
  For i = init To Rooms-1
    a=RoomData(i)\x1 : b=RoomData(i)\y1
    a+RoomData(i)\x2 : b+RoomData(i)\y2
    a+RoomData(i)\x3 : b+RoomData(i)\y3
    a+RoomData(i)\x4 : b+RoomData(i)\y4
    a/4 : a=Abs(a-px) : b/4 : b=Abs(b-py)
    c=Sqr((a*a)+(b*b)) : If c<dist : room=i : dist=c : EndIf
  Next
  ProcedureReturn room
EndProcedure

Procedure _DrawRoomSide(x1.d,y1.d,x2.d,y2.d,h.d,z.d,left.d,right.d,upper.d,lower.d,leTex,riTex,upTex,loTex)
  Define tempX.d,tempY.d,tempH.d
  If left = 100
    DrawWallPOV(x1,y1,x2,y2,h,z,leTex)
    ProcedureReturn
  ElseIf left
    tempX = ((x1*(100-left))+(x2*left))/100
    tempY = ((y1*(100-left))+(y2*left))/100
    DrawWallPOV(x1,y1,tempX,tempY,h,z,leTex)
    x1 = tempX
    y1 = tempY
  EndIf
  If right = 100
    DrawWallPOV(x1,y1,x2,y2,h,z,riTex)
    ProcedureReturn
  ElseIf right
    tempX = ((x1*right)+(x2*(100-right)))/100
    tempY = ((y1*right)+(y2*(100-right)))/100
    DrawWallPOV(tempX,tempY,x2,y2,h,z,riTex)
    x2 = tempX
    y2 = tempY
  EndIf
  If upper = 100
    DrawWallPOV(x1,y1,x2,y2,h,z,upTex)
    ProcedureReturn
  ElseIf upper
    tempH = (h*upper)/100
    DrawWallPOV(x1,y1,x2,y2,tempH,z-h+tempH,upTex)
    h - tempH
  EndIf
  If lower = 100
    DrawWallPOV(x1,y1,x2,y2,h,z,upTex)
    ProcedureReturn
  ElseIf upper
    h = (h*lower)/100
    DrawWallPOV(x1,y1,x2,y2,h,z,upTex)
  EndIf
EndProcedure

Procedure _DrawRoom(room)
  DrawFlatPOV(RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\groundY,RoomData(room)\ground\leftTex)
  DrawCellingPOV(RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\groundY-RoomData(room)\height,RoomData(room)\cover\leftTex)
  If RoomData(room)\back\id : _DrawRoomSide(RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\back\leftP,RoomData(room)\back\rightP,RoomData(room)\back\upperP,RoomData(room)\back\lowerP,RoomData(room)\back\leftTex,RoomData(room)\back\rightTex,RoomData(room)\back\upperTex,RoomData(room)\back\lowerTex)
    Else : DrawWallPOV(RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\back\leftTex) : EndIf
  If RoomData(room)\right\id : _DrawRoomSide(RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\right\leftP,RoomData(room)\right\rightP,RoomData(room)\right\upperP,RoomData(room)\right\lowerP,RoomData(room)\right\leftTex,RoomData(room)\right\rightTex,RoomData(room)\right\upperTex,RoomData(room)\right\lowerTex)
    Else : DrawWallPOV(RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\right\leftTex) : EndIf
  If RoomData(room)\front\id : _DrawRoomSide(RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\front\leftP,RoomData(room)\front\rightP,RoomData(room)\front\upperP,RoomData(room)\front\lowerP,RoomData(room)\front\leftTex,RoomData(room)\front\rightTex,RoomData(room)\front\upperTex,RoomData(room)\front\lowerTex)
    Else : DrawWallPOV(RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\front\leftTex) : EndIf
  If RoomData(room)\left\id : _DrawRoomSide(RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\left\leftP,RoomData(room)\left\rightP,RoomData(room)\left\upperP,RoomData(room)\left\lowerP,RoomData(room)\left\leftTex,RoomData(room)\left\rightTex,RoomData(room)\left\upperTex,RoomData(room)\left\lowerTex)
    Else : DrawWallPOV(RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\height,RoomData(room)\groundY,RoomData(room)\left\leftTex) : EndIf
EndProcedure

Procedure DrawRoom(room)
  RoomDraw(room) = 0
  If IfLineVisPOV(RoomData(room)\x1,RoomData(room)\y1,RoomData(room)\x2,RoomData(room)\y2)
    If RoomDraw(RoomData(room)\back\id) : DrawRoom(RoomData(room)\back\id) : EndIf : EndIf
  If IfLineVisPOV(RoomData(room)\x2,RoomData(room)\y2,RoomData(room)\x3,RoomData(room)\y3)
    If RoomDraw(RoomData(room)\right\id) : DrawRoom(RoomData(room)\right\id) : EndIf : EndIf
  If IfLineVisPOV(RoomData(room)\x3,RoomData(room)\y3,RoomData(room)\x4,RoomData(room)\y4)
    If RoomDraw(RoomData(room)\front\id) : DrawRoom(RoomData(room)\front\id) : EndIf : EndIf
  If IfLineVisPOV(RoomData(room)\x4,RoomData(room)\y4,RoomData(room)\x1,RoomData(room)\y1)
    If RoomDraw(RoomData(room)\left\id) : DrawRoom(RoomData(room)\left\id) : EndIf : EndIf
  _DrawRoom(room)
EndProcedure

Procedure DrawRooms(start)
  Define i
  For i = 0 To 1023
    RoomDraw(i) = 1
  Next
  If start < Rooms
    DrawRoom(start)
    ProcedureReturn 1
  Else
    PrintN("POV-sector "+start+" dos not exist")
    ProcedureReturn 0
  EndIf
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = --
; EnableXP