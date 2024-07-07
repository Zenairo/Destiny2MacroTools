#SingleInstance Force
#NoEnv
; #Warn
SetWorkingDir %A_ScriptDir%

DestinyExe := "C:\Program Files (x86)\Steam\steamapps\common\Destiny 2\destiny2.exe"

PossibleOthers := list_files( A_ScriptDir )

loop
{
    
    Process, Exist, destiny2.exe

    If ErrorLevel != 0
    {
        Sleep, 3000
    }
    Else
    {
        DetectHiddenWindows, On 
        SetTitleMatchMode, 2

        For every, script in PossibleOthers
        {
            If (script != "stopifdestinycrash.ahk")
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

        Return
    }    
}

list_files(Directory)
{
	files := []
	Loop %Directory%\*.ahk
	{
		files.Push( A_LoopFileName )
	}
	return files
}
