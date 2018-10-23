
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

#region some functions for working with vegetable objects

Function Get-Vegetable {
    [cmdletbinding()]
    [OutputType("vegetable")]
    [alias("gveg")]

    Param(
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [switch]$RootOnly
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    }

    Process {
        if ($name -AND $RootOnly) {
            Write-Verbose "[PROCESS] Getting vegetable $name where it is a root vegetable"
            ($global:myvegetables).where( {($_.IsRoot) -And ($_.name -like $name)})
            # $global:myvegetables | where {($_.IsRoot) -And ($_.name -like $name)}
        }
        elseif ($Name) {
            Write-Verbose "[PROCESS] Getting vegetable $name"
            $result = ($global:myvegetables).where( {$_.name -like $name})
            if ($result) {
                $result
            }
            else {
                Throw "Can't find a vegetable with the name $Name"
            }
        }
        elseif ($RootOnly) {
            Write-Verbose "[PROCESS] Getting root vegetables only"
            ($global:myvegetables).where( {$_.IsRoot})
        }
        else {
            Write-Verbose "[PROCESS] Getting all vegetables"
            $global:myvegetables
        }
    }

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"  
    }


}

Function Set-Vegetable {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = "name")]
    [OutputType("None","Vegetable")]
    [Alias("sveg")]

    Param(
        [Parameter(Position = 0, ValueFromPipeline, ParameterSetName = "input")]
        [Vegetable[]]$InputObject,

        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName,ParameterSetName = "name")]
        [string]$Name,
        [int]$Count,
        [status]$CookingState,
        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    } #begin

    Process {
        if ($PSCmdlet.ParameterSetName -eq 'name') {
            $inputObject = Get-Vegetable -Name $Name
            Write-Verbose "[PROCESS] Modifying $name"
        }
        else {
            Write-Verbose "[PROCESS] Modifying $($inputobject.name)"
        }

        foreach ($item in $InputObject) {
            if ($PSCmdlet.ShouldProcess($item.name)) {
                if ($CookingState) {
                    $item.Prepare($CookingState)
                }
                if ($count ) {
                    $item.count = $count
                }
                if ($Passthru) {
                    $item
                }
            }
        } #foreach
    }

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}

Function New-Vegetable {
    [cmdletbinding()]
    [OutputType("none","Vegetable")]
    [alias("nveg")]

    Param(
        [Parameter(
            Position = 0, 
            Mandatory, 
            HelpMessage = "What is the vegetable name?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [string]$Name,
        [Parameter(
            Position = 1, 
            Mandatory, 
            HelpMessage = "What is the vegetable color?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [vegcolor]$Color,
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(1, 20)]
        [int]$Count = 1,
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]$Root,
        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    }

    Process {
        #display PSBoundparameters formatted nicely for Verbose output  
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*4)$_"}) | Out-String) `n" 

        #get a new code
        $codes = (Get-Vegetable).UPC
        do { $upc = Get-Random -Minimum 4000 -Maximum 5000} until ($codes -notcontains $upc) 

        $veggie = [vegetable]::new($name, $Root, $color, $UPC)

        if ($veggie) {
            $veggie.count = $Count

            $global:myvegetables += $veggie

            if ($passthru) {
                write-output $veggie
            }
        }
        else {
            Write-Warning "Oops. Something unexpected happened."
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
} 

#endregion

#region create some vegetable objects and store them in a global array

$global:myvegetables = @()

New-Vegetable -name "corn" -color yellow -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "tomato" -color red -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "cucumber" -color green -count (Get-Random -Minimum 1 -Maximum 20) 
New-Vegetable -name "carrot" -Root -color orange -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "radish" -root -color red -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "peas" -color green -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "turnip" -Root -color purple -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "potato" -root -color brown -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "broccoli" -color green -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "zucchini" -color green -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "spinach" -color green -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "cauliflower" -color white -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "pepper" -color green -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "pepper" -color red -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "pepper" -color yellow -count (Get-Random -Minimum 1 -Maximum 20)
New-Vegetable -name "eggplant" -color purple -count (Get-Random -Minimum 1 -Maximum 20)

#modify the state of some of the vegetables to provide a variety of properties

Set-Vegetable -name pepper -cookingstate sauteed
Set-Vegetable -name potato -cookingstate fried
Set-Vegetable -name broccoli -cookingstate steamed
Set-Vegetable -name peas -cookingstate steamed
Set-Vegetable -name corn -cookingstate roasted
Set-Vegetable -name turnip -cookingstate boiled
Set-Vegetable -name cauliflower -cookingstate steamed
Set-Vegetable -name eggplant -cookingstate fried

#endregion