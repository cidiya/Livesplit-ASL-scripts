state("beltion")
{
    byte mapNumber: 0x32CCEE;
    byte loadScreen: 0x32E3B4;
}

start
{
    if(current.mapNumber == old.mapNumber + 225){
        return true;
    }
}

split
{
    //Old Ordos 1 (Ordos -> Square)
    if((current.mapNumber == 48  || current.mapNumber == 189) && old.mapNumber == 225){
        return true;
    }

    //Pinnarin 1 & Pinnarin 4 (Docks -> Zinor)
    if(current.mapNumber == 239 && old.mapNumber == 76){
        return true;
    }

    //Zinor 1 & Zinor 2 (3rd Светоч) (Zinor -> Docks)
    if(current.mapNumber == 76 && old.mapNumber == 239){
        return true;
    }

    //Pinnarin 2 Meeting the Gnorr (Gnorr -> Catacombs)
    if(current.mapNumber == 64 && old.mapNumber == 164){
        return true;
    }

    //Catacombs (1st Светоч) (Catacombs 64 -> Gnorr 164)
    if(current.mapNumber == 164 && old.mapNumber == 64){
        return true;
    }

    //Pinnarin 3 (Armory -> Port Crimson)
    if(current.mapNumber == 82 && old.mapNumber == 142){
        return true;
    }

    //Port Crimson (Port Crimson -> Gaerayan)
    if(current.mapNumber == 148 && old.mapNumber == 82){
        return true;
    }

    //Gaerayan Mountains 1 (Gaerayan -> Radagarn)
    if(current.mapNumber == 181 && old.mapNumber == 148){
        return true;
    }

    //Radagarn 1 (Radagarn Palace -> Caves)
    if(current.mapNumber == 13 && old.mapNumber == 146){
        return true;
    }

    //Daur Caves (2nd Светоч) (Caves -> Radagarn Palace)
    if(current.mapNumber == 160 && old.mapNumber == 13){
        return true;
    }

    //Pinnarin 5 (Sonn -> Ordos)
    if(current.mapNumber == 225 && old.mapNumber == 7){
        return true;
    }

    //Old Ordos 2 (Ordos -> Gnorr)
    if(current.mapNumber == 164 && old.mapNumber == 225){
        return true;
    }

    //Pinnarin 6 (Sonn -> Itt)
    if(current.mapNumber == 233 && old.mapNumber == 7){
        return true;
    }

    //Itt (4th Светоч) (Itt -> Gnorr)
    if(current.mapNumber == 164 && old.mapNumber == 233){
        return true;
    }

    //Gaerayan Mountains 2 (Gaerayan 148 -> Radagarn 181)
    if(current.mapNumber == 181 && old.mapNumber == 148){
        return true;
    }

    //Radagarn 2 (Radagarn Palace -> Gnorr)
    if(current.mapNumber == 164 && old.mapNumber == 146){
        return true;
    }
}

isLoading
{
   return current.loadScreen == 1;
}