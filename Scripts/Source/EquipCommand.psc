Scriptname EquipCommand

; TODO - Update to support NPCs

Function Run(string[] arguments, Actor player) global
    if arguments.Length != 2 || (arguments[0] != "save" && arguments[0] != "wear")
        MiscUtil.PrintConsole("Usage: equip [save|wear] [outfit name]")
    else
        string command = arguments[0]
        string outfitName = arguments[1]
        if command == "save"
            SaveOutfit(outfitName, player)
        elseif command == "wear"
            WearOutfit(outfitName, player)
        endIf
    endIf
EndFunction

Function SaveOutfit(string outfitName, Actor player) global
    Form[] equippedItems = PO3_SKSEFunctions.AddAllEquippedItemsToArray(player)
    StorageUtil.FormListClear(player, "EquipCommand_Outfit:" + outfitName)
    int index = 0
    while index < equippedItems.Length
        StorageUtil.FormListAdd(player, "EquipCommand_Outfit:" + outfitName, equippedItems[index])
        index += 1
    endWhile
    MiscUtil.PrintConsole("Saved outfit \"" + outfitName + "\"")
EndFunction

Function WearOutfit(string outfitName, Actor player) global
    Form[] itemsToEquip = StorageUtil.FormListToArray(player, "EquipCommand_Outfit:" + outfitName)
    if itemsToEquip.Length > 0
        player.UnequipAll()
        int index = 0
        while index < itemsToEquip.Length
            player.EquipItem(itemsToEquip[index])
            index += 1
        endWhile
        MiscUtil.PrintConsole("Switched to outfit \"" + outfitName + "\"")
    else
        MiscUtil.PrintConsole("equip: outfit not found \"" + outfitName + "\"")
    endIf
EndFunction