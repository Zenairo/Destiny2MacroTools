#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
#MaxThreadsPerHotkey, 2

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

F8::
{
    Loop
    {
        ;Move("forward", 180)
         Sleep, 260
        Send, 4 ; hammer throw
        ;Move("forward", 160)
        Sleep, 700

        Send {e down} ; cannon pickup
        Sleep, 450
        Send {e up}

        Sleep, 200
        ;Move("backward", 240)
        TurnRightDegrees(140, 3)
        ; Sleep, 240

        Sleep, 250

        Send, 2 ; cannon drop
        
        Sleep, 150

        TurnLeftDegrees(140, 3)

        Sleep, 200
        
        VerticalLook(74, 3) ; aim at vandal torso
    }
}

F9::
{
    switchToScript  = %A_ScriptDir%\%A_ScriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript%

    Return
}