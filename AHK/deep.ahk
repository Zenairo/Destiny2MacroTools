#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;	#Warn
SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

; This script automates taking a character from in-game, to char select, to the first slot,
; to the moon, to the mission flag for In The Deep. Used for farming catalysts and weapons
; significantly faster than Shuro Chi. Also the location the gunfarm scripts are used in.

SpeedMultiplier := 1.17

ToOrbitToCharacter()
CharacterToSanctuary()
Sleep, 10000 ; Delay for orbit to moon loading screen
SensitivityOne() ; Reduce sens while waiting (takes 10s)
Sleep, 20000 ; Finish 40s delay
SanctuaryToDeep()
Sleep, 30000
AntiAFK()

SanctuaryToDeep()
{
    Move("forward", 1200)
    Move("right", 2000)
    Move("forward", 3000)
    Sleep, 500
    Move("backward", 500, false)
    
    SpeedMultiplier := 1.0
    GetOnSparrow()
    TurnLeftDegrees(117)
    Move("forward", 4500)
    TurnRightDegrees(45)
    Move("forward", 4100)
    TurnRightDegrees(36)
    Move("forward", 4000)
    TurnLeftDegrees(24)
    Move("forward", 5200)
    TurnRightDegrees(65)
    Move("forward", 3500)
    TurnRightDegrees(30)
    Move("forward", 2500)
    Sleep, 1000
    GetOffSparrow("right")
    SpeedMultiplier := 1.17

    Sleep, 1000
    Move("forward", 500)
    Sleep, 1000
    Send, {e Down}
    Sleep, 1000
    Send, {e Up}

}

AntiAFK()
{
    Loop
    {
        Move("left", 100, false)
        Sleep, 500
        Move("right", 100, false)
        Sleep, 500
        TurnRightDegrees(45)
        Sleep, 500
        Click
        Sleep, 500
        TurnLeftDegrees(45)
        Sleep, 500
        Click
        Sleep, 500
    }
}

MoonToSantuary()
{
    Send, M
    Sleep, 2500

    MouseMove, X(960), Y(1080), 10 ; Adjust the map
    Sleep, 1000

    MouseMove, X(840), Y(460), 10 ; Move cursor to Sanctuary
    Sleep, 1000
    
    Click, Down ; Click Sanctuary
    Sleep, 1100 ; Delay for fast travel press
    Click, Up

    MouseMove, X(960), Y(540), 2
    Sleep, 18000 ; Delay for fast travel loading screen

    Return 1
} 

CharacterToSanctuary()
{    
    Send, M
    Sleep, 1000

    MouseClick, Left, X(1549), Y(879), 1, 20 ; Open the moon
    MouseMove, X(960), Y(1080), 10 ; Adjust the map
    Sleep, 3000

    MouseClick, Left, X(840), Y(460), 20 ; Click Sanctuary landing point on the moon
    Sleep, 1000

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 1000

    Return 1
}
