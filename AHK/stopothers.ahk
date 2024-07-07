#SingleInstance Force
#NoEnv
; #Warn
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On 
SetTitleMatchMode, 2

caller = %1%

; This script is called from another in the same directory, with the argument of the caller
; to stop running all other scripts in same directory. This is an improved version of stopall.
; It sends key up events to fix potential problems with interrupting other scripts.

; PossibleOthers := ["HelloWorld", "start", "gotoexp", "startexp", "stopexp", "deep", "orbit", "join", "enter", "select1", "select2"]
; B := 350
; ext := .ahk

; ToolTip, stopothers is running, 200, 300

PossibleOthers := list_files( A_ScriptDir )

; ToolTip, %PossibleOthers% %1%, %B%, 300
; Sleep, 5000

For every, script in PossibleOthers
{
    ; script := script ext
    If (script != caller And script != "stopothers.ahk")
    {
        ; ToolTip, %script% %1%, %B%, 300
        ; B += 50
        ; Sleep, 5000
		WinClose, %script% - Auto
    }
}

Send, {w Up}
Send, {a Up}
Send, {s Up}
Send, {d Up}
Send, {e Up}
Send, {ShiftUp}
; MouseClick, right
; MouseClick, left

Sleep, 1000

list_files(Directory)
{
	files := []
	Loop %Directory%\*.ahk
	{
		files.Push( A_LoopFileName )
	}
	return files
}
