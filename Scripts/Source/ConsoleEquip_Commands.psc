scriptName ConsoleEquip_Commands hidden

function Run(Actor npc, string command, string arguments) global
   ConsoleEquip_Command_Save.Run(npc, command, arguments)
   ConsoleEquip_Command_Wear.Run(npc, command, arguments)
endFunction