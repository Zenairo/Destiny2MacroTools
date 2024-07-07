#SingleInstance Force
#MaxThreadsPerHotkey, 2
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
#Include, %A_ScriptDir%/bindings.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%


global freshGame := true

global bountyState := "Unknown"
global prevBountyState := "Unknown"
global bountyStateChanged := false

global handledChange := false
global changeTimer := 0

global scriptState := "None"

global apiWait := 20 ; Seconds

global medalDunk := "medalDunk.ahk"
global medalFarm := "medalFarm.ahk"

global dir := A_ScriptDir
global medalProgressScript
medalProgressScript  = %dir%\medalProgress.pyw

F8::
{
    Loop
    {
    
        CheckDestiny()
        
        CheckBounty()
    
        If (freshGame)
        {
            FreshStart()
        }
        Else
        {
            Tick()
        }
    
        Sleep, 20000
    }
    
    Return
}

F9::
{
    StopScripts(true)
    
    Return
}

CheckDestiny()
{
    Process, Exist, destiny2.exe

    If ErrorLevel != 0
    {
        Return 1
    }
    Else
    {
        StopScripts()

        Sleep, 1000

        Run, %DestinyExe%
        Sleep, 65000

        Click, X(960), Y(540)
        Send, {Enter}

        Sleep, 35000

        select := 450
        Switch HunterSlot
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

        MouseClick, Left, X(1500), Y(select), 1, 20 ; Click character slot 1
        Sleep, 350
        MouseClick, Left, X(1500), Y(select), 1, 20 ; Click failsafe
        Sleep, 300
        MouseClick, Left, X(1500), Y(select), 1, 20 ; Click failsafe
        Sleep, 6000

        freshGame := true
    }
    
    Return 1
}

CheckBounty()
{
    RunWait, %medalProgressScript%

    Switch ErrorLevel
    {
        Case -1:
            bountyState := "None"
        Case 0:
            bountyState := "Held"
        Case 100:
            bountyState := "Complete"
        Default:
            bountyState := "Progress"
    }

    if (bountyState != prevBountyState)
    {
        bountyStateChanged := true      
    }

    ; ToolTip, EL: %ErrorLevel%, 200, 30

    ; MsgBox, , , %bountyState%, %apiWait%
    
    Return 1
}

StopScripts( StopAll:=false )
{
    DetectHiddenWindows, On 
    SetTitleMatchMode, 2
    
    PossibleOthers := list_files( A_ScriptDir )

    For every, script in PossibleOthers
    {
        If (script != "medalDirector.ahk")
        {
            WinClose, %script% - Auto
        }
    }

    Send, {w Up}
    Send, {a Up}
    Send, {s Up}
    Send, {d Up}
    Send, {e Up}
    Send, {ShiftUp}

    Sleep, 1000

    if (StopAll)
    {
        ExitApp
    }

    Return 1
}

FreshStart()
{
    if (bountyStateChanged)
    {
        ; MsgBox, , , %bountyState%, %apiWait%
        ; ToolTip, %bountyState%, 300, 200

        newScript := ""

        Switch bountyState
        {
            Case "None":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalDunk
                newScript := medalDunk
            Case "Held":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalFarm
                newScript := medalFarm
            Case "Progress":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now Nothing
                newScript := medalFarm
            Case "Complete":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalDunk
                newScript := medalDunk
        }

        SwitchTo(newScript, true)

        prevBountyState := bountyState  
        bountyStateChanged := false

        freshGame := false
    }
    
    Return 1
}

Tick()
{
    if (bountyStateChanged)
    {
        ; MsgBox, , , %bountyState%, %apiWait%
        ; ToolTip, %bountyState%, 300, 200

        newScript := ""

        Switch bountyState
        {
            Case "None":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalDunk
                ; newScript := medalDunk
            Case "Held":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalFarm
                ; newScript := medalFarm
                ; SwitchTo(newScript)
                ; handledChange := true
            Case "Progress":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now Nothing
                ; newScript := medalFarm
            Case "Complete":
                ; MsgBox, , , from %prevBountyState% to %bountyState% now medalDunk
                newScript := medalDunk
                SwitchTo(newScript)
                handledChange := true
        }

        prevBountyState := bountyState  
        bountyStateChanged := false
    }
    
    Return 1
}

SwitchTo(scriptName, inOrbit:=false)
{
    scriptState := scriptName
    StopScripts()

    switchToScript  = %dir%\%scriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript% %inOrbit%

    handled := true
    
    Return 1
}

CheckTimeout()
{

    
    Return 1
}

TimeoutOf( state:="None" )
{
    Switch bountyState
    {
        Case "None":
            Return 180000
        Case "Held":
            Return 80000
        Case "Progress":
            Return 780000
        Case "Complete":
            Return 80000
    }    
    
    Return 0
}

list_files(Directory)
{
	files := []
	Loop %Directory%\*.ahk
	{
		files.Push( A_LoopFileName )
	}
	Return files
}
