#Requires AutoHotkey v2.0
#SingleInstance

Gradient(*)
{
    LevelWeight := Random(0,100)

    switch { ; Weighted random selection of gradient
        case LevelWeight < 19: Level := 0
        case LevelWeight < 36: Level := 1
        case LevelWeight < 51: Level := 2
        case LevelWeight < 64: Level := 3
        case LevelWeight < 75: Level := 4
        case LevelWeight < 84: Level := 5
        case LevelWeight < 91: Level := 6
        case LevelWeight < 95: Level := 7
        case LevelWeight < 98: Level := 8
        default: Level := 9
    } 

    switch { ; Determine interval length based on gradient
        case LevelWeight < 30:Interval := Random(30,300) 
        case LevelWeight < 50: Interval := Random(30,250)
        case LevelWeight < 65: Interval := Random(30,200)
        case LevelWeight < 75: Interval := Random(20,150)
        case LevelWeight < 83: Interval := Random(20,125)
        case LevelWeight < 90: Interval := Random(15,100)
        case LevelWeight < 95: Interval := Random(10,75)
        default: Interval := Random(5,60)
    }
    MsgBox(LevelWeight " : " Level " : " Interval)
}

Gradient
        