#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

DllCall("mouse_event", uint, 1, int, 0, int, 50000)
Sleep, 200
DllCall("mouse_event", uint, 1, int, 0, int, -12650)

RoomToFarm()

loop
{
    TheFarm()
}

RoomToFarm()
{
    Move("backward", 350)
    Move("left", 400)
    Sleep, 1520
}

TheFarm()
{
    Send {q down} ; Grenade
    DllCall("Sleep", UInt, 1) ; Sleep, %A%
    Send {q up} ; Grenade
    
    Send {a down} ; Start Walk Left
    Send {w down} ; Move Forward Left

    DllCall("Sleep", UInt, 12) ; Sleep, %B%
    
    Send {a up} ; Stop Walk Left
    Send {w up} ; Move Forward Left
    
    DllCall("Sleep", UInt, 4187) ; Sleep, %C%
}
