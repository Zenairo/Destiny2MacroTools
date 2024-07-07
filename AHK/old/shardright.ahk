^6::

A := 1000 ; 900 ms
B := 300 ; time between moving from armor piece to armor piece in collections
C := 300 ; time between moving from armor slot to dismantle slot
D := 1500 ; dismantle time
E := 1000 ;

while true
{
	
	; Start macro on main inventory screen
	
	; Assumes keybinds:
		; F1: open inventory
		; F dismantle
		
	; (250,000 / 45 * (777-250))  = 10.5418511
	; 10 * 45 * (777-250) = 237150 glimmer
	
	Loop, 9
	{
		send {p} ; Collections button
		sleep, %A%
		
		MouseClick, Left, X(X(900), Y(340) ; Collection armor button
		sleep, %A%
		Click
		sleep, %A%
		
		MouseClick, Left, X(X(330), Y(820) ; Leveling button
		sleep, %A%
		Click
		sleep, %A%
		
		send {Right} ; 2nd page
		sleep, %A%
		
		MouseClick, Left, X(X(720), Y(880) ; Helmet
		sleep, %B%
		
		; Pull 9 Helmet
		Loop, 9
		{
			Click, Down
			sleep, 3200
			Click, Up
			sleep 50
		}
		
		MouseClick, Left, X(X(820), Y(880) ; Gaunlet
		sleep, %B%
		
		; Pull 9 Gaunlet
		Loop, 9
		{
			Click, Down
			sleep, 3200
			Click, Up
			sleep 50
		}
		
		MouseClick, Left, X(X(920), Y(880) ; Chest
		sleep, %B%
		
		; Pull 9 Chest
		Loop, 9
		{
			Click, Down
			sleep, 3200
			Click, Up
			sleep 50
		}
		
		MouseClick, Left, X(X(1020), Y(880) ; Boots
		sleep, %B%
		
		; Pull 9 Boots
		Loop, 9
		{
			Click, Down
			sleep, 3200
			Click, Up
			sleep 50
		}
		
		MouseClick, Left, X(X(1120), Y(880) ; Class
		sleep, %B%
		
		; Pull 9 Class
		Loop, 9
		{
			Click, Down
			sleep, 3200
			Click, Up
			sleep 50
		}
		
		; return to inventory
		Send {F1}
		sleep, 950
		Send {F1}
		sleep, 950
		
		MouseClick, Left, X(X(1380), Y(250) ; Helmet slot
		sleep, %C%
		MouseClick, Left, X(X(1500), Y(250) ; Helmet dismantle slot
		sleep, %B%
		
		; Dismantle 9 Helmets
		Loop, 9
		{
			Send {f down}
			sleep, %D%
			Send {f up}
			sleep 50
		}
		sleep %E%
		
		MouseClick, Left, X(X(1380), Y(380) ; Gauntlet slot
		sleep, %C%
		MouseClick, Left, X(X(1500), Y(380) ; Gauntlet dismantle slot
		sleep, %B%
		
		; Dismantle 9 Gauntlet
		Loop, 9
		{
			Send {f down}
			sleep, %D%
			Send {f up}
			sleep 50
		}
		sleep %E%
		
		MouseClick, Left, X(X(1380), Y(500) ; Chest slot
		sleep, %C%
		MouseClick, Left, X(X(1500), Y(500) ; Chest dismantle slot
		sleep, %B%
		
		; Dismantle 9 Chest
		Loop, 9
		{
			Send {f down}
			sleep, %D%
			Send {f up}
			sleep 50
		}
		sleep %E%
		
		MouseClick, Left, X(X(1380), Y(640) ; Boots slot
		sleep, %C%
		MouseClick, Left, X(X(1500), Y(640) ; Boots dismantle slot
		sleep, %B%
		
		; Dismantle 9 Boots
		Loop, 9
		{
			Send {f down}
			sleep, %D%
			Send {f up}
			sleep 50
		}
		sleep %E%
		
		MouseClick, Left, X(X(1380), Y(750) ; Class slot
		sleep, %C%
		MouseClick, Left, X(X(1500), Y(750) ; Class dismantle slot
		sleep, %B%
		
		; Dismantle 9 Class
		Loop, 9
		{
			Send {f down}
			sleep, %D%
			Send {f up}
			sleep 50
		}
		sleep %E%
	}
	
	; Fills up on glimmer
	Send {F1}
	sleep, %D%
	MouseClick, Left, X(X(1260), Y(170) ; Glimmer
	sleep, 500
	Loop, 30
	{
		Click
		sleep, 1000
	}
	Send {F1}
	sleep, %A%
	
}

X(n) {
	return n * (A_ScreenWidth / 1920.0)
}

Y(n) {
	return n * (A_ScreenHeight / 1080.0)
}

return

^7::
ExitApp
