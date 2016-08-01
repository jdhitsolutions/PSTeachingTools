---
external help file: psteachingtools-help.xml
online version: 
schema: 2.0.0
---

# Set-Vegetable
## SYNOPSIS
Set a vegetable property

## SYNTAX

### name (Default)
```
Set-Vegetable [[-Name] <String>] [-Count <Int32>] [-CookingState <Status>] [-Passthru] [-WhatIf] [-Confirm]
```

### input
```
Set-Vegetable [[-InputObject] <Vegetable[]>] [-Count <Int32>] [-CookingState <Status>] [-Passthru] [-WhatIf]
 [-Confirm]
```

## DESCRIPTION
Use this command to set vegetable properties. You can either specify a vegetable 
by name or pipe objects from Get-Vegetable. By default this command does not write
anything to the pipeline unless you use -Passthru.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Set-Vegetable eggplant -cookingstate Roasted -count 5 -passthru

UPC     Count Name          State    Color     
---     ----- ----          -----    -----     
4493        5 eggplant      Roasted  purple
```
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Get-Vegetable pepper | Set-Vegetable -cookingstate steamed 
```

## PARAMETERS

### -Confirm

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CookingState
Set the vegetable's cooking state.

```yaml
Type: Status
Parameter Sets: (All)
Aliases: 
Accepted values: Raw, Boiled, Steamed, Sauteed, Fried, Baked, Roasted

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count
Set the number of each vegetable. This should be a number between 1 and 20.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
A piped in vegetable object.

```yaml
Type: Vegetable[]
Parameter Sets: input
Aliases: 

Required: False
Position: 0
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
The name of a vegetable.

```yaml
Type: String
Parameter Sets: name
Aliases: 

Required: False
Position: 0
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -Passthru

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### [Vegetable[]]

## OUTPUTS

### [Vegetable]

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Get-Vegetable]()
[New-Vegetable]()

