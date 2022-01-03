
. $PSScriptRoot\vegetable-class.ps1

#region some functions for working with vegetable objects

Function Get-Vegetable {
    [cmdletbinding()]
    [OutputType("PSTeachingTools.PSVegetable")]
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
        #verify the myvegetables array exists
        if ( $global:myvegetables.count -gt 0) {
            Write-Verbose "[PROCESS] Processing $($global:myvegetables.count) items."
            if ($name -AND $RootOnly) {
                Write-Verbose "[PROCESS] Getting vegetable $name where it is a root vegetable"
                ($global:myvegetables).where( { ($_.IsRoot) -And ($_.name -like $name) })
                # $global:myvegetables | where {($_.IsRoot) -And ($_.name -like $name)}
            }
            elseif ($Name) {
                Write-Verbose "[PROCESS] Getting vegetable $name"
                $result = ($global:myvegetables).where( { $_.name -like $name })
                if ($result) {
                    $result
                }
                else {
                    Throw "Can't find a vegetable with the name $Name"
                }
            }
            elseif ($RootOnly) {
                Write-Verbose "[PROCESS] Getting root vegetables only"
                ($global:myvegetables).where( { $_.IsRoot })
            }
            else {
                Write-Verbose "[PROCESS] Getting all vegetables"
                $global:myvegetables
            }
        } #if myvegetables
        else {
            Write-Warning "Failed to find vegetable source."
        }
    } #Process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
}

Function Set-Vegetable {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = "name")]
    [OutputType("None", "PSTeachingTools.PSVegetable")]
    [Alias("sveg")]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ParameterSetName = "input"
        )]
        [PSTeachingTools.PSVegetable[]]$InputObject,

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
        [alias("state")]
        [PSTeachingTools.VegStatus]$CookingState,

        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Detected parameter set $($pscmdlet.ParameterSetName)"
        if ($PSCmdlet.ParameterSetName -eq 'name') {
            $inputObject = $global:myvegetables.Where( { $_.Name -like $Name })
            if (-Not $inputObject) {
                Write-Warning "Failed to find a vegetable called $name"
            }
        }
        If ($InputObject) {
            foreach ($item in $InputObject) {
                Write-Verbose "[PROCESS] Modifying $($item.name)"
                if ($PSCmdlet.ShouldProcess($item.name)) {
                    if ($CookingState) {
                        Write-Verbose "[PROCESS] Updating cooking state to $cookingstate"
                        $item.Prepare($CookingState)
                    }
                    if ($count) {
                        Write-Verbose "[PROCESS] Updating count to $count"
                        $item.count = $count
                    }
                    if ($Passthru) {
                        $item
                    }
                }
            } #foreach
        } #if input
    }

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function New-Vegetable {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none", "PSTeachingTools.PSVegetable")]
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
        [PSTeachingTools.VegColor]$Color,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(1, 20)]
        [int]$Count = 1,

        [Parameter(ValueFromPipelineByPropertyName)]
        [alias("IsRoot")]
        [switch]$Root,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter a valid PLU code",
            ValueFromPipelineByPropertyName
        )]
        [int]$UPC,

        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    }

    Process {
        if ($PSCmdlet.ShouldProcess($Name)) {
            Write-Verbose "[PROCESS] Creating $name"
            $veggie = [PSTeachingTools.PSVegetable]::new($name, $Root, $color, $UPC)

            if ($veggie) {
                $veggie.count = $Count
                Write-Verbose "Adding to global listget-v"
                $global:myvegetables.Add($veggie)

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



Function Remove-Vegetable {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none", "PSTeachingTools.PSVegetable")]
    [Alias("rveg")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ParameterSetName = "input"
        )]
        [PSTeachingTools.PSVegetable[]]$InputObject,

        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "name"
        )]
        [string]$Name,

        [Parameter(HelpMessage = "Write the removed object to the pipeline")]
        [switch]$Passthru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        if ($PSCmdlet.ParameterSetName -eq 'name') {
            $inputObject = $global:myvegetables.Where( { $_.Name -like $Name })
            if (-Not $inputObject) {
                Write-Warning "Failed to find a vegetable called $name"
            }
        }
        If ($InputObject) {
            foreach ($item in $InputObject) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Removing $($item.name)"
                if ($PSCmdlet.ShouldProcess($item.name)) {
                    [void]($global:myvegetables.remove($item))
                    if ($passthru) {
                        $item
                    }
                } #WhatIf
            } #foreach item
        } #if inputobject
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Remove-Vegetable

#endregion

#create an argument completer for a subset of vegetable commands
$verbs = "Get","Set","Remove"
foreach ($verb in $verbs) {
    Register-ArgumentCompleter -CommandName "$verb-Vegetable" -ParameterName Name -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #PowerShell code to populate $wordtoComplete
        $global:myvegetables.name | Where-Object { $_ -Like "$WordToComplete*" } |
        ForEach-Object {
            #wrap items with spaces in quotes [Issue #10]
            if ($_ -match "\s") {
                $complete = "'$_'"
            }
            else {
                $complete = $_
            }
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($complete, $complete, 'ParameterValue', $complete)
        }
    }
}
