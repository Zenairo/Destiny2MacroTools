#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

loop
{
    RepeatThis()
}

RepeatThis()
{
    Send, t
    Sleep, 100
    Send, {s Down}
    Sleep, 100
    Send, {s Up}
    Sleep, 100
    ; Send, v
    Sleep, 20000
}
