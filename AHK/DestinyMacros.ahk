global Rotation := 0
global OnSparrow
global SpeedMultiplier := 1

ToOrbitToCharacter( select:=1 )
{
    Switch select
    {
        Case 1:
            select := 450
        Case 2:
            select := 550
        Case 3:
            select := 650
        Default:
            select := 450
    }

    Send, {Esc} ; Open game options menu
    MouseClick, Left, X(650), Y(600), 1, 25  ; Click [Change character]
    Sleep, 1500
    
    Send, {Enter} ; Accept character change
    Sleep, 7500

    MouseClick, Left, X(1500), Y(select), 1, 20 ; Click specified character slot
    Sleep, 1000
    MouseClick, Left, X(1500), Y(select), 1, 20 ; Click failsafe
    Sleep, 1000
    MouseClick, Left, X(1500), Y(select), 1, 20 ; Click failsafe
    Sleep, 6000
    
    Return 1
}

GhostOrbit()
{
    Send {Tab}
    Sleep, 1200

    Send {o down} ; Orbit
    DllCall("Sleep", UInt, 4200) ; Sleep, %A%
    Send {o up} ; Orbit
    DllCall("Sleep", UInt, 5000) ; Sleep, %A%
}

Join( user )
{
    Send, {Enter}
    Sleep, 500
    SendRaw, /join
    Send, {Space}
    SendRaw, %user%
    Sleep, 2000
    Send, {Enter}
    Sleep, 1000
    Send, {Enter}

    Return 1
}

Move( direction, duration, sprint:=True, jump:=0 )
{
    StringLower, direction, direction
    Switch direction
    {
        Case "forward", "w", "fwd":
            direction := "w"
        Case "left", "a":
            direction := "a"
        Case "backward", "backwards", "back", "s":
            direction := "s"
        Case "right", "d":
            direction := "d"
        Default:
            direction := "w"
    }

    duration := duration

    Send, {%direction% Down}
    
    if (sprint And OnSparrow)
        MouseClick, right,,,,,D
    else if (sprint)
        Send, {ShiftDown}

    if (jump >= 1 And duration >= 200)
    {
        Sleep, 200
        Send, {Space down}
        DllCall("Sleep", UInt, 200)
        Send, {Space up}

        duration := duration - 200
        jump := jump - 1
    }

    if (jump >= 1 And duration >= 200)
    {
        Sleep, 200
        Send, {Space}
        duration := duration - 200
        jump := jump - 1
    }

    if (jump >= 1 And duration >= 400)
    {
        Sleep, 400
        Send, {Space}
        duration := duration - 400
        jump := jump - 1
    }
    
    Sleep, duration * SpeedMultiplier

    if (sprint And OnSparrow)
        MouseClick, right,,,,,U
    else if (sprint)
        Send, {ShiftUp}
    
    Send, {%direction% Up}

    Return 1
}

GetOnSparrow()
{
    OnSparrow := True

    Sleep, 200
    Send, {Tab}
    Sleep, 500
    Send, {e Down}
    Sleep, 500
    Send, {e Up}
    Sleep, 2000
}

GetOffSparrow(direction:="left")
{
    StringLower, direction, direction

    if (direction = "right")
        Send, {d Down}
        
    Sleep, 40
    Send, {Space}
    Sleep, 40

    if (direction = "right")
        Send, {d Up}

    OnSparrow = False
}

VerticalLook( deg:=0, sens:=2 )
{
    ;Aim all the way down
    DllCall("mouse_event", uint, 1, int, 0, int, 54545.5)
    Sleep, 50
    ; This value is close but not perfect
    deg := deg * ( (27272.75 / sens) / 180)
    DllCall("mouse_event", uint, 1, int, 0, int, - deg)
}

TurnRightDegrees( deg, sens:=1 )
{
    if (OnSparrow)
        Sleep, 500
    deg := deg * ( (54545.5 / sens) / 360)
    DllCall("mouse_event", uint, 1, int, deg, int, 0)
    if (OnSparrow)
        Sleep, 600

    Rotation := Rotation + deg
}

TurnLeftDegrees( deg, sens:=1 )
{
    if (OnSparrow)
        Sleep, 500
    deg := -1 * deg * ( (54545.5 / sens) / 360)
    DllCall("mouse_event", uint, 1, int, deg, int, 0)
    if (OnSparrow)
        Sleep, 600

    Rotation := Rotation - deg
}

SensitivityOne()
{
    Send {F1} ; Options menu
    DllCall("Sleep", UInt, 2000) ; Sleep
    
    Send {d}
    DllCall("Sleep", UInt, 1000) ; Sleep

    Send {d}
    DllCall("Sleep", UInt, 1000) ; Sleep
    
    MouseMove, X(1479), Y(251), 10 ; Cursor over adjust
    
    MouseClick, left,,,,,D
    DllCall("Sleep", UInt, 6000) ; Sleep
    MouseClick, left,,,,,U
    
    Send, {Esc} ; Close game options menu
}

X(n)
{
	return n * (A_ScreenWidth / 1920.0)
}

Y(n)
{
	return n * (A_ScreenHeight / 1080.0)
}