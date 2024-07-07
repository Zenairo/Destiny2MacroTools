#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

DestinyExe := "C:\Program Files (x86)\Steam\steamapps\common\Destiny 2\destiny2.exe"

Process, Exist, destiny2.exe

if ErrorLevel != 0
{
	Process, Close, destiny2.exe
	Sleep, 5000
}

Run, %DestinyExe%
Sleep, 65000

Click, X(960), Y(540)
Send, {Enter}

Sleep, 35000

MouseClick, Left, X(1500), Y(450), 1, 20 ; Click character slot 1
