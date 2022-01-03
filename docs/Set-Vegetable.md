---
external help file: PSTeachingTools-help.xml
Module Name: PSTeachingTools
online version: https://bit.ly/2XmCCkB
schema: 2.0.0
---

# Set-Vegetable

## SYNOPSIS

Set a vegetable property

## SYNTAX

### name (Default)

```yaml
Set-Vegetable [[-Name] <String>] [-Count <Int32>] [-CookingState <VegStatus>] [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### input

```yaml
Set-Vegetable [[-InputObject] <PSVegetable[]>] [-Count <Int32>] [-CookingState <VegStatus>] [-Passthru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to set vegetable properties. You can either specify a vegetable by name or pipe objects from Get-Vegetable. By default this command does not write anything to the pipeline unless you use -Passthru.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-Vegetable eggplant -cookingstate Roasted -count 5 -passthru

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4081        5 eggplant             Roasted  purple
```

### Example 2

```powershell
PS C:\> Get-Vegetable -Name "anaheim pepper" | Set-Vegetable -CookingState grilled
```

## PARAMETERS

### -Confirm

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CookingState

Set the vegetable's cooking state. This is a value from the [PSTeachingTools.VegStatus] enumeration.

```yaml
Type: VegStatus
Parameter Sets: (All)
Aliases: state
Accepted values: Raw, Boiled, Steamed, Sauteed, Fried, Baked, Roasted, Grilled

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

A piped in vegetable object.

```yaml
Type: PSVegetable[]
Parameter Sets: input
Aliases:

Required: False
Position: 0
Default value: None
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
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Passthru

Write the object to the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

### PSTeachingTools.PSVegetable

## OUTPUTS

### None

### PSTeachingTools.PSVegetable

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-Vegetable](Get-Vegetable.md)

[New-Vegetable](New-Vegetable.md)

[Remove-Vegetable](Remove-Vegetable.md)
