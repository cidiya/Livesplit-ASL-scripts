state("Rebel Transmute")
{
    int mapNumber: 0x1C7EE98;
    float posX: 0x01CB5400, 0x0;
    float posY: 0x01CB5400, 0x4;
    byte cutscene: 0x01C7EB38, 0x108, 0x78;
}

startup 
{
    vars.splitStatus = new Dictionary<string, bool>
    {
        { "gun", false },
        { "dash", false },
        { "bomb", false },
        { "bounce", false },
        { "climb", false },
        { "swim", false },

        { "quirk", false },
        { "mines", false },
        { "basin", false },
    };

    vars.PrevPhase = null;
    vars.lastSplit = 0;
    vars.minesCount = 0;
}

update
{
    // Check if the timer phase has changed
    if (timer.CurrentPhase != vars.PrevPhase)
    {
        if (timer.CurrentPhase == TimerPhase.NotRunning)
        {
            // Create a list of keys to avoid modifying the dictionary during iteration
            var keys = new List<string>(vars.splitStatus.Keys);

            // Reset all splits to false
            foreach (var key in keys)
            {
                vars.splitStatus[key] = false;
            }
            vars.minesCount = 0;
            vars.basinCount = 0;
        }

        // Update the previous phase
        vars.PrevPhase = timer.CurrentPhase;
    }

    if (current.mapNumber == 292 && current.cutscene == 1 && old.cutscene == 0)
    {
        vars.minesCount = vars.minesCount + 1;
    }

    if (current.mapNumber == 321 && current.cutscene == 1 && old.cutscene == 0)
    {
        vars.basinCount = vars.basinCount + 1;
    }
}

start
{
if(current.mapNumber == 2 && old.mapNumber == 1)
{
    return true;
}
}

split
{

    if (current.mapNumber == 29 && current.posX == 200 && current.posY == 177 && vars.splitStatus["gun"] == false)
    {
        vars.splitStatus["gun"] = true;
        return true;
    }

    if (current.mapNumber == 71 && current.posX == 632 && current.posY == 257 && vars.splitStatus["dash"] == false)
    {
        vars.splitStatus["dash"] = true;
        return true;
    }

    if (current.mapNumber == 214 && current.posX == 168 && current.posY == 129 && vars.splitStatus["bomb"] == false)
    {
        vars.splitStatus["bomb"] = true;
        return true;
    }

    if (current.mapNumber == 110 && current.posX == 616 && current.posY == 177 && vars.splitStatus["bounce"] == false)
    {
        vars.splitStatus["bounce"] = true;
        return true;
    }

    if (current.mapNumber == 267 && current.posX == 200 && current.posY == 625 && vars.splitStatus["climb"] == false)
    {
        vars.splitStatus["climb"] = true;
        return true;
    }

    if (current.mapNumber == 185 && current.posX == 136 && current.posY == 161 && vars.splitStatus["swim"] == false)
    {
        vars.splitStatus["swim"] = true;
        return true;
    }

    if (current.mapNumber == 398 && current.cutscene == 0 && old.cutscene == 1 && vars.splitStatus["quirk"] == false)
    {
        vars.splitStatus["quirk"] = true;
        return true;
    }

    if (current.mapNumber == 292 && vars.minesCount == 4 && current.cutscene == 0 && old.cutscene == 1 && vars.splitStatus["mines"] == false)
    {
        vars.splitStatus["mines"] = true;
        return true;
    }

    if (current.mapNumber == 321 && vars.basinCount == 4 && current.cutscene == 0 && old.cutscene == 1 && vars.splitStatus["basin"] == false)
    {
        vars.splitStatus["basin"] = true;
        return true;
    }

    if (current.mapNumber == 329 && old.mapNumber == 330)
    {
        return true;
    }

    if (current.mapNumber == 230 && old.mapNumber == 469)
    {
        return true;
    }

    if (current.mapNumber == 3 && old.mapNumber == 332)
    {
        return true;
    }
}