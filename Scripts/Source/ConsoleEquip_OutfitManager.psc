scriptName ConsoleEquip_OutfitManager

function SaveCurrentOutfit(Actor npc, string outfitName, bool includeWeapons = false, bool includeSpells = false) global
    Debug.Trace("Save Current Outfit")
    Form[] allCurrentlyEquippedItems = ConsoleEquip_ActorUtil.GetAllCurrentlyEquippedItems(npc, includeWeapons)
    if includeSpells
        Spell leftHandSpell = npc.GetEquippedSpell(0)
        if leftHandSpell
            PapyrusUtil.PushForm(allCurrentlyEquippedItems, leftHandSpell)
        endIf
        Spell rightHandSpell = npc.GetEquippedSpell(1)
        if rightHandSpell
            PapyrusUtil.PushForm(allCurrentlyEquippedItems, rightHandSpell)
        endIf
    endIf
    ConsoleEquip_OutfitStorage.StoreOutfit(npc, allCurrentlyEquippedItems, outfitName)
endFunction

function WearOutfit(Actor npc, string outfitName) global
    if NpcHasOutfit(npc, outfitName)
        Form[] outfitForms = ConsoleEquip_OutfitStorage.GetActorFormsForOutfitName(npc, outfitName)
        npc.UnequipAll()
        ConsoleEquip_ActorUtil.EquipAllForms(npc, outfitForms)
    else
        MiscUtil.PrintConsole("NPC " + npc.GetActorBase().GetName() + " does not have outfit " + outfitName)
    endIf
endFunction

bool function NpcHasOutfit(Actor npc, string outfitName) global
    return ConsoleEquip_OutfitStorage.ActorOutfitNameExists(npc, outfitName)
endFunction
