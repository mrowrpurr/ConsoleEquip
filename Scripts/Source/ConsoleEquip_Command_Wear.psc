scriptName ConsoleEquip_Command_Wear hidden

string function Usage() global
    return "...."
endFunction

; equip wear <outfit name>
; equip sally wear <outfit name>
; equip sally wear <outfit name> -w -[-w]eapons
; equip sally wear <outfit name> -s -[-s]pells
; equip sally wear <outfit name> -a -[-a]ll
; equip sally wear <outfit name> -v -[-v]erbose
function Run(Actor npc, string[] arguments) global
    if arguments.Length == 0 || arguments[0] == "" || arguments[0] == "help"
        MiscUtil.PrintConsole(Usage())
        return
    elseIf arguments.Length > 1
        MiscUtil.PrintConsole("Unexpected arguments for \"wear\": " + PapyrusUtil.StringJoin(arguments, " "))
        return
    else
        WearTheOutfit(npc, outfitName = arguments[0])
    endIf
endFunction

function WearTheOutfit(Actor npc, string outfitName) global
    if ConsoleEquip_OutfitManager.NpcHasOutfit(npc, outfitName)
        ConsoleEquip_OutfitManager.WearOutfit(npc, outfitName)
        MiscUtil.PrintConsole("Switched to outfit \"" + outfitName + "\" for " + ConsoleEquip_Npcs.GetDisplayName(npc))
    else
        MiscUtil.PrintConsole("Outfit \"" + outfitName + "\" does not exist for " + ConsoleEquip_Npcs.GetDisplayName(npc))
    endIf
endFunction
