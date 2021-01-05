---
external help file: PSTeachingTools-help.xml
Module Name: PSTeachingTools
online version: https://bit.ly/389v9vb
schema: 2.0.0
---

# New-Vegetable

## SYNOPSIS

Create a new vegetable object.

## SYNTAX

```yaml
New-Vegetable [-Name] <String> [-Color] <VegColor> [-Count <Int32>] [-Root] -UPC <Int32> [-Passthru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to create a new vegetable object. You must specify a vegetable name, UPC value, and color. Note that this command does not write anything to the pipeline unless you use -Passthru.

You can search the module variable $vegetableplu to find a matching item. See examples.

## EXAMPLES

### Example 1

```powershell
PS C:\> $vegetableplu | where name -match kiwi

PLUCode Name
------- ----
3279    Golden Kiwifruit
3280    Jumbo Regular Kiwifruit
4030    Regular Kiwifruit
4301    Retailer Assigned Kiwifruit

PS C:\> New-Vegetable -name kiwi -color green -upc 4030 -passthru

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4030        1 kiwi                 Raw      green
```

Find a UPC value from $vegetableplu and create a new vegetable object.

### Example 2

```powershell
PS C:\> New-Vegetable -name kale -color green -upc 4627 -passthru | Set-Vegetable -cookingstate sauteed -passthru

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4627        1 kale                 Sauteed  green
```

### Example 3

```powershell
PS C:\> New-Vegetable -name "Sweet Potato" -upc 3334 -color orange -root
```

## PARAMETERS

### -Color

What is the color of the vegetable? This is a value from the [PSTeachingTools.VegColor] enumeration.

```yaml
Type: VegColor
Parameter Sets: (All)
Aliases:
Accepted values: green, red, white, yellow, orange, purple, brown

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Count

How many vegetables do you want? Pick a number between 1 and 20.

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

### -Name

What is the name of the vegetable?

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
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

### -Root

Indicate that this is a root vegetable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: IsRoot

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

### -UPC

Enter a valid PLU code. You can search $vegetableupc for a valid code.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### None

## OUTPUTS

### None

### PSTeachingTools.PSVegetable

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-Vegetable](Get-Vegetable.md)

[Set-Vegetable](Set-Vegetable.md)

[Remove-Vegetable](Remove-Vegetable.md)
