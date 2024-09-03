[CmdletBinding()]
Param()
#region class definitions

#only add the class definition if it doesn't already exist in the current session
Write-Verbose "Defining PSTeachingTools.PSVegetable class"
Try {
     [void]([PSTeachingTools.PSVegetable].name)
     Write-Verbose "The class already exists in this session."
}
Catch {
    Write-Verbose "Adding class definition"
    Add-Type -path $PSScriptRoot\psteachingtools.cs
}

<#
#this is the previous PowerShell class definition of the vegetable class

#enumerations for a few of the class properties
Enum Status {
    Raw
    Boiled
    Steamed
    Sauteed
    Fried
    Baked
    Roasted
    Grilled
}

Enum VegColor {
    green
    red
    white
    yellow
    orange
    purple
    brown
}

#a class to define a new type of object
Class Vegetable {

    #properties
    [String]$Name
    [Int]$Count = (Get-Random -minimum 1 -maximum 20)
    [Int]$UPC
    [Status]$CookedState
    [boolean]$IsRoot
    [boolean]$IsPeeled
    [VegColor]$Color

    #methods
    [void]Peel() {
        $this.IsPeeled = $True
    }

    [void]Prepare([status]$State) {
        $this.CookedState = $State
    }

    #constructors
    Vegetable ([String]$Name, [boolean]$IsRoot, [vegcolor]$Color, [Int]$UPC) {
        $this.name = $Name
        $this.IsRoot = $IsRoot
        $this.Color = $Color
        $this.upc = $UPC
    }

    #an empty constructor
    Vegetable () { }
}

#endregion
#>
