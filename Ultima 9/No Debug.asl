state("u9")
{
    int mapNumber: 0x58F31C, 0x58;
    int journalPickup: 0xF299A8;
    int karma: 0x58F31C, 0x3C;
    int mana: 0x58F31C, 0x38;
    int getItem: 0x531E4A;
    int leggings: 0x437EF8;
    int UltimaTime: 0xF206DC;
    int dex: 0x58F31C, 0x2C;
}

start
{
    if(current.journalPickup > old.journalPickup && current.UltimaTime == 22800){
        return true;
    }
}

split
{
    if((current.dex == old.dex + 1) || (current.leggings == 10 && old.leggings == 0) || (current.leggings == 7 && old.leggings != 7) || (current.getItem > old.getItem && current.mapNumber != 90 && current.mapNumber != 57)){
        return true;
    }
    
}