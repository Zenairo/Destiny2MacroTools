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
    
    Send, {w Down}
    Sleep, 100
    Send, {w Up}
    Sleep, 100
    Send, {s Down}
    Sleep, 100
    Send, {s Up}
    Sleep, 100
    Send, {a Down}
    Sleep, 100
    Send, {a Up}
    Sleep, 100
    Send, {d Down}
    Sleep, 100
    Send, {d Up}
    Sleep, 100


    Sleep, 30000
    
    Continue
}
Return
}
ExitApp