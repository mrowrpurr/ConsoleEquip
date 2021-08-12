scriptName ConsoleEquip_ActorUtil

function EquipAllForms(Actor npc, Form[] theForms) global
    int index = 0
    bool equippedLeftHandSpell = false
    while index < theForms.Length
        Form theForm = theForms[index]
        Spell theSpell = theForm as Spell
        if theSpell && npc.HasSpell(theSpell)
            if equippedLeftHandSpell
                npc.EquipSpell(theSpell, 1)
            else
                npc.EquipSpell(theSpell, 0)
            endIf
        elseIf npc.GetItemCount(theForm) > 0
            npc.EquipItem(theForm, abSilent = true)
        else
            Debug.Trace("[ConsoleEquip] NPC " + npc.GetActorBase().GetName() + " no longer has " + theForm.GetName())
        endIf
        index += 1
    endWhile
endFunction

Form[] function GetAllCurrentlyEquippedItems(Actor npc, bool includeWeapons = false) global
    Form equippedInLeftHand = npc.GetEquippedWeapon(abLeftHand = true)
    Form equippedInRightHand = npc.GetEquippedWeapon(abLeftHand = false)
    Form[] equippedItems = new Form[128]
    int equippedItemCount = 0
    int itemCount = npc.GetNumItems()
    int index = 0
    while index < itemCount && equippedItemCount < 128
        Form item = npc.GetNthForm(index)
        if npc.IsEquipped(item)
            if includeWeapons || (item != equippedInLeftHand && item != equippedInRightHand)
                equippedItems[equippedItemCount] = item
                equippedItemCount += 1
            endIf
        endIf
        index += 1    
    endWhile
    return Utility.ResizeFormArray(equippedItems, equippedItemCount)
endFunction
