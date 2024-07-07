#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
;test 

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

loop
{
    RepeatThis()
}

RepeatThis()
{
    Send, q
    Sleep, 800
    MouseMove, 0, 50, 5, R
    Sleep, 400
    MouseMove, 0, -50, 5, R
    Sleep, 1600
}
