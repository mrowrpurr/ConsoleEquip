scriptName ConsoleEquip_Command_Save hidden

string function Usage() global
    return "...."
endFunction

; equip save <outfit name>
; equip sally save <outfit name>
; equip sally save <outfit name> -w -[-w]eapons
; equip sally save <outfit name> -s -[-s]pells
; equip sally save <outfit name> -a -[-a]ll
; equip sally save <outfit name> -v -[-v]erbose
function Run(Actor npc, string[] arguments) global
    if arguments.Length == 0 || arguments[0] == "" || arguments[0] == "help"
        MiscUtil.PrintConsole(Usage())
        return
    elseIf arguments.Length > 1
        MiscUtil.PrintConsole("Unexpected arguments for \"save\": " + PapyrusUtil.StringJoin(arguments, " "))
        return
    else
        SaveTheOutfit( \
            npc, \
            outfitName = arguments[0], \
            includeWeapons = ShouldIncludeWeapons(arguments), \
            includeSpells = ShouldIncludeSpells(arguments) )
    endIf
endFunction

function SaveTheOutfit(Actor npc, string outfitName, bool includeWeapons = false, bool includeSpells = false) global
    bool updatingPreviousOutfit = ConsoleEquip_OutfitManager.NpcHasOutfit(npc, outfitName)
    
    ConsoleEquip_OutfitManager.SaveCurrentOutfit(npc, outfitName, includeWeapons, includeSpells)

    if updatingPreviousOutfit
        MiscUtil.PrintConsole("Updated outfit \"" + outfitName + "\" for " + ConsoleEquip_Npcs.GetDisplayName(npc))
    else
        MiscUtil.PrintConsole("Saved outfit \"" + outfitName + "\" for " + ConsoleEquip_Npcs.GetDisplayName(npc))
    endIf
endFunction

bool function ShouldIncludeWeapons(string[] arguments) global
    return ConsoleEquip_Util.StringArrayContains(arguments, "-w") || ConsoleEquip_Util.StringArrayContains(arguments, "--weapons") || IncludeBothWeaponsAndSpells(arguments)
endFunction

bool function ShouldIncludeSpells(string[] arguments) global
    return ConsoleEquip_Util.StringArrayContains(arguments, "-s") || ConsoleEquip_Util.StringArrayContains(arguments, "--spells") || IncludeBothWeaponsAndSpells(arguments)
endFunction

bool function IncludeBothWeaponsAndSpells(string[] arguments) global
    return ConsoleEquip_Util.StringArrayContains(arguments, "-a") || ConsoleEquip_Util.StringArrayContains(arguments, "--all")
endFunction
