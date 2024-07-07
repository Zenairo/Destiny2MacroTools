#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


SetTitleMatchMode, 2
CoordMode, Mouse, Window

tt = Destiny 2 ahk_class Tiger D3D Window
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

F8::
{
    Loop
    {
    Send, ttttt

    Sleep, 3200

    Send, ttttt

    Sleep, 1000

    Send, sssss

    Sleep, 2200
    }
}

F9::
{
    switchToScript  = %A_ScriptDir%\%A_ScriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript%

    Return
}