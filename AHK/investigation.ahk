#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
;    #Warn

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

SwapThenEnclave()
Sleep, 35000
EnclaveToMission()
LaunchMission()

EnclaveToMission() ; Walks bot to the mission
{
    Move("forward", 5800)
    Move("right", 2800)
}

LaunchMission() ; Launches the mission
{
    Send {e down} ; Interact
    DllCall("Sleep", UInt, 1200) ; Sleep, %A%
    Send {e up} ; Interact
    DllCall("Sleep", UInt, 5000) ; Sleep, %A%
    Sleep, 2500
    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
}

SwapThenEnclave()
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

    MouseClick, Left, X(476), Y(603), 1, 20 ; Open the Enclave
    Sleep, 3500

    MouseClick, Left, X(1620), Y(890), 20 ; Click launch
    Sleep, 1500
}