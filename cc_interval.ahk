#Requires AutoHotkey v2.0
#SingleInstance

IntMode(*)
{
    if  WinExist("Random Gradient Control")
        {
            Reload
        }

    IntGui := Gui("-SysMenu", "Gradient Interval Control")
    AddRowBtn := IntGui.Add("Button", "Default w75 xm+35", "Add Interval")
    AddRowBtn.OnEvent("Click", AddRow)
    StartBtn := IntGui.Add("Button", "yp wp x+10", "Start")
    StartBtn.OnEvent("Click", StartWO)
    ExitBtn := IntGui.Add("Button", "yp wp x+10", "Exit")
    ExitBtn.OnEvent("Click", ExApp)

    ExApp(*)
    {
        Reload
    }
    
    /* Preset Gui
    IniPath := "presets.ini"
    PresetNames := StrSplit(IniRead(IniPath), "`n")
    ; preset dropdown - list section names from INI
    IntGui.AddText("", "Preset: ")
    IntGui.AddDropDownList("vPresetName", PresetNames)
    ; load button - load selected section name, adding appropriate number of rows

    ; save button - delete existing section and write new section of same name with confirmation

    ; new button
    NewPreset := Input Box("Enter a name for your preset:", "New Preset Name", "w300").value
    ;   check to see if preset name exists and ask to overwrite
    ;   overwrite deletes existing section and adds new section (see save)

    ; delete button - delete selected section with confirmation


    */

    IntGui.AddText("xm+10 w110 Center", "Duration (sec)")
    IntGui.AddText("yp w100 Center", "Level (0-9)")
    
    IntGui.AddText("xm+10 w60", "Interval 1: ")
    IntGui.AddEdit("yp w50 Right", )
    IntGui.AddUpDown("Range0-9999 vInt1")
    
    IntGui.AddText("yp w25 x+20", "Level ")
    IntGui.AddEdit("yp w35 Right", )
    IntGui.AddUpDown("Range0-9 vLev1")
    
    IntGui.Show
    
    AddRow(*)
    {
        if !IsSet(x)
            static x := 2 ; --x needs to be one more than the number of updowns/2--
            
        IntGui.AddText("xm+10 w60", "Interval " x ": ")
        IntGui.AddEdit("yp w50 Right", )
        IntGui.AddUpDown("Range0-9999 vInt" x)
    
        IntGui.AddText("yp w25 x+20", "Level ")
        IntGui.AddEdit("yp w35 Right", )
        IntGui.AddUpDown("Range0-9 vLev" x)
        
        IntGui.Show("Autosize")
        x += 1
    }
    
    StartWO(*)
    {
        IntLevObj := IntGui.Submit()
        Count := ObjOwnPropCount(IntLevObj)
        WOGui := AddRowWO(Count)
        Loop Count/2
        {
            i := A_Index
            WOGui['Int' i].Value := IntLevObj.Int%i%
            WOGui['Lev' i].Value := IntLevObj.Lev%i%
        }
        WOExBtn := WOGui.AddButton("w80 xm+30", "Exit")
        WOExBtn.OnEvent("Click", ExApp)
        WOGui.Show()
        Workout(Count, IntLevObj, WOGui)
    }
        
    Workout(Count, IntLevObj, WOGui)
    {
        Idx := 0
        IdxMax := Count/2
        
        while Idx < IdxMax
        {
            Idx := ++Idx 
            
            winid := WinGetID('A') ; Active window to be restored later
            WinWait "SYSTM"
            WinActivate ;"SYSTM" ; Bring SYSTM to front
            ControlSend IntLevObj.Lev%Idx%, , "SYSTM" ; Send Level to SYSTM
            ;MsgBox(IntLevObj.Lev%Idx%)
    
            WinActivate(winid) ; Restore previous window
    
            ; Send interval time to countdown timer
            TimeLeft := IntLevObj.Int%Idx%
            Timer(TimeLeft, Idx)
    
            Timer(x, y) ; countdown timer 
            {
                SetTimer countdown, 1000
                    countdown()
                    {
                        if x = 4
                            {
                                SoundPlay "timer.wav", 0
                            }
                        if x > 0
                            {
                                ; decrement gui timer display
                                x -= 1
                                WOGui['Int' y].Value := x
                            }
                    }
            }
    
            Sleep IntLevObj.Int%Idx% * 1000 ; Interval length determined by Sleep time
        }
        MsgBox("Workout Ended")
        ExApp
    }
    
    AddRowWO(Count)
    {
        WOGui := Gui("-SysMenu", "Gradient Interval Control")
        Loop Count/2
        {
            i := A_Index
            WOGui.AddText("xm+10 w60 Right", "Interval " i ": ")
            WOGui.AddText("yp w25 Right vInt" i, )
            WOGui.AddText("yp w35 x+20 Right", "Level : ")
            WOGui.AddText("yp w35 Right  vLev" i, )
        }
    
        return WOGui
    }
}



