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

^+!x:: ; ctrl shift alt x 
{

    SectionNames := StrSplit(IniRead(IniPath), "`n") ; array of section names
    ;MsgBox(SectionNames[1]) ; display first section name

    ;Section := IniRead(IniPath, SectionNames)

    DefObj := Object()

    Loop 10
        {
            i := A_Index
            ;DefObj := DefObj.DefineProp("Int" i, {Value: 10})
            ;DefObj := DefObj.DefineProp("Lev" i, {Value: 0})
            DefObj.Int%i% := 10
            DefObj.Lev%i% := 0
        }

    Loop 10
        {
            i := A_Index
            IniWrite DefObj.Int%i%, IniPath, "Default", "Int" i
            IniWrite DefObj.Lev%i%, IniPath, "Default", "Lev" i
        }

    ;IniDelete IniPath, "AddSection5", "Key5" ; delete AddSection5, Key5
}
