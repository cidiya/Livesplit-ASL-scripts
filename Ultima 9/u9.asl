state("u9")
{
    int mapNumber: 0x58F31C, 0x58;
    int journalPickup: 0xF299A8;
    int getItem: 0x531E4A;
    int UltimaTime: 0xF206DC;
    int MaxHP: 0x58F31C, 0x36;
    byte cutscene: 0x44F8D8;
}

reset
{
    if (current.mapNumber == 14 && old.mapNumber != 14)
    return true;
}

start
{
    if(current.journalPickup > old.journalPickup && current.UltimaTime == 22800){
        return true;
    }
}

split
{
    if(((current.mapNumber != 0) && (current.UltimaTime > 0)) && ((current.MaxHP - old.MaxHP) > 9) || (current.getItem > old.getItem && current.mapNumber != 90 && current.mapNumber != 57)){   
        return true;
    }

    if (current.cutscene == 1 && old.cutscene == 0)
    return true;   
}