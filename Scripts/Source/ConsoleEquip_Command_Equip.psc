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
    ; Example commands:
    ;   equip <help>
    ;   equip help
    ;   equip save town
    ;   equip wear town
    ;   equip add sally
    ;   equip sally dress
    ;   equip sally save town
    ;   equip sally wear town
    string[] parsed = Parse(command)
endFunction

; Returns a string array with three elements:
; 0 - NPC name (or "" for the player)
; 1 - Subcommand, e.g. 'wear' or 'save'
; 2 - Subcommand arguments, e.g. 'town'
string[] function Parse(string command) global
    string[] commandParts = StringUtil.Split(command, " ")

    string npcName = ""
    string subcommand = "help"
    string subcommandArguments = ""

    if ConsoleEquip_Npcs.IsValidAlias(commandParts[1])
        npcName = commandParts[1] ; equip <sally>
        if commandParts.Length > 2
            subcommand = commandParts[2] ; equip sally <dress>
        endIf
        if commandParts.Length > 3
            subcommandArguments = commandParts[3] ; equip sally wear <town>
        endIf
    else
        if commandParts.Length > 1
            subcommand = commandParts[1] ; equip <wear>
        endIf
        if commandParts.Length > 2
            subcommandArguments = commandParts[2] ; equip wear <town>
        endIf
    endIf

    string[] parsed = new string[3]
    parsed[0] = npcName
    parsed[1] = subcommand
    parsed[2] = subcommandArguments
    return parsed
endFunction