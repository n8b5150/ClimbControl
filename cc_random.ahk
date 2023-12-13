#Requires AutoHotkey v2.0
#SingleInstance


RndmMode(*)
{
    if  WinExist("Gradient Interval Control")
        {
            Reload
        }

    ; Gui displays start button, countdown timer; and level setting
    RndmGui := Gui("-SysMenu", "Random Gradient Control")
    RndmGui.Add("Text", "Right w100", "Time Remaining: ")
    RndmGui.Add("Text", "Right w100", "Level Setting: ")
    RndmGui.Add("Text", "vIntervalTime w20 Right ym", 0)
    RndmGui.Add("Text", "vLevelSetting w20 Right", 0)
    RndmGui.Add("Text", "Left ym", " seconds")
    RndmGui.Add("Text", , " ")
    StartBtn := RndmGui.Add("Button", "Default w80 xm+10", "Start")
    StartBtn.OnEvent("Click", StartApp)
    ExitBtn := RndmGui.Add("Button", " wp yp x+10", "Exit")
    ExitBtn.OnEvent("Click", ExApp)
    RndmGui.Show("w300")

    ExApp(*)
    {
        Reload
    }
    
    StartApp(*)
    {
        SetTimer Gradient ; Run Gradient over and over again until script is terminated
    }

    Gradient()
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
    
        switch { ; Determine interval duration based on gradient
            case LevelWeight < 30: Interval := Random(30,300) 
            case LevelWeight < 50: Interval := Random(30,250)
            case LevelWeight < 65: Interval := Random(30,200)
            case LevelWeight < 75: Interval := Random(20,150)
            case LevelWeight < 83: Interval := Random(20,125)
            case LevelWeight < 90: Interval := Random(15,100)
            case LevelWeight < 95: Interval := Random(10,75)
            default: Interval := Random(5,60)
        }
        ;MsgBox(LevelWeight " : " Level " : " Interval)
    }

/* Old Gradient function
    Gradient()
    {
        LevelWeight := Random(0,100)
    
        if (LevelWeight < 19) ; Weighted random selection of gradient
            {
                Level := 0
            }
            else if (LevelWeight < 36)
            {
                Level := 1
            }
            else if (LevelWeight < 51)
            {
                Level := 2
            }
            else if (LevelWeight < 64)
            {
                Level := 3
            }
            else if (LevelWeight < 75)
            {
                Level := 4
            }
            else if (LevelWeight < 84)
            {
                Level := 5
            }
            else if (LevelWeight < 91)
            {
                Level := 6
            }
            else if (LevelWeight < 95)
            {
                Level := 7
            }
            else if (LevelWeight < 98)
            {
                Level := 8
            }
            else
            {
                Level := 9
            }
    
        if (LevelWeight < 30) ; Determine interval length based on gradient
            {
                Interval := Random(30,300) 
            }
            else if (LevelWeight < 50)
            {
                Interval := Random(30,250)
            }
            else if (LevelWeight < 65)
            {
                Interval := Random(30,200)
            }
            else if (LevelWeight < 75)
            {
                Interval := Random(20,150)
            }
            else if (LevelWeight < 83)
            {
                Interval := Random(20,125)
            }
            else if (LevelWeight < 90)
            {
                Interval := Random(15,100)
            }
            else if (LevelWeight < 95)
            {
                Interval := Random(10,75)
            }
            else
            {
                Interval := Random(5,60)
            }
*/
            
        winid := WinGetID('A') ; Active window to be restored later
        WinWait "SYSTM"
        WinActivate ;"SYSTM" ; Bring SYSTM to front
        ControlSend Level, , "SYSTM" ; Send Level to SYSTM
        ;MsgBox(Level)
    
        WinActivate(winid) ; Restore previous window
    
        ; Update Gui
        RndmGui['IntervalTime'].Value := Interval
        RndmGui['LevelSetting'].Value := Level
        
        ; Send interval time to countdown timer
        TimeLeft := Interval
        Timer(TimeLeft)
    
        Sleep Interval * 1000 ; Interval length determined by Sleep time
    }
    
    Timer(x) ; countdown timer
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
                        RndmGui['IntervalTime'].Value := x
                    }
            }
    }
}