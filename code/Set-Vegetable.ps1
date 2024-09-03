Function Set-Vegetable {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "input")]
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
        [String]$Name,

        [Parameter()]
        [Int]$Count,

        [Parameter()]
        [alias("state")]
        [PSTeachingTools.VegStatus]$CookingState,

        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Detected parameter set $($PSCmdlet.ParameterSetName)"
        $PSBoundParameters | Out-String | Write-Verbose
        if ($PSCmdlet.ParameterSetName -eq 'name') {
            $InputObject = $global:MyVegetables.Where( { $_.Name -like $Name })
            if (-Not $InputObject) {
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
                    if ($PassThru) {
                        $item
                    }
                }
            } #foreach
        } #if input
    }

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
