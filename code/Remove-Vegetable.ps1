Function Remove-Vegetable {
    [CmdletBinding(SupportsShouldProcess)]
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
        [String]$Name,

        [Parameter(HelpMessage = "Write the removed object to the pipeline")]
        [Switch]$PassThru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    Process {
        if ($PSCmdlet.ParameterSetName -eq 'name') {
            $InputObject = $global:MyVegetables.Where( { $_.Name -like $Name })
            if (-Not $InputObject) {
                Write-Warning "Failed to find a vegetable called $name"
            }
        }
        If ($InputObject) {
            foreach ($item in $InputObject) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Removing $($item.name)"
                if ($PSCmdlet.ShouldProcess($item.name)) {
                    [void]($global:MyVegetables.remove($item))
                    if ($PassThru) {
                        $item
                    }
                } #WhatIf
            } #foreach item
        } #if InputObject
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
