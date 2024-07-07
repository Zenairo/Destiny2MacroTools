#SingleInstance Force
#MaxThreadsPerHotkey, 2
#NoEnv
;	#Warn

F8:: ; To start
{
    Toggle := !Toggle
    
    If (!Toggle)
        Return

    While (Toggle)
    {
        RepeatThis()
    }
}

F10::
ExitApp

RepeatThis()
{
    Send, {s Down}
    Sleep, 137
    Send, {s Up}
    Sleep, 7843
}
