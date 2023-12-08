#Requires AutoHotkey v2.0
#SingleInstance
#Include "%A_ScriptDir%"
;#Include "%A_ScriptDir%\lib"
#Include "cc_interval.ahk"
#Include "cc_random.ahk"

ClmbCtrl := Gui()
;Button to select random interval mode
RndmBtn := ClmbCtrl.AddButton("xm+30 w100 vRndm", "Random Mode")
RndmBtn.OnEvent("Click", RndmMode)

;Button to select interval mode
IntBtn := ClmbCtrl.AddButton("yp w100 vInt", "Interval Mode")
IntBtn.OnEvent("Click", IntMode)

;Buttons to manually select Level
ClmbCtrl.AddText("xm w260 Center", "Manual Level Selection")

ManBtn0 := ClmbCtrl.AddButton("xm vMan0", "0")
ManBtn1 := ClmbCtrl.AddButton("yp vMan1", "1")
ManBtn2 := ClmbCtrl.AddButton("yp vMan2", "2")
ManBtn3 := ClmbCtrl.AddButton("yp vMan3", "3")
ManBtn4 := ClmbCtrl.AddButton("yp vMan4", "4")
ManBtn5 := ClmbCtrl.AddButton("yp vMan5", "5")
ManBtn6 := ClmbCtrl.AddButton("yp vMan6", "6")
ManBtn7 := ClmbCtrl.AddButton("yp vMan7", "7")
ManBtn8 := ClmbCtrl.AddButton("yp vMan8", "8")
ManBtn9 := ClmbCtrl.AddButton("yp vMan9", "9")

Loop 10
    {
        i := A_Index-1
        ManBtn%i%.OnEvent("Click", ManLev)
    }

/* Old manual button creation
ManBtn0 := ClmbCtrl.AddButton("xm vMan0", "0")
ManBtn0.OnEvent("Click", ManLev)
ManBtn1 := ClmbCtrl.AddButton("yp vMan1", "1")
ManBtn1.OnEvent("Click", ManLev)
ManBtn2 := ClmbCtrl.AddButton("yp vMan2", "2")
ManBtn2.OnEvent("Click", ManLev)
ManBtn3 := ClmbCtrl.AddButton("yp vMan3", "3")
ManBtn3.OnEvent("Click", ManLev)
ManBtn4 := ClmbCtrl.AddButton("yp vMan4", "4")
ManBtn4.OnEvent("Click", ManLev)
ManBtn5 := ClmbCtrl.AddButton("yp vMan5", "5")
ManBtn5.OnEvent("Click", ManLev)
ManBtn6 := ClmbCtrl.AddButton("yp vMan6", "6")
ManBtn6.OnEvent("Click", ManLev)
ManBtn7 := ClmbCtrl.AddButton("yp vMan7", "7")
ManBtn7.OnEvent("Click", ManLev)
ManBtn8 := ClmbCtrl.AddButton("yp vMan8", "8")
ManBtn8.OnEvent("Click", ManLev)
ManBtn9 := ClmbCtrl.AddButton("yp vMan9", "9")
ManBtn9.OnEvent("Click", ManLev)
*/

ClmbCtrl.Show

ManLev(n, *)
{
    winid := WinGetID('A') ; Active window to be restored later
    
    WinWait "SYSTM"
    WinActivate ;"SYSTM" ; Bring SYSTM to front
    ControlSend SubStr(n.Name, 4, 1), , "SYSTM" ; Send Level to SYSTM using control name

    WinActivate(winid) ; Restore previous window
}