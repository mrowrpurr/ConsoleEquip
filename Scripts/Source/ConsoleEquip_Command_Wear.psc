scriptName ConsoleEquip_Command_Wear hidden

function Run(Actor npc, string command, string arguments) global
    if command == "wear"
        string outfitName = StringUtil.Split(arguments, " ")[0]
        ConsoleEquip_OutfitManager.WearOutfit(npc, outfitName)
    endIf
endFunction