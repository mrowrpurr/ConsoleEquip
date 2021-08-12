scriptName ConsoleEquip_Command_Help hidden

string function Usage() global
    return "Usage: [e]quip [npc alias] <command> <arguments>\n" + \
        "\n" + \
        "Available commands:\n" + \
        "- save:\tSaves outfit for player/NPC\n" + \
        "- wear:\tSwitches to outfit for player/NPC\n" + \
        "- \n" + \
        "Run command with no arguments for more info.\n"
endFunction

function Run(Actor npc, string[] arguments) global
    if arguments == ""
        MiscUtil.PrintConsole(Usage())
    elseif arguments[0] == "save"
        MiscUtil.PrintConsole(ConsoleEquip_Command_Save.Usage())
    elseif arguments[0] == "wear"
        MiscUtil.PrintConsole(ConsoleEquip_Command_Wear.Usage())
    else
        MiscUtil.PrintConsole("Unknown command: \"" + arguments + "\"")
    endIf
endFunction