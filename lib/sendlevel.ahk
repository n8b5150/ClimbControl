#Requires AutoHotkey v2.0
#SingleInstance


SendLevel(btn, level, *)
{

    winid := WinGetID('A') ; Active window to be restored later
    WinWait "SYSTM"
    WinActivate ;"SYSTM" ; Bring SYSTM to front
    ControlSend level, , "SYSTM" ; Send Level to SYSTM
    ;MsgBox(Level)
    
    WinActivate(winid) ; Restore previous window
}