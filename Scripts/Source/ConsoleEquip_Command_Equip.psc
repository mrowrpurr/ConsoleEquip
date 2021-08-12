scriptName ConsoleEquip_Command_Equip hidden
{This is the main entrypoint for the 'equip' command (and 'e' shorthand alias)}

; Registers 'equip' and 'e' commands with CustomConsoleCommands
function Listen(ConsoleEquip_PlayerScript playerScript) global
    playerScript.RegisterForModEvent( \
        CustomConsoleCommands.RegisterCommand("Equip"), \
        "OnEquipCommand")

    playerScript.RegisterForModEvent( \
        CustomConsoleCommands.RegisterCommand("E"), \
        "OnEquipCommand")
endFunction

; Callback received when the 'equip' or 'e' command is executed in the console
function OnEquipCommand(string eventName, string command, float _, Form sender) global
    string[] parsed = Parse(command)
    Actor npc = ConsoleEquip_Npcs.GetAliasByName(parsed[0])
    ConsoleEquip_Commands.Run(npc, parsed[1], parsed[2])
endFunction

; Returns a string array with three elements:
; 0 - NPC name (or "" for the player)
; 1 - Subcommand, e.g. 'wear' or 'save'
; 2 - Subcommand arguments, e.g. 'town'
;
; Example commands:
;   equip <help>
;   equip help
;   equip save town
;   equip wear town
;   equip add sally
;   equip sally dress
;   equip sally save town
;   equip sally wear town
string[] function Parse(string commandText) global
    string npcAlias = ""
    string command = "help"
    string arguments = ""

    string[] commandParts = StringUtil.Split(commandText, " ")
    if ConsoleEquip_Npcs.IsValidAlias(commandParts[1])
        npcAlias = commandParts[1] ; equip <sally>
        if commandParts.Length > 2 ; equip sally <dress>
            command = commandParts[2]
        endIf
        if commandParts.Length > 3 ; equip sally wear <town>
            string[] remainingArguments = PapyrusUtil.SliceStringArray(commandParts, 3)
            arguments = PapyrusUtil.StringJoin(remainingArguments, " ")
        endIf
    else
        if commandParts.Length > 1 ; equip <wear>
            command = commandParts[1]
        endIf
        if commandParts.Length > 2 ; equip wear <town>
            string[] remainingArguments = PapyrusUtil.SliceStringArray(commandParts, 2)
            arguments = PapyrusUtil.StringJoin(remainingArguments, " ")
        endIf
    endIf

    string[] parsed = new string[3]
    parsed[0] = npcAlias
    parsed[1] = command
    parsed[2] = arguments
    return parsed
endFunction