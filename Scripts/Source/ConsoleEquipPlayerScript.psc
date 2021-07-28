Scriptname ConsoleEquipPlayerScript extends ReferenceAlias  

Event OnInit()
    ListenForConsoleCommand()
EndEvent

Function ListenForConsoleCommand()
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("E"), "OnEquipCommand")
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("Equip"), "OnEquipCommand")
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("Gold"), "OnGoldCommand")
EndFunction

Event OnEquipCommand(string eventName, string strArg, float numArg, Form sender)
    EquipCommand.Run(StringUtil.Split(strArg, " "), GetActorReference())
EndEvent