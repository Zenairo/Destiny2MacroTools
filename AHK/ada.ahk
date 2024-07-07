#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

SwapThenAnnex()
Sleep, 10000 ; Delay for orbit to moon loading screen
SensitivityOne() ; Reduce sens while waiting (takes 10s)
Sleep, 20000 ; Finish 40s delayAnnexToAda()
AnnexToAda()
BuyMods()

AnnexToAda()
{
    TurnLeftDegrees(18)
    Move("forward", 600)
    Move("right", 1900)
    Move("forward", 7300)
    TurnLeftDegrees(90)
    Move("forward", 5300)
    Move("left", 900, False)
}

BuyMods()
{
    Send {e down} ; Interact
    DllCall("Sleep", UInt, 1200) ; Sleep, %A%
    Send {e up} ; Interact
    DllCall("Sleep", UInt, 5000) ; Sleep, %A%
    
    MouseClick, Left, X(1169), Y(540), 1, 25  ; Buy Mod #1
    DllCall("Sleep", UInt, 2000) ; Sleep, %A%
    
    MouseClick, Left, X(1269), Y(540), 1, 25  ; Buy Mod #2
    DllCall("Sleep", UInt, 2000) ; Sleep, %A%
    
    MouseClick, Left, X(1369), Y(540), 1, 25  ; Buy Mod #3
    DllCall("Sleep", UInt, 2000) ; Sleep, %A%
    
    MouseClick, Left, X(1469), Y(540), 1, 25  ; Buy Mod #4
    DllCall("Sleep", UInt, 2000) ; Sleep, %A%

}

SwapThenAnnex()
{
    Send, {Esc} ; Open game options menu
    MouseClick, Left, X(650), Y(600), 1, 25  ; Click [Change character]
    Sleep, 1000

    Send, {Enter} ; Accept character change
    Sleep, 7000

    MouseClick, Left, X(1500), Y(550), 1, 20 ; Click character slot 2
    Sleep, 5000

    Send, M
    Sleep, 1500

    MouseClick, Left, X(960), Y(540), 1, 20 ; Open the tower
    MouseMove, X(1), Y(1080), 10 ; Adjust the map
    Sleep, 3500

    MouseClick, Left, X(815), Y(258), 20 ; Click Annex landing point on the tower
    Sleep, 1500

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 1500
}
