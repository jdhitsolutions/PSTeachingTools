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
