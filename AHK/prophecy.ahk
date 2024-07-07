#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

ToOrbitToCharacter(2)
CharacterToProphecy()
Sleep, 10000 ; Delay for orbit to Europa loading screen
AntiAFK()

CharacterToProphecy()
{
    Send, M 
    Sleep, 1000

    MouseClick, Left, X(1240), Y(180), 1, 20 ; Open Legends
    Sleep, 3000

    MouseClick, Left, X(960), Y(825) ; Click Prophecy 
    Sleep, 1000

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 1000
    
    Return 1
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