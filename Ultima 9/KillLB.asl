state("u9")
{
    int mapNumber: 0x58F31C, 0x58;
    int journalPickup: 0xF299A8;
    int karma: 0x58F31C, 0x3C;
    int mana: 0x58F31C, 0x38;
    int UltimaTime: 0xF206DC;
}

start
{
    if(current.journalPickup > old.journalPickup && current.UltimaTime == 22800){
        return true;
    }
}

split
{
    if(/*(current.mapNumber == 9 && old.mapNumber =! 9) || */(current.karma == 0 && old.karma != 0 && current.mana < 100)){
        return true;
    }
    
}