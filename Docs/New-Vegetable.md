---
external help file: psteachingtools-help.xml
online version: 
schema: 2.0.0
---

# New-Vegetable
## SYNOPSIS
Create a new vegetable object.
## SYNTAX

```
New-Vegetable [-Name] <String> [-Color] <VegColor> [-Count <Int32>] [-Root] [-Passthru] [<CommonParameters>]
```

## DESCRIPTION
Use this command to create a new vegetable object. You must specify a vegetable name and color. Note that this command does not write anything to the pipeline unless you use -Passthru.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> New-Vegetable -name leek -color green -passthru 

UPC     Count Name          State    Color     
---     ----- ----          -----    -----     
4069        1 leek          Raw      green
```

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> New-Vegetable -name kale -color green -passthru | Set-Vegetable -cookingstate sauteed -passthru

UPC     Count Name          State    Color
---     ----- ----          -----    -----
4302        1 kale          Sauteed  green
```

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> New-Vegetable -name "Sweet Potato" -color orange -root
```

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> Import-CSV c:\work\myveggies.csv | New-Vegetable 
```

Import a CSV file with headings that match the parameters for New-Vegetable and create new vegetable objects.

## PARAMETERS

### -Color
What is the vegetable color?

```yaml
Type: VegColor
Parameter Sets: (All)
Aliases: 
Accepted values: green, red, white, yellow, orange, purple, brown

Required: True
Position: 1
Default value: 
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
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
What is the vegetable name?

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
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

### -Root
Indicate that this is a root vegetable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None

## OUTPUTS

### [Vegetable]

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/
## RELATED LINKS

[Get-Vegetable]()
[Set-Vegetable]()
