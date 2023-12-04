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
    MsgBox(SectionNames[1]) ; display first section name

    ;Section := IniRead(IniPath, SectionNames)

    IniWrite "Key5=Value5", IniPath, "AddSection5"
    IniWrite "Key5=Value3", IniPath, "AddSection5"
    IniWrite "Key5a=Value5a", IniPath, "AddSection5"

    IniDelete IniPath, "AddSection5", "Key5" ; delete AddSection5, Key5
}
