#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

ToOrbitToCharacter(2)
CharacterToCrypt()
Sleep, 10000 ; Delay for orbit to Europa loading screen
AntiAFK()

CharacterToCrypt()
{    
    Send, M
    Sleep, 1000

    MouseClick, Left, X(220), Y(555), 1, 20 ; Open the Europa
    MouseMove, X(960), Y(0), 10 ; Adjust the map
    Sleep, 3000

    MouseClick, Left, X(1160), Y(560), 20 ; Click Deep Stone Crypt
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