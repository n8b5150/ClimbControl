#Requires AutoHotkey v2.0
#SingleInstance

IniPath := "presets.ini"

/*
    Read ini

Put section names into drop down

Selecting drop down fills interval and level fields

Save Preset to save new preset

Update Preset updates selected preset

Delete Preset deletes preset

*/

PreGui := Gui("-SysMenu", "Gradient Interval Control")
AddRowBtn := PreGui.Add("Button", "Default w75 xm+35", "Add Interval")
AddRowBtn.OnEvent("Click", AddRow)
RldBtn := PreGui.Add("Button", "yp wp x+10", "Reload")
RldBtn.OnEvent("Click", Rld)
ExitBtn := PreGui.Add("Button", "yp wp x+10", "Exit")
ExitBtn.OnEvent("Click", ExApp)


PreGui.AddEdit("xm+10 w150 vPreName", "Name")
WrIniBtn := PreGui.Add("Button", "yp w75 x+10", "New Preset")
WrIniBtn.OnEvent("Click", WrIni)

Rld(*)
{
    Reload
}

ExApp(*)
{
    ExitApp
}

PresetNames := StrSplit(IniRead(IniPath), "`n")

PreGui.AddText("xm+10", "Preset: ")
PreGui.AddDropDownList(" yp w150 Choose1 vPresetName", PresetNames)
LdIniBtn := PreGui.Add("Button", "yp w75 x+10", "Load")
LdIniBtn.OnEvent("Click", LdIni)

LdIni(*)
{
    MsgBox(PreGui['PresetName'].Text)
}


PreGui.AddText("xm+10 w110 Center", "Duration (sec)")
PreGui.AddText("yp w100 Center", "Level (0-9)")

PreGui.AddText("xm+10 w60", "Interval 1: ")
PreGui.AddEdit("yp w50 Right", )
PreGui.AddUpDown("Range0-9999 vInt1")

PreGui.AddText("yp w25 x+20", "Level ")
PreGui.AddEdit("yp w35 Right", )
PreGui.AddUpDown("Range0-9 vLev1")

PreGui.Show

AddRow(*)
{
    if !IsSet(x)
        static x := 2
        
    PreGui.AddText("xm+10 w60", "Interval " x ": ")
    PreGui.AddEdit("yp w50 Right", )
    PreGui.AddUpDown("Range0-9999 vInt" x)

    PreGui.AddText("yp w25 x+20", "Level ")
    PreGui.AddEdit("yp w35 Right", )
    PreGui.AddUpDown("Range0-9 vLev" x)
    
    PreGui.Show("Autosize")
    x += 1
}

WrIni(*) 
{

    DefObj := PreGui.Submit()
    Count := ObjOwnPropCount(DefObj)

    SectionNames := StrSplit(IniRead(IniPath), "`n") ; array of section names
    ;MsgBox(SectionNames[1]) ; display first section name

    ;Section := IniRead(IniPath, SectionNames)

/*    DefObj := Object()

    Loop 10
        {
            i := A_Index
            ;DefObj := DefObj.DefineProp("Int" i, {Value: 10})
            ;DefObj := DefObj.DefineProp("Lev" i, {Value: 0})
            DefObj.Int%i% := 10
            DefObj.Lev%i% := 0
        }
*/
    Loop Count/2-1
        {
            i := A_Index
            IniWrite DefObj.Int%i%, IniPath, DefObj.PreName, "Int" i
            IniWrite DefObj.Lev%i%, IniPath, DefObj.PreName, "Lev" i
        }

    ;IniDelete IniPath, "AddSection5", "Key5" ; delete AddSection5, Key5
}
