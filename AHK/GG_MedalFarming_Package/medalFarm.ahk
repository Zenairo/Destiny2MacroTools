#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
#Include, %A_ScriptDir%/bindings.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

inOrbit = %1%

If (inOrbit)
{
    OrbitToDreaming()
}
Else
{
    PlanetToDreaming()
}

Sleep, 40000

NavigateThrall()

Loop
{
    LoopThrall()   
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    VerticalLook(75)
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
