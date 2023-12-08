#Requires AutoHotkey v2.0
#SingleInstance

/*
seconds := 90
time := MinutesSeconds(seconds)
MsgBox(time)
*/

MinutesSeconds(seconds)
{
    minutes := seconds//60
    return minutes ":" Mod(seconds, 60)
}