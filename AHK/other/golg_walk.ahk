#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

NavigateGolg()
{
    ; First hall
    ;Move("forward", 7000)
    ;Move("forward", 4000, True, 1)
    
    TurnRightDegrees(20, sens)
    Move("forward", 7000)
    Move("forward", 4000, True, 1)
    Sleep, 1000

    TurnRightDegrees(90, sens)

    ;Move("right", 450)
    ;
    
    ; Second hall
    Move("forward", 13000)
    
    Sleep, 1000

    TurnLeftDegrees(90, sens)
    ;

    ; Third hall
    Move("forward", 13000, True, 2)
    
    Sleep, 1000
    
    TurnLeftDegrees(90, sens)
    ;

    ; Fourth hall
    Move("forward", 11000)
    
    Sleep, 1000
    
    TurnRightDegrees(90, sens)
    ;

    ; Fifth hall
    Move("forward", 11000)
    
    Sleep, 1000
    
    TurnRightDegrees(90, sens)

    ; Sixth hall
    Move("forward", 11000)

    Sleep, 1000
    
    ;
}
