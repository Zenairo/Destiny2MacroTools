#SingleInstance Force
#NoEnv
;    #Warn

SetWorkingDir %A_ScriptDir%

dir    := A_ScriptDir
global script
script = %dir%\check-for-bounty.py

bounty := -2


MonitorBounty()


MonitorBounty()
{
    ; Loop
    ; {
        RunWait, python "%script%"

        bounty := ErrorLevel

        ToolTip, EL: %ErrorLevel%, 200, 300

        Sleep, 10000
    ; }
}
