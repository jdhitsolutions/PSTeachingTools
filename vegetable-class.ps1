
#region object definitions

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
    [string]$Name
    [int]$Count = (Get-Random -minimum 1 -maximum 20)
    [int]$UPC
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
    Vegetable ([string]$Name, [boolean]$IsRoot, [vegcolor]$Color, [int]$UPC) {
        $this.name = $Name
        $this.IsRoot = $IsRoot
        $this.Color = $Color
        $this.upc = $UPC
    }

    #an empty constructor
    Vegetable () { }

}

#endregion