#SingleInstance Force
#MaxThreadsPerHotkey, 2

A := 1 ; Throw Press Durationsd			; NOT USED, DllCall is more accurate
B := 13 ; LeftForward Centering Time	; ^
C := 4500 ; Loop Sleep Time				; ^

Return

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
		; Sunbracer Melee for Infinite Grenades
        Send {c down} ; Melee
        DllCall("Sleep", UInt, 1) ;
        Send {c up} ; Melee
        
		; Walk to center character
        Send {a down} ; Start Walk Left
        Send {w down} ; Move Forward Left
        DllCall("Sleep", UInt, 12) ;
        Send {a up} ; Stop Walk Left
        Send {w up} ; Move Forward Left
		
		if (!Toggle)
		{
			Return
		}
		
		; Wait to end of Sunbracer
        DllCall("Sleep", UInt, 800) ;
		
		; Throw lingering solar grenade with magma to kill next 3 spawns
		Send {t down} ; Grenade
        DllCall("Sleep", UInt, 1) ;
        Send {t up} ; Grenade
		
		; Wait to end of Sunbracer
        DllCall("Sleep", UInt, 3200) ;
		
		; Throw lingering solar grenade with magma to kill next 3 spawns
		Send {t down} ; Grenade
        DllCall("Sleep", UInt, 1) ;
        Send {t up} ; Grenade
		
		; Get back in line with 4513 spawn timing
        DllCall("Sleep", UInt, 1512)
		
		Send {v down} ; Use class ability for melee recharge
        DllCall("Sleep", UInt, 1) ;
        Send {v up} ; Grenade
		
		; Wait for solar grenade to finish burning add packs
        DllCall("Sleep", UInt, 11487) ;	
		
    }
    Return
}

F10::
ExitApp