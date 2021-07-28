Scriptname GoldCommand

Function Run(string[] arguments, Actor player) global
    int amount = arguments[1] as int
    if amount
        player.AddItem(Game.GetForm(0xf), amount)
    else
        MiscUtil.PrintConsole("Usage: gold [value]")
    endIf
EndFunction