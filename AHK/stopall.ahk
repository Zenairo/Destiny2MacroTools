#SingleInstance Force
#NoEnv
; #Warn
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On 
SetTitleMatchMode, 2

; This script is called from another in the same directory, with the argument of the caller
; to stop running all other scripts in the array below. This is an older version of stopothers.
; It sends key up events to fix potential problems with interrupting other scripts.

AllOthers := ["HelloWorld", "start", "gotoexp", "startexp", "stopexp", "deep", "orbit", "stopothers", "join", "enter", "select1", "select2"]
; B := 350
ext := .ahk

For every, script in AllOthers
{
    script := script ext
	WinClose, %script% - Auto
}

Send, {w Up}
Send, {a Up}
Send, {s Up}
Send, {d Up}
Send, {e Up}
Send, {ShiftUp}
MouseClick, right
MouseClick, left

Sleep, 1000