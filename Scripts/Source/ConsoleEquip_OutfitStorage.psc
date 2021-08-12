scriptName ConsoleEquip_OutfitStorage
{Manages storage of outfits in StorageUtil}

; [String List]
;   Actor, "EquipCommand_OutfitNames"
;   List of all of this Actor's outfit names
;
; Note:
;   To perform the v2.0 upgrade, use: debug_AllObjFormKeys(Actor)

; [Form List]
;   List of all items in the provided outfit
;   Actor, "EquipCommand_Outfit:" + outfitName

; [String List]
;   The names of all the NPCs aliased
;   None, "EquipCommand_NpcAliases"

; [Form values]
;   References to NPC Actors by name
;   None, "EquipCommand_NpcAlias" + npcAlias

function StoreOutfit(Actor npc, Form[] equippedItemsAndSpells, string outfitName) global
    ; Register the outfit for this NPC in a string list
    StorageUtil.StringListAdd(npc, Key_Actor_OutfitNames(), outfitName)

    ; Create a new Form[] key on this NPC with all of the items provided (clear it first in case it exists)
    StorageUtil.FormListClear(npc, Key_Actor_OutfitForms(outfitName))

    ; Can't seem to get this working! Adding individually below instead.
    ; StorageUtil.FormListSlice(npc, Key_Actor_OutfitForms(outfitName), equippedItemsAndSpells)

    int index = 0
    while index < equippedItemsAndSpells.Length
        StorageUtil.FormListAdd(npc, Key_Actor_OutfitForms(outfitName), equippedItemsAndSpells[index])
        index += 1
    endWhile
endFunction

; function RemoveOutfit()
; endFunction

bool function ActorOutfitNameExists(Actor npc, string outfitName) global
    return StorageUtil.StringListHas(npc, Key_Actor_OutfitNames(), outfitName)
endFunction

Form[] function GetActorFormsForOutfitName(Actor npc, string outfitName) global
    return StorageUtil.FormListToArray(npc, Key_Actor_OutfitForms(outfitName))
endFunction

string function Key_Actor_OutfitNames() global
    return "EquipCommand_OutfitNames"
endFunction

string function Key_Actor_OutfitForms(string outfitName) global
    return "EquipCommand_Outfit:" + outfitName
endFunction
