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

}
