Scriptname ConsoleEquipPlayerScript extends ReferenceAlias  

ObjectReference property ConsoleEquipContainerInstance auto
Actor property CurrentNpc auto

Event OnInit()
    ListenForConsoleCommand()
EndEvent

Function ListenForConsoleCommand()
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("E"), "OnEquipCommand")
    RegisterForModEvent(CustomConsoleCommands.RegisterCommand("Equip"), "OnEquipCommand")
EndFunction

Event OnMenuClose(string menuName)
    EquipCommand.OnMenuClose(menuName, Self)
EndEvent

Event OnEquipCommand(string eventName, string command, float numArg, Form sender)
    if StringUtil.Find(command, " ") > -1
        EquipCommand.Run(StringUtil.Split(command, " "), GetPlayerOrNpc(), Self)
    else
        string[] commandParts = new string[1]
        commandParts[0] = "Equip"
        EquipCommand.Run(StringUtil.Split(command, " "), GetPlayerOrNpc(), Self)
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