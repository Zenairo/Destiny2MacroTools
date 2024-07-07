#SingleInstance Force
#NoEnv
#Include, %A_ScriptDir%/DestinyMacros.ahk
#MaxThreadsPerHotkey, 2

SetWorkingDir %A_ScriptDir%

RunWait, "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\AHK\stopothers.ahk" %A_ScriptName%

PreciseSleep(s)
{
    DllCall("QueryPerformanceFrequency", "Int64*", QPF)
    DllCall("QueryPerformanceCounter", "Int64*", QPCB)
    While (((QPCA - QPCB) / QPF * 1000) < s)
        DllCall("QueryPerformanceCounter", "Int64*", QPCA)
    return ((QPCA - QPCB) / QPF * 1000) 
}

CLR_LoadLibrary(AssemblyName, AppDomain=0){
    if !AppDomain
        AppDomain := CLR_GetDefaultDomain()
    e := ComObjError(0)
    Loop 1 {
        if assembly := AppDomain.Load_2(AssemblyName)
            break
        static null := ComObject(13,0)
        args := ComObjArray(0xC, 1),  args[0] := AssemblyName
        typeofAssembly := AppDomain.GetType().Assembly.GetType()
        if assembly := typeofAssembly.InvokeMember_3("LoadWithPartialName", 0x158, null, null, args)
            break
        if assembly := typeofAssembly.InvokeMember_3("LoadFrom", 0x158, null, null, args)
            break
    }
    ComObjError(e)
    return assembly
}

CLR_CreateObject(Assembly, TypeName, Args*){
    if !(argCount := Args.MaxIndex())
        return Assembly.CreateInstance_2(TypeName, true)
    
    vargs := ComObjArray(0xC, argCount)
    Loop % argCount
        vargs[A_Index-1] := Args[A_Index]
    
    static Array_Empty := ComObjArray(0xC,0), null := ComObject(13,0)
    
    return Assembly.CreateInstance_3(TypeName, true, 0, null, vargs, null, Array_Empty)
}

CLR_CompileC#(Code, References="", AppDomain=0, FileName="", CompilerOptions=""){
    return CLR_CompileAssembly(Code, References, "System", "Microsoft.CSharp.CSharpCodeProvider", AppDomain, FileName, CompilerOptions)
}

CLR_CompileVB(Code, References="", AppDomain=0, FileName="", CompilerOptions=""){
    return CLR_CompileAssembly(Code, References, "System", "Microsoft.VisualBasic.VBCodeProvider", AppDomain, FileName, CompilerOptions)
}

CLR_StartDomain(ByRef AppDomain, BaseDirectory=""){
    static null := ComObject(13,0)
    args := ComObjArray(0xC, 5), args[0] := "", args[2] := BaseDirectory, args[4] := ComObject(0xB,false)
    AppDomain := CLR_GetDefaultDomain().GetType().InvokeMember_3("CreateDomain", 0x158, null, null, args)
    return A_LastError >= 0
}

CLR_StopDomain(ByRef AppDomain){	
    DllCall("SetLastError", "uint", hr := DllCall(NumGet(NumGet(0+RtHst:=CLR_Start())+20*A_PtrSize), "ptr", RtHst, "ptr", ComObjValue(AppDomain))), AppDomain := ""
    return hr >= 0
}

CLR_Start(Version="") {
    static RtHst := 0
    if RtHst
        return RtHst
    EnvGet SystemRoot, SystemRoot
    if Version =
        Loop % SystemRoot "\Microsoft.NET\Framework" (A_PtrSize=8?"64":"") "\*", 2
            if (FileExist(A_LoopFileFullPath "\mscorlib.dll") && A_LoopFileName > Version)
                Version := A_LoopFileName
    if DllCall("mscoree\CorBindToRuntimeEx", "wstr", Version, "ptr", 0, "uint", 0
    , "ptr", CLR_GUID(CLSID_CorRuntimeHost, "{CB2F6723-AB3A-11D2-9C40-00C04FA30A3E}")
    , "ptr", CLR_GUID(IID_ICorRuntimeHost,  "{CB2F6722-AB3A-11D2-9C40-00C04FA30A3E}")
    , "ptr*", RtHst) >= 0
        DllCall(NumGet(NumGet(RtHst+0)+10*A_PtrSize), "ptr", RtHst) ; Start
    return RtHst
}

CLR_GetDefaultDomain(){
    static defaultDomain := 0
    if !defaultDomain
    {
        if DllCall(NumGet(NumGet(0+RtHst:=CLR_Start())+13*A_PtrSize), "ptr", RtHst, "ptr*", p:=0) >= 0
            defaultDomain := ComObject(p), ObjRelease(p)
    }
    return defaultDomain
}

CLR_CompileAssembly(Code, References, ProviderAssembly, ProviderType, AppDomain=0, FileName="", CompilerOptions=""){
    if !AppDomain
        AppDomain := CLR_GetDefaultDomain()
    
    if !(asmProvider := CLR_LoadLibrary(ProviderAssembly, AppDomain))
    || !(codeProvider := asmProvider.CreateInstance(ProviderType))
    || !(codeCompiler := codeProvider.CreateCompiler())
        return 0

    if !(asmSystem := (ProviderAssembly="System") ? asmProvider : CLR_LoadLibrary("System", AppDomain))
        return 0
    
    StringSplit, Refs, References, |, %A_Space%%A_Tab%
    aRefs := ComObjArray(8, Refs0)
    Loop % Refs0
        aRefs[A_Index-1] := Refs%A_Index%
    
    prms := CLR_CreateObject(asmSystem, "System.CodeDom.Compiler.CompilerParameters", aRefs)
    , prms.OutputAssembly          := FileName
    , prms.GenerateInMemory        := FileName=""
    , prms.GenerateExecutable      := SubStr(FileName,-3)=".exe"
    , prms.CompilerOptions         := CompilerOptions
    , prms.IncludeDebugInformation := true
    
    compilerRes := codeCompiler.CompileAssemblyFromSource(prms, Code)
    
    if error_count := (errors := compilerRes.Errors).Count
    {
        error_text := ""
        Loop % error_count
            error_text .= ((e := errors.Item[A_Index-1]).IsWarning ? "Warning " : "Error ") . e.ErrorNumber " on line " e.Line ": " e.ErrorText "`n`n"
        MsgBox, 16, Compilation Failed, %error_text%
        return 0
    }
    return compilerRes[FileName="" ? "CompiledAssembly" : "PathToAssembly"]
}

CLR_GUID(ByRef GUID, sGUID){
    VarSetCapacity(GUID, 16, 0)
    return DllCall("ole32\CLSIDFromString", "wstr", sGUID, "ptr", &GUID) >= 0 ? &GUID : ""
}

;; ViGEm Bus Setup
; ==========================================================
;                     AHK-ViGEm-Bus
;          https://github.com/evilC/AHK-ViGEm-Bus
; ==========================================================
;
;   Author:     evilC
;   EDITED by Antra, this is not the original script - do not reuse expecting that to be the case.
;
class ViGEmWrapper {
    static asm := 0
    static client := 0

    Init(){
        if (this.client == 0){
            this.asm := CLR_LoadLibrary(A_Temp "\vigemwrapper.dll")
        }
    }
    
    
    CreateInstance(cls){
        try {
            return this.asm.CreateInstance(cls)
        } catch Error {
            MsgBox,0x40,Exotic Class Farm Script, You do not have ViGEm installed! Press OK to continue with downloading and installing!
            UrlDownloadToFile, https://github.com/Antraless/tabbed-out-fishing/raw/main/ViGEmBus_1.21.442_x64_x86_arm64.exe, ViGEmBus_1.21.442_x64_x86_arm64.exe
            MsgBox,3,Exotic Class Farm Script,The ViGEm installer has been downloaded to the same place as this script.`n`nPress Yes to run the installer as admin!  Press No if you need help!
            IfMsgBox, Yes
            {
                Run *Runas explorer.exe %A_ScriptDir%\ViGEmBus_1.21.442_x64_x86_arm64.exe
                exitapp
            }
            IfMsgBox, No
            {
                Run, https://discord.gg/KGyjysA5WY
                exitapp
            }
            else
            {
                Run, explorer.exe %A_ScriptDir%
                exitapp
            }
        }
    }
}

; Base class for ViGEm "Targets" (Controller types - eg xb360 / ds4) to inherit from
class ViGEmTarget {
    target := 0
    helperClass := ""
    controllerClass := ""

    __New(){
        ViGEmWrapper.Init()
        this.Instance := ViGEmWrapper.CreateInstance(this.helperClass)
        
        if (this.Instance.OkCheck() != "OK"){
            msgbox,4,Exotic Class Farm Script, The .dll failed to load!`n`nPlease visit the #support channel in our discord for help resolving this.`n`nPress yes to launch our discord server for help!
            IfMsgBox, Yes
            {
                Run, https://discord.gg/KGyjysA5WY
                exitapp
            }
            else
            {
                exitapp
            }		
            }
    }
    
    SendReport(){
        this.Instance.SendReport()
    }
    
    SubscribeFeedback(callback){
        this.Instance.SubscribeFeedback(callback)
    }
}

; Xb360
class ViGEmXb360 extends ViGEmTarget {
    helperClass := "ViGEmWrapper.Xb360"
    __New(){
        static buttons := {A: 4096, B: 8192, X: 16384, Y: 32768, LB: 256, RB: 512, LS: 64, RS: 128, Back: 32, Start: 16, Xbox: 1024}
        static axes := {LX: 2, LY: 3, RX: 4, RY: 5, LT: 0, RT: 1}
        
        this.Buttons := {}
        for name, id in buttons {
            this.Buttons[name] := new this._ButtonHelper(this, id)
        }
        
        this.Axes := {}
        for name, id in axes {
            this.Axes[name] := new this._AxisHelper(this, id)
        }
        
        this.Dpad := new this._DpadHelper(this)
        
        base.__New()
    }
    
    class _ButtonHelper {
        __New(parent, id){
            this._Parent := parent
            this._Id := id
        }
        
        SetState(state){
            this._Parent.Instance.SetButtonState(this._Id, state)
            this._Parent.Instance.SendReport()
            return this._Parent
        }
    }
    
    class _AxisHelper {
        __New(parent, id){
            this._Parent := parent
            this._id := id
        }
        
        SetState(state){
            this._Parent.Instance.SetAxisState(this._Id, this.ConvertAxis(state))
            this._Parent.Instance.SendReport()
        }
        
        ConvertAxis(state){
            value := round((state * 655.36) - 32768)
            if (value == 32768)
                return 32767
            return value
        }
    }
    
    class _DpadHelper {
        _DpadStates := {1:0, 8:0, 2:0, 4:0} ; Up, Right, Down, Left
        __New(parent){
            this._Parent := parent
        }
        
        SetState(state){
            static dpadDirections := { None: {1:0, 8:0, 2:0, 4:0}
                , Up: {1:1, 8:0, 2:0, 4:0}
                , UpRight: {1:1, 8:1, 2:0, 4:0}
                , Right: {1:0, 8:1, 2:0, 4:0}
                , DownRight: {1:0, 8:1, 2:1, 4:0}
                , Down: {1:0, 8:0, 2:1, 4:0}
                , DownLeft: {1:0, 8:0, 2:1, 4:1}
                , Left: {1:0, 8:0, 2:0, 4:1}
                , UpLeft: {1:1, 8:0, 2:0, 4:1}}
            newStates := dpadDirections[state]
            for id, newState in newStates {
                oldState := this._DpadStates[id]
                if (oldState != newState){
                    this._DpadStates[id] := newState
                    this._Parent.Instance.SetButtonState(id, newState)
                }
                this._Parent.SendReport()
            }
        }
    }
}

360Controller := new ViGEmXb360()

F8::
{
    

    Loop
    {
        ; Move("forward", 180)
        360Controller.Axes.LY.SetState(100)
        360Controller.Buttons.LS.SetState(true)
		PreciseSleep(50)
        360Controller.Buttons.LS.SetState(false)
		PreciseSleep(200)
        360Controller.Axes.LY.SetState(50)

        ; Send, 4
        360Controller.Buttons.RB.SetState(true)
		; PreciseSleep(50)
        
        360Controller.Axes.RY.SetState(80)


        ; Move("forward", 160)
        360Controller.Axes.LY.SetState(100)
        360Controller.Buttons.LS.SetState(true)
		PreciseSleep(50)


        360Controller.Axes.RY.SetState(50)

        360Controller.Buttons.RB.SetState(false)
        360Controller.Buttons.LS.SetState(false)
		PreciseSleep(110)
        360Controller.Axes.LY.SetState(50)

        ; Sleep, 400
        PreciseSleep(350)

        ; Move("backward", 265)
        360Controller.Axes.LY.SetState(0)
        360Controller.Buttons.LS.SetState(true)
		PreciseSleep(50)
        360Controller.Buttons.LS.SetState(false)
		; PreciseSleep(275) too far back
        PreciseSleep(200)
        360Controller.Axes.LY.SetState(50)

        ; Send {e down} ; Cannon pickup
        360Controller.Buttons.X.SetState(true)

        ; Sleep, 400
        PreciseSleep(400)

        ; Send {e up}
        360Controller.Buttons.X.SetState(false)

        ; Move("backward", 265)
        360Controller.Axes.LY.SetState(0)
        360Controller.Buttons.LS.SetState(true)
		PreciseSleep(10)
        360Controller.Buttons.LS.SetState(false)
		PreciseSleep(255)
        360Controller.Axes.LY.SetState(50)

        ; Sleep, 200
        PreciseSleep(200)

        ; Send, 2 
        360Controller.Buttons.Y.SetState(true)
		PreciseSleep(50)
        360Controller.Buttons.Y.SetState(false)
        
        ; Sleep, 700
        PreciseSleep(650)
    }
}

F9::
{
    switchToScript  = %A_ScriptDir%\%A_ScriptName%
    Run, "C:\Program Files\AutoHotkey\AutoHotkey.exe" %switchToScript%

    Return
}
