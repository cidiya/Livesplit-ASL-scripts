state("Eternal Edge +")
{
    int loadScreen: "UnityPlayer.dll", 0x019BF088, 0x60, 0x1C8, 0x514;
}

isLoading
{
    return current.loadScreen != 0;
}