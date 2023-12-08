#Requires AutoHotkey v2.0
#SingleInstance

Timer(WOChildGui, seconds) ; countdown timer
{
    SetTimer countdown, 1000
        countdown()
        {
            if seconds = 4
                {
                    SoundPlay "timer.wav", 0
                }
            if seconds > 0
                {
                    ; decrement gui timer display
                    seconds -= 1
                    WOChildGui['IntervalTime'].Value := seconds ; 
                }
        }
}