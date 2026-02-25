state("CSR", "Das Bild") 
{
    string6 level       : 0x1B06BE;
    bool isLoading      : 0x001AA3F0, 0xB0C, 0x18;
    //int lap             : 0x001B0088, 0x2650;
    byte finishLine     : 0x001AA3F8, 0xC, 0x96E8;
    //string10 countdown  : 0x001AA3F8, 0x30, 0x16C8, 0x4434;
    int isRacing        : 0x001AA444, 0x18, 0x10;
}

init
{
    switch (modules.First().ModuleMemorySize)
    {
        case 2043904:
        version = "Das Bild";
        break;

        case 2052096:
        version = "GamersGate (Not yet supported)";
        break;
        
        default:
        MessageBox.Show("Memory Size: " + modules.First().ModuleMemorySize.ToString(), "Unknown Version Detected!");
        version = "Unknown";
        break;
    }
}

startup
{
    settings.Add("Championsheep", true, "Championsheep");
    settings.Add("Transhumance", false, "Trancehumance");
    settings.Add("IL Mode", false, "Individual Level");
    //settings.Add("Lap Split", false, "Split Every Lap");

    vars.first7Done = 0;
    vars.PrevPhase = null;
    vars.WasJustInMenu = true;
}

update
{
    // Reset first7Done if the timer is stopped
    if (timer.CurrentPhase != vars.PrevPhase)
    {
        if (timer.CurrentPhase == TimerPhase.NotRunning)
        {
            vars.first7Done = 0;
        }

        vars.PrevPhase = timer.CurrentPhase;
    }

    if (current.level == "Level8" && old.level == "Level7"){
        vars.first7Done = 1;
    }

    if (current.level == "Level1" && old.level == "Level0"){
        vars.WasJustInMenu = true;
    }
}

split
{
    if (current.level == "Level0" || old.level == "Level0") return false;
    else if (old.level != current.level) return true;

    if (settings["Championsheep"] && current.level == "Level8" && current.finishLine == 2 && old.finishLine == 1)
    return true;

    if (settings["Transhumance"] && vars.first7Done == 1 && current.level == "Level7" && current.finishLine == 2 && old.finishLine == 1)
    return true;

    if (settings["IL Mode"] && current.finishLine == 2 && old.finishLine == 1)
    return true;

    /*if (settings["Lap Split"] && old.lap != 0 && current.lap > old.lap)
    return true;*/
}

isLoading
{
    return current.isLoading;
}

start
{
    if (current.isRacing == 1 && old.isRacing == 0){
    vars.WasJustInMenu = false;
    return true;
    }
}

reset
{
    if (settings["IL Mode"] && current.isRacing == 0 && old.isRacing != 0)
        return true;
    
    if ((settings["Championsheep"] || settings["Transhumance"]) && vars.WasJustInMenu == true && current.isRacing == 0 && old.isRacing != 0)
        return true;
}