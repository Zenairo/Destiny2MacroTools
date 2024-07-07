#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

ToOrbitToCharacter( 1 )
