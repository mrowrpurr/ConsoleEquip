scriptName ConsoleEquip_Npcs

bool function IsValidAlias(string npcAlias) global
    return false
endFunction

Actor function GetAliasByName(string npcAlias) global
    if npcAlias == ""
        return Game.GetPlayer()
    endIf
endFunction