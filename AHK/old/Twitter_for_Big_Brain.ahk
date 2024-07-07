#SingleInstance Force
#MaxThreadsPerHotkey, 2

A := 1 ; Throw Press Durationsd
B := 13 ; LeftForward Centering Time
C := 4500 ; Loop Sleep Time

Return

; Get radiant first.
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
		; Click down
		; DllCall("Sleep", UInt, 3400)
		; Click up
        
        Send {a down} ; Start Walk Left
        Send {w down} ; Move Forward Left
        DllCall("Sleep", UInt, 12)
        Send {a up} ; Stop Walk Left
        Send {w up} ; Move Forward Left
		
		Send {v down} ; Use class ability for melee recharge
        DllCall("Sleep", UInt, 1) ;
        Send {v up} ; Grenade
        
        DllCall("Sleep", UInt, 1600)
		
		Send {ctrl down} ; Stand up [HOLD CROUCH KEYBIND]
        DllCall("Sleep", UInt, 1) ;
        Send {ctrl up}
		
		Send {r down} ; Reload
        DllCall("Sleep", UInt, 1) ;
        Send {r up} ;
        
        ; DllCall("Sleep", UInt, 900)
		DllCall("Sleep", UInt, 900)
    }
    Return
}

F10::
ExitApp