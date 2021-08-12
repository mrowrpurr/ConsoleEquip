scriptName ConsoleEquip_Command_Save hidden

; equip save <outfit name>
; equip sally save <outfit name>
; equip sally save <outfit name> -w -[-w]eapons
; equip sally save <outfit name> -s -[-s]pells
; equip sally save <outfit name> -a -[-a]ll
function Run(Actor npc, string command, string arguments) global
    Debug.Trace("SAVE")
    if command == "save"
        string outfitName = StringUtil.Split(arguments, " ")[0]
        ConsoleEquip_OutfitManager.SaveCurrentOutfit( \
            npc, \
            outfitName, \
            includeWeapons = ShouldIncludeWeapons(arguments), \
            includeSpells = ShouldIncludeSpells(arguments))
    endIf
endFunction

bool function ShouldIncludeWeapons(string arguments) global
    return StringUtil.Find(arguments, "-w") > -1 || StringUtil.Find(arguments, "-a")
endFunction

bool function ShouldIncludeSpells(string arguments) global
    return StringUtil.Find(arguments, "-s") > -1 || StringUtil.Find(arguments, "-a")
endFunction
