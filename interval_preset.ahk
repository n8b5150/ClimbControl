#Requires AutoHotkey v2.0
#SingleInstance

IniPath := "presets.ini"

PreGui := Gui(, "Preset Test Window")
DropChoice := "Choose1" 

InitGui(*)
{
    AddRowBtn := PreGui.Add("Button", "Default w75 xm+35", "Add Interval")
    AddRowBtn.OnEvent("Click", AddRow)
    RldBtn := PreGui.Add("Button", "yp wp x+10", "Reload")
    RldBtn.OnEvent("Click", Rld)
    ExitBtn := PreGui.Add("Button", "yp wp x+10", "Exit")
    ExitBtn.OnEvent("Click", ExApp)
    
    ;Add new preset
    PreGui.AddEdit("xm+10 w150 vPreName", "Name")
    WrIniBtn := PreGui.Add("Button", "yp w75 x+10", "New")
    WrIniBtn.OnEvent("Click", WrIni)

    ;Delete preset
    DelIniBtn := PreGui.Add("Button", "yp w75 x+10", "Delete")
    DelIniBtn.OnEvent("Click", DelIni)
    
    ;Preset DropDown, load button
    PresetNames := StrSplit(IniRead(IniPath), "`n")
    PreGui.AddText("xm+10", "Preset: ")
    PreGui.AddDropDownList(" yp w150 vPresetName " DropChoice, PresetNames)
    LdPreBtn := PreGui.Add("Button", "yp w75 x+10", "Load")
    LdPreBtn.OnEvent("Click", LdPre)
    UpPreBtn := PreGui.Add("Button", "yp w75 x+10", "Update")
    UpPreBtn.OnEvent("Click", UpdatePre)
    
    ;Interval/Level Header
    PreGui.AddText("xm+10 w110 Center", "Duration (sec)")
    PreGui.AddText("yp w100 Center", "Level (0-9)")
}

InitGui

;-----
;Initial Interval Field
PreGui.AddText("xm+10 w60 vIntText1", "Interval 1: ")
PreGui.AddEdit("yp w50 Right", )
PreGui.AddUpDown("Range0-9999 vInt1")

;Initial Level Field
PreGui.AddText("yp w25 x+20", "Level ")
PreGui.AddEdit("yp w35 Right", )
PreGui.AddUpDown("Range0-9 vLev1")
;-----

;Initial Gui Show
PreGui.Show

Rld(*)
{
    Reload
}

ExApp(*)
{
    ExitApp
}

LdPre(*)
{   
    ; Get preset name
    global
    PresetNm := PreGui['PresetName'].Text
    DropChoice := "Choose" PreGui['PresetName'].Value

    ; Get values and create object
    PresetVals := StrSplit(IniRead(IniPath, PresetNm), "`n")
    PresetObj := {}
    for vals in PresetVals
        {
            i := A_Index
            PresetVals[i] := StrSplit(PresetVals[i], "=")
            PresetObj := PresetObj.DefineProp(PresetVals[i][1], {Value: PresetVals[i][2]})
        }

    ; Create rows and fill with values
    PreGui.Destroy ;Destroy existing Gui
    PreGui := Gui(, "Preset Test Window") ;Create new Gui
    InitGui ;Add default Gui Controls
    Loop ObjOwnPropCount(PresetObj)/2 ; Create Interval and Level Rows and fill with values
        {
            i := A_Index

            PreGui.AddText("xm+10 w60 vIntText" i, "Interval " i ": ")
            PreGui.AddEdit("yp w50 Right", )
            PreGui.AddUpDown("Range0-9999 vInt" i, PresetObj.Int%i%)
        
            PreGui.AddText("yp w25 x+20", "Level ")
            PreGui.AddEdit("yp w35 Right", )
            PreGui.AddUpDown("Range0-9 vLev" i, PresetObj.Lev%i%)
            
        }
        
    PreGui.Show("Autosize") 
}

AddRow(*)
{
    if !IsSet(x)
        static x := 1
    
    Try
        {
            PreGui.AddText("xm+10 w60 vIntText" x, "Interval " x ": ")
            PreGui.AddEdit("yp w50 Right", )
            PreGui.AddUpDown("Range0-9999 vInt" x)
        
            PreGui.AddText("yp w25 x+20", "Level ")
            PreGui.AddEdit("yp w35 Right", )
            PreGui.AddUpDown("Range0-9 vLev" x)
            
            PreGui.Show("Autosize")
            x += 1
        }
    Catch
        {
            x +=1
            AddRow
        }
}

WrIni(*) 
{
    DefObj := PreGui.Submit()
    Count := ObjOwnPropCount(DefObj)
    PreNm := StrLower(DefObj.PreName)
    SectionNmStr := StrLower(IniRead(IniPath))
    ;SectionNames := StrSplit(SectionNmStr, "`n") ; array of section names

    ; check if DefObj.PreName exists in Ini and prompt to overwrite
    PreExists := InStr(SectionNmStr "`n", PreNm "`n")
    if PreExists
        {
            Response := MsgBox("That preset name already exists.`nDo you want to overwrite? ", "Naming Conflict", "YesNo")
            if Response = "No"
                {
                    PreGui.Show
                }
                ; delete section on confirmation and proceed
                else
                {
                  IniDelete IniPath, PreNm  
                  WrPreset
                }
        }
    else
        {
            WrPreset
        }
    

/*    
    TestObj := Object()

    Loop 10
        {
            i := A_Index
            ;TestObj := TestObj.DefineProp("Int" i, {Value: 10})
            ;TestObj := TestObj.DefineProp("Lev" i, {Value: 0})
            TestObj.Int%i% := 10
            TestObj.Lev%i% := 0
        }
*/

    WrPreset(*)
    {    
        Loop Count/2-1
            {
                i := A_Index
                IniWrite DefObj.Int%i%, IniPath, PreNm, "Int" i
                IniWrite DefObj.Lev%i%, IniPath, PreNm, "Lev" i
            }
    }

    PreGui.Show
}

DelIni(*)
{
    DefObj := PreGui.Submit()
    PreNm := StrLower(DefObj.PreName)
    if PreNm="default"
        {
            MsgBox("This preset cannot be deleted.")
            PreGui.Show
        }
    else
        {
            Response := MsgBox("Do you want to delete this Preset?", "Delete Preset?", "YesNo")
            if Response = "No"
                {
                    PreGui.Show
                }
            else
                {
                  IniDelete IniPath, PreNm  
                }
            PreGui.Show
        }
}

UpdatePre(*)
{
    global
    Response := MsgBox("Do you want to update this Preset?", "Update Preset?", "YesNo")
    if Response = "No"
        {
            PreGui.Show
        }
    else
        {
        DefObj := PreGui.Submit()
            Count := ObjOwnPropCount(DefObj)
            IniDelete IniPath, PresetNm
            Loop Count/2-1
                {
                    i := A_Index
                    IniWrite DefObj.Int%i%, IniPath, PresetNm, "Int" i
                    IniWrite DefObj.Lev%i%, IniPath, PresetNm, "Lev" i
                }  
        }
    PreGui.Show
}
