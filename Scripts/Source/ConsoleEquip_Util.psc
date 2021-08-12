scriptName ConsoleEquip_Util
{Misc utililty functions}

bool function StringArrayContains(string[] values, string value) global
    int index = 0
    while index < values.Length
        if values[index] == value
            return true
        endIf
        index += 1
    endWhile
    return false
endFunction