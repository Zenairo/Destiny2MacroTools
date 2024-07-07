#SingleInstance Force
#MaxThreadsPerHotkey, 2
#Include, %A_ScriptDir%/../DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

; X = White gun
; Note: use less than full clip
; to switch to green ammo more often
clipX = 16          ; White ammo capacity
gunX = 2            ; White ammo gun slot
gunXreloadMS = 1900 ; Fine tune gun X reload speed here

; Y = Green gun
clipY = 3           ; Green ammo capacity
gunY = 1            ; Green ammo gun slot
gunYreloadMS = 2000 ; Fine tune gun Y reload speed here

; Z = Purple gun
clipZ = 5           ; Purple ammo capacity
gunZ = 3            ; Purple ammo gun slot
gunZreloadMS = 2000 ; Fine tune gun Y reload speed here

sens = 2
look = 50

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
        Send, %gunX% ; Use gun X
        VerticalLook( look, sens )
        Loop, %clipX%
        {
            Random, delay, 80, 150
            Click down
            Sleep, delay
            Click up
            Sleep, delay
            If (!Toggle)
                Return
        }
        Send, r ; Reload gun X
        Sleep, gunXreloadMS
        Send, %gunY% ; Use gun Y
        Sleep, (2300 - gunXreloadMS) ; Wait for some enemies
        Loop, %clipY%
        {
            VerticalLook( 25 ) ; Look each shot, because green ammo recoil
            Sleep, 700 ; Firing delay for enemy to appear
            Random, delay, 100, 300
            Click down
            Sleep, delay
            Click up
            Sleep, delay
            If (!Toggle)
                Return
        }
        Send, r ; Reload gun Y
        Sleep, gunYreloadMS
        Send, s
        Send, %gunX% ; Use gun X
        VerticalLook( look, sens )
        Loop, %clipX%
        {
            Random, delay, 80, 150
            Click down
            Sleep, delay
            Click up
            Sleep, delay
            If (!Toggle)
                Return
        }
        Send, r ; Reload gun X
        Sleep, gunXreloadMS
        Send, %gunZ% ; Use gun Z
        Sleep, (2300 - gunXreloadMS) ; Wait for some enemies
        Loop, %clipZ%
        {
            VerticalLook( look, sens ) ; Look each shot, because purple ammo recoil
            Sleep, 700 ; Firing delay for enemy to appear
            Random, delay, 600, 700
            Click down
            Sleep, delay
            Click up
            Sleep, delay
            If (!Toggle)
                Return
        }
        Send, r ; Reload gun Z
        Sleep, gunZreloadMS
        Send, s
        continue
    }
    Return
}