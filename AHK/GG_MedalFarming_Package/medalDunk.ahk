#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
#Include, %A_ScriptDir%/bindings.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

inOrbit = %1%

If (inOrbit)
{
    OrbitToTower()
}
Else
{
    GhostOrbit()
    Sleep, 3000
    OrbitToTower()
}

Sleep, 1000
CompletePlatCard()
Sleep, 43000
DunkSolo()
BuyFromEva()

global dir := A_ScriptDir
global medalFarm := "medalFarm.ahk"

switchToScript  = %dir%\%medalFarm%
Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript% 0

PlanetToTower()
{
    Send, %Map%
    Sleep, 2000

    Send, D
    Sleep, 3000

    MouseClick, Left, X(963), Y(832), 1, 20 ; Open the Tower
    Sleep, 5000

    MouseClick, Left, X(935), Y(470), 20 ; Click Courtyard
    Sleep, 1000
    Click
    Sleep, 3000

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 5000

    Return 1
}

OrbitToTower()
{
    Send, %Map%
    Sleep, 2000

    MouseClick, Left, X(963), Y(832), 1, 20 ; Open the Tower
    Sleep, 1000
    Click
    Sleep, 4000

    MouseClick, Left, X(930), Y(470), 20 ; Click Courtyard
    Sleep, 1000
    Click
    Sleep, 2000

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 5000

    Return 1
}

CompletePlatCard()
{
    Send, %Map% ; Open Destinations
    Sleep, 1000

    Send, A ; Move left to Map
    Sleep, 1000

    Send, A ; Move left to Quests
    Sleep, 1000
    
    MouseClick, Left, X(1395), Y(250), 20 ; Click first bounty slot
    Sleep, 200
    MouseClick, Left, X(1395), Y(250), 20 ; Click first bounty slot
    Sleep, 800
    
    Return 1
}

DunkSolo()
{
    Move("right", 150)
    Move("forward", 5000)
    
    Sleep, 300
    
    Send {%Interact% down} ; Interact start
    DllCall("Sleep", UInt, 2100)
    Send {%Interact% up} ; Interact end

    Move("backward", 2500)
    Move("left", 1100)
    
    Return 1
}

BuyFromEva()
{
    Send {%Interact% down} ; Interact start
    DllCall("Sleep", UInt, 1200)
    Send {%Interact% up} ; Interact end
    DllCall("Sleep", UInt, 3000)

    MouseClick, Left, X(1167), Y(790), 1, 20 ; Buy Raid Card
    Sleep, 1000

    Return 1
}