---
external help file: PSTeachingTools-help.xml
Module Name: PSTeachingTools
online version: https://github.com/jdhitsolutions/PSTeachingTools/blob/master/docs/Get-Vegetable.md
schema: 2.0.0
---

# Get-Vegetable

## SYNOPSIS

Get vegetable objects

## SYNTAX

```yaml
Get-Vegetable [[-Name] <String>] [-RootOnly] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve vegetable objects from the local computer. The default is to retrieve all objects but you can select them by name or filter for only root vegetables like carrots.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-Vegetable

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4078       12 Corn                 Roasted  yellow
4064        4 Tomato               Raw      red
4062       11 Cucumber             Raw      green
4562       10 Carrot               Raw      orange
4089       13 Radish               Raw      red
4674       14 Peas                 Steamed  green
4811       12 Turnip               Boiled   purple
4725       18 Russet Potato        Fried    brown
4060       15 Broccoli             Steamed  green
4067        7 Zucchini             Raw      green
4090        4 Spinach              Raw      green
4572        7 Cauliflower          Steamed  white
3125       17 Habanero Pepper      Raw      orange
4677       16 Anaheim Pepper       Raw      green
4088       19 Red Bell Pepper      Sauteed  red
4081        6 Eggplant             Fried    purple
4604        2 Endive               Raw      green

```

### Example 2

```powershell
PS C:\> Get-Vegetable Eggplant

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4081        6 Eggplant             Fried    purple

```

Get a vegetable object by name.

### Example 3

```powershell
PS C:\> Get-Vegetable -RootOnly

UPC     Count Name                 State    Color
---     ----- ----                 -----    -----
4562       10 Carrot               Raw      orange
4089       13 Radish               Raw      red
4811       12 Turnip               Boiled   purple
4725       18 Russet Potato        Fried    brown
```

Get only root vegetables.

### Example 4

```powershell
PS C:\> Get-Vegetable | Group CookedState

Count Name                      Group
----- ----                      -----
    9 Raw                       {PSTeachingTools.PSVegetable, PSTeachingToo...
    1 Boiled                    {PSTeachingTools.PSVegetable}
    3 Steamed                   {PSTeachingTools.PSVegetable, PSTeachingToo...
    1 Sauteed                   {PSTeachingTools.PSVegetable}
    2 Fried                     {PSTeachingTools.PSVegetable, PSTeachingToo...
    1 Roasted                   {PSTeachingTools.PSVegetable}
```

Group vegetables by their CookedState property. Note that the default output is not necessarily the actual property name. You can only see that by using Get-Member.

### Example 5

```powershell
PS C:\> Get-Vegetable | Get-Member

   TypeName: PSTeachingTools.PSVegetable

Name        MemberType    Definition
----        ----------    ----------
State       AliasProperty State = CookedState
Equals      Method        bool Equals(System.Object obj)
GetHashCode Method        int GetHashCode()
GetType     Method        type GetType()
Peel        Method        void Peel()
Prepare     Method        void Prepare(PSTeachingTools.VegStatus State)
ToString    Method        string ToString()
Color       Property      PSTeachingTools.VegColor Color {get;}
CookedState Property      PSTeachingTools.VegStatus CookedState {get;set;}
Count       Property      int Count {get;set;}
IsPeeled    Property      bool IsPeeled {get;set;}
IsRoot      Property      bool IsRoot {get;}
Name        Property      string Name {get;}
UPC         Property      int UPC {get;}
```

Discover the properties and methods of a vegetable object.

## PARAMETERS

### -Name

The name of a vegetable.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -RootOnly

Only get root vegetables like carrots or turnips.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

### PSTeachingTools.PSVegetable

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-Vegetable](Set-Vegetable.md)

[New-Vegetable](New-Vegetable.md)

[Remove-Vegetable](Remove-Vegetable.md)
