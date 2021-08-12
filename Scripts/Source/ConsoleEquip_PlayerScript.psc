scriptName ConsoleEquip_PlayerScript extends ReferenceAlias  
{This represents the player}

; The currently installed version of this mod
float property CurrentlyInstalledModVersion auto

; TODO - Do not allow adding NPC with alias that is a valid subcommand

event OnInit()
    CurrentlyInstalledModVersion = 2.0
    ConsoleEquip_Command_Equip.Listen(self)
endEvent

event OnPlayerLoadGame()
    ConsoleEquip_Command_Equip.Listen(self)
endEvent

; Delegate event handler to Equip command.
event OnEquipCommand(string eventName, string stringValue, float floatValue, Form sender)
    ConsoleEquip_Command_Equip.OnEquipCommand(eventName, stringValue, floatValue, sender)
endEvent