#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

global sens := 1
global Interact := "e"
global Super := "f"
global ClassAbility := "v"
global Grenade := "t"
global Map := "m"

F6:: ; Already >50% progress
{
    OrbitToDreaming()
    Sleep, 40000

    FarmThrall(6)

    Loop
    {
        DoItFresh()
    }

    Return
}

F7:: ; Already 0% progress
{
    OrbitToDreaming()
    Sleep, 40000
    
    FarmThrall()

    Loop
    {
        DoItFresh()
    }

    Return
}

F8::
{
    Loop
    {
        DoItFresh()
    }

    Return
}

F9::
{
    switchToScript  = %A_ScriptDir%\%A_ScriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript%

    Return
}

DoItFresh()
{
    OrbitToTower()
    Sleep, 1000
    CompletePlatCard()
    Sleep, 43000
    DunkSolo()
    BuyFromEva()

    PlanetToDreaming()
    Sleep, 40000

    FarmThrall()
    
    Return 1
}

FarmThrall(amount:=11)
{
    NavigateThrall()
    Loop, %amount%
    {
        LoopThrall()   
    }
    Click

    GhostOrbit()
    Sleep, 3000
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

NavigateThrall()
{
    Sleep, 30
    Send {w down} ; Diagonal move
    Send {d down} ; start
    Sleep, 55
    Send {ShiftDown} ; Sprint start
    DllCall("Sleep", UInt, 7000)
    Send {w up} ; Diagonal move
    Send {d up} ; end
    Send {ShiftUp} ; Sprint end

    Sleep, 200

    TurnLeftDegrees(120, sens)

    Sleep, 200
    
    Return 1
}

LoopThrall()
{
    Loop, 17
    {
        CornerLoop()
    }

    Click up
    Sleep 50

    TurnLeftDegrees(110, sens)
    Sleep, 100
    Send, %Super%
    VerticalLook(30)
    Sleep, 1300
    TurnRightDegrees(110, sens)
    Sleep, 150
    VerticalLook(80)
    Sleep, 100
    
    Return 1
}

CornerLoop()
{
    Click down

    VerticalLook(75)
    Sleep, 600
    Send {s down}
    Send {d down}
    Send, %ClassAbility%
    Click up
    Sleep, 200
    Click down
    Sleep, 1200
    Send, %Grenade%
    Click up
    Sleep, 200
    Click down
    Sleep, 800
    Send {s up}
    Send {d up}
    
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

OrbitToDreaming()
{    
    Send, M
    Sleep, 1000

    MouseClick, Left, X(1593), Y(444), 1, 20 ; Open the Dreaming City
    MouseMove, X(960), Y(0), 10 ; Adjust the map
    Sleep, 3000

    MouseClick, Left, X(935), Y(474), 20 ; Click Shattered Throne
    Sleep, 1000

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 1000

    Return 1
}

PlanetToDreaming()
{
    Send, %Map%
    Sleep, 2000

    Send, D
    Sleep, 3000

    MouseClick, Left, X(1593), Y(444), 1, 20 ; Open the Dreaming City
    MouseMove, X(960), Y(0), 10 ; Adjust the map
    Sleep, 5000

    MouseClick, Left, X(935), Y(474), 20 ; Click Deep Stone Crypt
    Sleep, 3000

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