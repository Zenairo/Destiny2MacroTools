#SingleInstance Force
#MaxThreadsPerHotkey, 2

SetWorkingDir %A_ScriptDir%

SwordSwap = 3          ; 
Jump = %A_Space%             ; 
Super = f ; 

F9::
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
    {
        Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\utility_bindings\bubble_skate.ahk"
        Return
    }

    Sleep, 100

    Send, %SwordSwap% ; held then released 12ms later, 6ms later ; 0ms ; 0ms

    DllCall("Sleep", UInt, 475) ; Sleep ; actually 510 + 12, then 514 + 6ms ; 512ms ; 512ms

    DllCall("mouse_event", "UInt", 0x08) ; Right click down
    ; down for 30ms ; down for 0ms ; 0ms ; 0ms
    DllCall("mouse_event", "UInt", 0x10) ; Right click up

    DllCall("Sleep", UInt, 50) ; Sleep ; 69ms ; 77ms ; 76ms ; 77ms

    Send, %A_Space% ; held 1ms
    ; 14ms so 15ms total
    Send, %Super% ; held 1ms
    
    Return
}


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
    {
        Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\utility_bindings\bubble_skate.ahk"
        Return
    }

    Send, %SwordSwap%

    DllCall("Sleep", UInt, 575) ; Sleep

    DllCall("mouse_event", "UInt", 0x08) ; Right click down
    
    ; DllCall("Sleep", UInt, 1) ; Sleep ; s1 = 30ms actual = success ; 
    Sleep, 15
    
    Send, %Super%
    
    DllCall("mouse_event", "UInt", 0x10) ; Right click up

    Return
}