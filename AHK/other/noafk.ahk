#SingleInstance Force
#MaxThreadsPerHotkey, 2

F8::
{
    Toggle := !Toggle

    if (Toggle)
    {
        ; ToolTip, this is true, -50, -50 
    }
    else
    {
        ; ToolTip, this is false, -50, -50
    }

    If (!Toggle)
        Return

    While (Toggle)
	{
        MouseMove, 0, - A_ScreenHeight, 1, R
        Sleep, 100
        MouseMove, 0 , 800, 1, R
        Sleep, 500
        MouseMove, 0, -800, 5, R
        Sleep 2500
        Send, s
        Send 1
        Sleep 2500
        Send, s
        Send 2
        Sleep 800
        continue	
	}
	Return
}