Scriptname ConsoleEquipPlayerScript extends ReferenceAlias  

Event OnInit()
    ListenForConsoleCommand()
EndEvent

Function ListenForConsoleCommand()
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("E"), "OnEquipCommand")
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("Equip"), "OnEquipCommand")
EndFunction

Event OnEquipCommand(string eventName, string command, float numArg, Form sender)
    if StringUtil.Find(command, " ") > -1
        EquipCommand.Run(StringUtil.Split(command, " "), GetPlayerOrNpc())
    else
        string[] commandParts = new string[1]
        commandParts[0] = "Equip"
        EquipCommand.Run(StringUtil.Split(command, " "), GetPlayerOrNpc())
    endIf
EndEvent

Actor Function GetPlayerOrNpc()
    Actor target = Game.GetCurrentConsoleRef() as Actor
    if target
        return target
    else
        return GetActorReference()
    endIf
EndFunction