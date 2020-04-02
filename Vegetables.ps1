

#region some functions for working with vegetable objects

Function Get-Vegetable {
    [cmdletbinding()]
    [OutputType("vegetable")]
    [alias("gveg")]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
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
            ($global:myvegetables).where({$_.IsRoot})
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
    [OutputType("None", "Vegetable")]
    [Alias("sveg")]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ParameterSetName = "input"
        )]
        [Vegetable[]]$InputObject,

        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "name"
        )]
        [string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [int]$Count,
        [Parameter(ValueFromPipelineByPropertyName)]
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
                if ($count) {
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
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none", "Vegetable")]
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
        [alias("IsRoot")]
        [switch]$Root,
        [Parameter(
            Mandatory,
            HelpMessage = "Enter a valid PLU code",
            ValueFromPipelineByPropertyName)]
        [int]$UPC,
        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    }

    Process {

        if ($PSCmdlet.ShouldProcess($Name)) {

            $veggie = [vegetable]::new($name, $Root, $color, $UPC)

            if ($veggie) {
                $veggie.count = $Count

                $global:myvegetables += $veggie

                if ($passthru) {
                    Write-Output $veggie
                }
            }
            else {
                Write-Warning "Oops. Something unexpected happened."
            }
        } #should process
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

#endregion

#region create some vegetable objects and store them in a global array

$global:myvegetables = @()
$raw = Get-Content -Path $PSScriptRoot\rawveggies.json | ConvertFrom-Json
$raw | New-Vegetable
foreach ($item in $global:myvegetables) {
    $raw.where( {$_.upc -eq $item.upc}) | Set-Vegetable
}

#endregion

