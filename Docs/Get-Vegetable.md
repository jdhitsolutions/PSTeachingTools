---
external help file: psteachingtools-help.xml
online version: 
schema: 2.0.0
---

# Get-Vegetable

## SYNOPSIS
Get vegetable objects

## SYNTAX

```
Get-Vegetable [[-Name] <String>] [-RootOnly] [<CommonParameters>]
```

## DESCRIPTION
Use this command to retrieve vegetable objects from the local computer. The default is to retrieve all objects but you can select them by name or filter for only root vegetables like carrots.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Get-Vegetable

UPC     Count Name          State    Color     
---     ----- ----          -----    -----     
4060       13 corn          Roasted  yellow    
4353        9 tomato        Raw      red       
4234       19 cucumber      Raw      green     
4493        8 carrot        Raw      orange    
4107       19 radish        Raw      red       
4329       18 peas          Steamed  green     
4083       17 turnip        Boiled   purple    
4407       13 potato        Fried    brown     
4119       15 broccoli      Steamed  green     
4357        4 zucchini      Raw      green     
4242        7 spinach       Raw      green     
4256        8 cauliflower   Steamed  white     
4028       14 pepper        Sauteed  green     
4448       13 pepper        Sauteed  red       
4254        9 pepper        Sauteed  yellow    
4472        5 eggplant      Fried    purple
```

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Get-Vegetable eggplant

UPC     Count Name          State    Color    
---     ----- ----          -----    -----
4472        5 eggplant      Fried    purple
```

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> Get-Vegetable -RootOnly


UPC     Count Name          State    Color     
---     ----- ----          -----    -----     
4493        8 carrot        Raw      orange    
4107       19 radish        Raw      red       
4083       17 turnip        Boiled   purple    
4407       13 potato        Fried    brown
```

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> Get-Vegetable | Group CookedState

Count Name                      Group                                           
----- ----                      -----                                           
    1 Roasted                   {Vegetable}                                     
    6 Raw                       {Vegetable, Vegetable, Vegetable, Vegetable...} 
    3 Steamed                   {Vegetable, Vegetable, Vegetable}               
    1 Boiled                    {Vegetable}                                     
    2 Fried                     {Vegetable, Vegetable}                          
    3 Sauteed                   {Vegetable, Vegetable, Vegetable}
```

Group vegetables by their CookedState property. Note that the default output is not necessarily the actual property name. You can only see that by using Get-Member.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\> Get-Vegetable | Get-Member

TypeName: Vegetable

Name        MemberType Definition                    
----        ---------- ----------                    
Equals      Method     bool Equals(System.Object obj)
GetHashCode Method     int GetHashCode()             
GetType     Method     type GetType()                
Peel        Method     void Peel()                   
Prepare     Method     void Prepare(Status State)    
ToString    Method     string ToString()             
Color       Property   VegColor Color {get;set;}     
CookedState Property   Status CookedState {get;set;} 
Count       Property   int Count {get;set;}          
IsPeeled    Property   bool IsPeeled {get;set;}      
IsRoot      Property   bool IsRoot {get;set;}        
Name        Property   string Name {get;set;}        
UPC         Property   int UPC {get;set;}
```

## PARAMETERS

### -Name
The name of a vegetable

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### [Vegetable]

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-Vegetable]()
[New-Vegetable]()
