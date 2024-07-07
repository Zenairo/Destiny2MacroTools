#SingleInstance Force
#MaxThreadsPerHotkey, 2

SetWorkingDir %A_ScriptDir%

IzzySwap = 1
HeavySwap = 3
Jump = %A_Space%
Super = f

F8::
{
    Click
    Sleep, 20
    Send, {r down}
    Sleep, 1030
    Send, {r up}
    Sleep, 300
    Send, %HeavySwap%
    Sleep, 780
    Click
    Sleep, 90
    Send, %IzzySwap%
}

F9::
{
    switchToScript  = %A_ScriptDir%\%A_ScriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript%

    Return
}