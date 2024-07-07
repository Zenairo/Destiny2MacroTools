#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

MouseClick, Left, X(1500), Y(450), 1, 20 ; Click to guarantee text isn't open

TunnelToRoom()

FarmToWait()

MouthToRoom()
{
    Move("forward", 2500)
}

TunnelToRoom()
{
    TurnRightDegrees(180)
    Move("forward", 4500)
    TurnRightDegrees(75)
    Move("forward", 4200)
    TurnRightDegrees(65)
    Move("forward", 4500)
    TurnLeftDegrees(60)
    Move("forward", 2200)
    TurnRightDegrees(14)

    Return 1
}

FarmToWait()
{
    Move("right", 300)
    Move("forward", 250)
}
