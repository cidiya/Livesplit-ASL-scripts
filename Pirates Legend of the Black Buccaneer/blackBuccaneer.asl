state("Black Buccaneer")
{
    byte amulet: 0x002A2148, 0x94, 0x10;
    byte planks: 0x002CE4F0, 0x18, 0x73C;
    byte sail: 0x002CE4F0, 0x18, 0x6F4;
    byte rudder: 0x002CE4F0, 0x18, 0x6D0;
    byte compass: 0x002CE4F0, 0x18, 0x6AC;
    byte supplies: 0x002CE4F0, 0x18, 0x718;
    byte seal1: 0x002CE4F0, 0x18, 0x640;
    byte seal2: 0x002CE4F0, 0x18, 0x664;
    byte seal3: 0x002CE4F0, 0x18, 0x688;
    int questScreen: 0x29D808;
    int mapNumber: 0x2A6FD0;
    byte shipQuest: 0x002CE4F0, 0x18, 0x58C;
    byte cutscene: 0x28686C;
    byte difficultySelect: 0x0029750C, 0x90;
    byte vanillaQuest: 0x002A20A4, 0x79C;
    float positionX: 0x00299600, 0x288;
    float positionY: 0x00299600, 0x29C;
    float positionZ: 0x00280584, 0xD4, 0x58;
    float sessionTime: 0x2A52CC;
    int seconds: 0x002B303C, 0x2C;
    //float positionX: 0x002A6FF4, 0xC8;
    //float positionY: 0x002A6FF4, 0xDC;
}

startup 
{
    settings.Add("Amulet", true);
    settings.Add("ship", true, "Ship Parts");
    settings.Add("sail", true, "Sail", "ship");
    settings.Add("planks", true, "Planks", "ship");
    settings.Add("rudder", true, "Rudder", "ship");
    settings.Add("compass", true, "Compass", "ship");
    settings.Add("supplies", true, "Supplies", "ship");

    settings.Add("seals", true, "Seals");
    settings.Add("seal1", true, "First Seal", "seals");
    settings.Add("seal2", true, "Second Seal", "seals");
    settings.Add("seal3", true, "Third Seal", "seals");
    settings.Add("Leave Island", true);

    settings.Add("Vanilla Quest", false);
    settings.Add("vanilla1", false, "Vanilla Cutscene (Jungle Ruins)", "Vanilla Quest");
    settings.Add("vanilla2", false, "Talk to Vanilla", "Vanilla Quest");
    settings.Add("vanilla3", false, "Spannish Fort", "Vanilla Quest");
    settings.Add("vanilla4", false, "Father's Tomb", "Vanilla Quest");
    settings.Add("Changing Levels", false);

        // Define DebugOutput as a function for logging
    vars.DebugOutput = (Action<string>)((message) => print("[Debug] " + message));

    vars.splitStatus = new Dictionary<string, bool>
    {
        { "amulet", false },
        { "sail", false },
        { "planks", false },
        { "rudder", false },
        { "compass", false },
        { "supplies", false },
        { "seal1", false },
        { "seal2", false },
        { "seal3", false },
        { "vanilla1", false },
        { "vanilla2", false },
        { "vanilla3", false },
        { "vanilla4", false },
    };

    // print a message to confirm initialization
    vars.PrevPhase = null;
    vars.lastSplit = 0;
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
            // Log the reset action
            vars.DebugOutput("Reset all splits to false due to timer reset");
            vars.noBeachSplit = 0;
        }

        // Update the previous phase
        vars.PrevPhase = timer.CurrentPhase;
    }
}

start
{
    // Reset splitStatus for a new run when the timer is started
    if (current.difficultySelect == 0 && old.difficultySelect == 1)
    {
        return true;
    }
}

split
{
    // Ensure we're in the game before checking for splits
    if (current.questScreen == 6936592 || current.questScreen == 6937372 || current.questScreen == 6937384) 
    {
        vars.DebugOutput("Not in-game, skipping split checks.");
        return false;
    }

    // Ship parts and seals
    if (settings["Amulet"] && current.amulet > old.amulet && vars.splitStatus["amulet"] == false)
    {
        vars.lastSplit = Environment.TickCount;
        vars.splitStatus["amulet"] = true;
        return true;
    }

    if (settings["sail"] && current.sail > old.sail && current.sail != 2 && vars.splitStatus["sail"] == false)
    {
        vars.splitStatus["sail"] = true;
        return true;
    }

    if (settings["planks"] && current.planks > old.planks && current.planks != 2 && vars.splitStatus["planks"] == false)
    {
        vars.splitStatus["planks"] = true;
        return true;
    }

    if (settings["rudder"] && current.rudder > old.rudder && current.rudder != 2 && vars.splitStatus["rudder"] == false)
    {
        vars.splitStatus["rudder"] = true;
        return true;
    }

    if (settings["compass"] && current.compass > old.compass && current.compass != 2 && vars.splitStatus["compass"] == false)
    {
        vars.splitStatus["compass"] = true;
        return true;
    }

    if (settings["supplies"] && current.supplies > old.supplies && vars.splitStatus["supplies"] == false)
    {
        vars.splitStatus["supplies"] = true;
        return true;
    }

    if (settings["seal1"] && current.seal1 > old.seal1 && vars.splitStatus["seal1"] == false)
    {
        vars.splitStatus["seal1"] = true;
        return true;
    }

    if (settings["seal2"] && current.seal2 > old.seal2 && vars.splitStatus["seal2"] == false)
    {
        vars.splitStatus["seal2"] = true;
        return true;
    }

    if (settings["seal3"] && current.seal3 > old.seal3 && vars.splitStatus["seal3"] == false)
    {
        vars.splitStatus["seal3"] = true;
        return true;
    }

    // Final split
    if (settings["Leave Island"] && current.shipQuest == 7 && current.cutscene == 1 && old.cutscene == 0)
    {
        return true;
    }

     // Vanilla Quest Splits
    if (settings["vanilla1"] && current.vanillaQuest == 1 && old.vanillaQuest != 1 && vars.splitStatus["vanilla1"] == false)
    {
        vars.splitStatus["vanilla1"] = true;
        return true;
    }

    if (settings["vanilla2"] && current.vanillaQuest == 2 && old.vanillaQuest != 2 && vars.splitStatus["vanilla2"] == false)
    {
        vars.splitStatus["vanilla2"] = true;
        return true;
    }

    if (settings["vanilla3"] && current.vanillaQuest == 3 && old.vanillaQuest != 3 && vars.splitStatus["vanilla3"] == false)
    {
        vars.splitStatus["vanilla3"] = true;
        return true;
    }

    if (settings["vanilla4"] && current.vanillaQuest == 4 && old.vanillaQuest != 4 && vars.splitStatus["vanilla4"] == false)
    {
        vars.splitStatus["vanilla4"] = true;
        return true;
    }


    // Split on changing levels
    
    // Splitting on level change with cooldown to avoid multisplits + exception for level transition that doesn't change mapNumber
    if (settings["Changing Levels"] && Environment.TickCount - vars.lastSplit > 2500 && (current.mapNumber != old.mapNumber || current.positionZ > 755 && old.positionZ < -1080) && vars.noBeachSplit == 1)
    {
				vars.lastSplit = Environment.TickCount;
				return true;
	}

    // Prevents splits at the start of the game and after relaunching the game in the two maps where we do that
    if ((current.mapNumber == 31 || current.mapNumber == 13)) 
    {
        vars.noBeachSplit = 1;
    }
}

exit
{
    vars.noBeachSplit = 0;
}