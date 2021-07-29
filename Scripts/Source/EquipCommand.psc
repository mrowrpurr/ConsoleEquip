Scriptname EquipCommand

; "me" as default alias
; pass alias as the main object (IDENTIFIER) for the Player -vs- the NPC

Function Run(string[] arguments, Actor playerOrNpc) global
    string command = arguments[1]
    string argument = arguments[2]

    ; Check if the provided command is actually the name of an NPC alias
    Actor npcFromAlias = GetActorFromAliasName(command)
    if npcFromAlias
        playerOrNpc = npcFromAlias
        command = arguments[2]
        argument = arguments[3]
    endIf

    MiscUtil.PrintConsole("command: " + command + " argument: " + argument + " playerOrNpc: " + playerOrNpc)

    if command == "save"
        SaveOutfit(argument, playerOrNpc)
    elseif command == "wear"
        WearOutfit(argument, playerOrNpc)
    elseif command == "add"
        RegisterNpcAlias(argument, playerOrNpc)
    elseif command == "remove"
        UnregisterNpcAlias(argument, playerOrNpc)
    elseif command == "aliases"
        ListNpcAliases()
    elseif command == "outfits"
        ListOutfits()
    endIf
EndFunction

Function PrintUsage() global
    MiscUtil.PrintConsole("Usage: equip [save|wear] [outfit name]")
EndFunction

; #todo if the actor is the Game Player then print a message and do not register
; #todo if the actor is already registered, do not register again and show an error message in the console
Function RegisterNpcAlias(string npcAlias, Actor npc) global
    if npc == Game.GetPlayer()
        MiscUtil.PrintConsole("Cannot register alias for game player")
    elseif StorageUtil.StringListHas(None, NpcAliasesKeyName(), npcAlias)
        MiscUtil.PrintConsole("Alias already exists: " + npcAlias + " (" + GetActorNameFromNpcAlias(npcAlias) + ")")
    else
        ; Track all npc alias named in a string list
        StorageUtil.StringListAdd(None, NpcAliasesKeyName(), npcAlias)
        ; Store a reference to the form ID for this npc
        StorageUtil.SetFormValue(None, NpcAliasKeyName(npcAlias), npc)
        MiscUtil.PrintConsole("Added alias: " + npcAlias + " (" + GetActorNameFromNpcAlias(npcAlias) + ")")
    endIf
EndFunction

; Check NULL npc from empty string? #todo Also same with RegisterNpcAlias
Function UnregisterNpcAlias(string npcAlias, Actor npc) global
    ; TODO - Unregister their outfits!!!! All of them. Which means we need to track a list of outfits.
    if StorageUtil.HasFormValue(None, NpcAliasKeyName(npcAlias))
        StorageUtil.UnsetFormValue(None, NpcAliasKeyName(npcAlias))
        StorageUtil.StringListRemove(None, NpcAliasesKeyName(), npcAlias)
    else
        MiscUtil.PrintConsole("No alias registered with name: " + npcAlias)
    endIf
EndFunction

Function SaveOutfit(string outfitName, Actor playerOrNpc) global
    Form[] equippedItems = PO3_SKSEFunctions.AddAllEquippedItemsToArray(playerOrNpc)
                                            ; Move this key to a getter #todo
    ; StorageUtil.StringListAdd(None, KeyForOutfitList()) ....
    StorageUtil.FormListClear(playerOrNpc, "EquipCommand_Outfit:" + outfitName)
    int index = 0
    while index < equippedItems.Length
        StorageUtil.FormListAdd(playerOrNpc, "EquipCommand_Outfit:" + outfitName, equippedItems[index])
        index += 1
    endWhile
    MiscUtil.PrintConsole("Saved outfit \"" + outfitName + "\" for " + playerOrNpc.GetBaseObject().GetName())
EndFunction

Function WearOutfit(string outfitName, Actor playerOrNpc) global
    Form[] itemsToEquip = StorageUtil.FormListToArray(playerOrNpc, "EquipCommand_Outfit:" + outfitName)
    if itemsToEquip.Length > 0
        playerOrNpc.UnequipAll()
        Form[] equippedItems = PO3_SKSEFunctions.AddAllEquippedItemsToArray(playerOrNpc)
        if equippedItems.Length > 0
            playerOrNpc.UnequipAll()
        endIf
        int index = 0
        while index < itemsToEquip.Length
            playerOrNpc.EquipItem(itemsToEquip[index])
            index += 1
        endWhile
        MiscUtil.PrintConsole(playerOrNpc.GetBaseObject().GetName() + " switched to outfit \"" + outfitName + "\"")
    else
        MiscUtil.PrintConsole("equip: outfit not found \"" + outfitName + "\"")
    endIf
EndFunction

string Function NpcAliasKeyName(string npcAlias) global
    return "EquipCommand_NpcAlias" + npcAlias
EndFunction

string Function NpcAliasesKeyName() global
    return "EquipCommand_NpcAliases"
EndFunction

Actor Function GetActorFromAliasName(string npcAlias) global
    return StorageUtil.GetFormValue(None, NpcAliasKeyName(npcAlias)) as Actor
EndFunction

string Function GetActorNameFromNpcAlias(string npcAlias) global
    return GetActorFromAliasName(npcAlias).GetBaseObject().GetName()
EndFunction

Function ListNpcAliases() global
    int index = 0
    string[] aliasNames = StorageUtil.StringListToArray(None, NpcAliasesKeyName())
    if aliasNames.Length == 0
        MiscUtil.PrintConsole("No NPC aliases defined. Use equip add <alias name> to add (with actor selected in console)")
    else
        string text = aliasNames.Length + " NPC aliases:\n"
        while index < aliasNames.Length
            text += "- " + aliasNames[index] + " (" + GetActorNameFromNpcAlias(aliasNames[index]) + ")\n"
            index += 1
        endWhile
        MiscUtil.PrintConsole(text)
    endIf
EndFunction

Function ListOutfits() global

EndFunction