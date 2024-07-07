#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

ToOrbitToCharacter(3)
CharacterToMoon()
MoonToPit()
Sleep, 11000 ; Delay for orbit to dungeon loading screen
AntiAFK()

CharacterToMoon()
{
    Send, M
    Sleep, 4000

    MouseClick, Left, X(1549), Y(879), 1, 20 ; Open the moon
    MouseMove, X(960), Y(1080), 10 ; Adjust the map
    Sleep, 3000
    
    Return 1
}

MoonToPit()
{
    MouseMove, X(960), Y(0) ; Adjust Map
    Sleep, 3000

    MouseClick, Left, X(1300), Y(670), 20 ; Click MoonToPit
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