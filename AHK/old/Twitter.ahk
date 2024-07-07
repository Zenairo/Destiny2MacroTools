#SingleInstance Force
#MaxThreadsPerHotkey, 2

A := 1 ; Throw Press Durationsd
B := 13 ; LeftForward Centering Time
C := 4500 ; Loop Sleep Time

Return

F8::
{
    Toggle := !Toggle

    if (Toggle)
    {
        ToolTip, this is true, -50, -50 
    }
    else
    {
        ToolTip, this is false, -50, -50
    }
    
    If (!Toggle)
        Return

    While (Toggle)
    {
		
        Send {t down} ; Grenadetaw
        DllCall("Sleep", UInt, 1) ; Sleep, %A%
        Send {t up} ; Grenade
        
        Send {a down} ; Start Walk Left
        Send {w down} ; Move Forward Left

        DllCall("Sleep", UInt, 12) ; Sleep, %B%
        
        Send {a up} ; Stop Walk Left
        Send {w up} ; Move Forward Left
        
        DllCall("Sleep", UInt, 4500) ; Sleep, %C%
    }
    Return
}

F10::
ExitApp