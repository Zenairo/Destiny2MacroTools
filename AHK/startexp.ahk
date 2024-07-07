#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

loop
{
    TheFarm()
}

TheFarm()
{
    Send, q
    Sleep, 800
    MouseMove, 0, 50, 5, R
    Sleep, 400
    MouseMove, 0, -50, 5, R
    Sleep, 2600
}
