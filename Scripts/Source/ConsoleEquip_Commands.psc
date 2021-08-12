scriptName ConsoleEquip_Commands hidden

function Run(Actor npc, string command, string arguments) global
    MiscUtil.PrintConsole("You ran command '" + command \
        + "' with argument(s) '" + arguments \
        + "' for NPC " + npc.GetBaseObject().GetName())

    ;
    ;
    ;
    ;
    ;
    ;
endFunction