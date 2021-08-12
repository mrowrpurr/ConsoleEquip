scriptName ConsoleEquip_Commands hidden

function Run(Actor npc, string command, string[] arguments) global
   if command == "" || command == "help"
      ConsoleEquip_Command_Help.Run(npc, arguments)
   elseIf command == "save"
      ConsoleEquip_Command_Save.Run(npc, arguments)
   elseIf command == "wear"
      ConsoleEquip_Command_Wear.Run(npc, arguments)
   endIf
endFunction