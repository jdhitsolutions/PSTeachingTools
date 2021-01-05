---
external help file: PSTeachingTools-help.xml
Module Name: PSTeachingTools
online version:
schema: 2.0.0
---

# Remove-Vegetable

## SYNOPSIS

Delete a Vegetable object.

## SYNTAX

### input

```yaml
Remove-Vegetable [[-InputObject] <PSVegetable[]>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### name

```yaml
Remove-Vegetable [[-Name] <String>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will remove a vegetable object from your PowerShell session. It will not write anything to the pipeline unless you use -Passthru.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-Vegetable -name corn
```

### Example 2

```powershell
PS C:\> Get-Vegetable *pepper | Remove-Vegetable -passthru

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
3125       17 habanero pepper      Raw      orange
4677       16 Anaheim pepper       Raw      green
4088       19 red bell pepper      Sauteed  red
```

## PARAMETERS

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

### -InputObject

A piped in Vegetable object.

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

The name of a vegetable object.

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

Write the removed object to the pipeline

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### PSTeachingTools.PSVegetable[]

### System.String

## OUTPUTS

### none

### PSTeachingTools.PSVegetable

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-Vegetable](Get-Vegetable.md)

[Set-Vegetable](Set-Vegetable.md)

[New-Vegetable](New-Vegetable.md)
