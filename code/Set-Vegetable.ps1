Function Set-Vegetable {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = "input")]
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
            ParameterSetName = "name"
        )]
        [string]$Name,

        [Parameter()]
        [int]$Count,

        [Parameter()]
        [alias("state")]
        [PSTeachingTools.VegStatus]$CookingState,

        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Detected parameter set $($pscmdlet.ParameterSetName)"
        $PSBoundParameters | Out-String | Write-Verbose
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
                    if ($PSBoundParameters.ContainsKey("CookingState")) {
                        Write-Verbose "[PROCESS] Updating cooking state to $cookingstate"
                        $item.Prepare($CookingState)
                    }
                    if ($PSBoundParameters.ContainsKey("Count")) {
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
