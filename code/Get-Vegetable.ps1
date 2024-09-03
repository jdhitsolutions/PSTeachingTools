Function Get-Vegetable {
    [CmdletBinding()]
    [OutputType("PSTeachingTools.PSVegetable")]
    [alias("gveg")]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [String]$Name,

        [Switch]$RootOnly
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    }

    Process {
        #verify the MyVegetables array exists
        if ( $global:MyVegetables.count -gt 0) {
            Write-Verbose "[PROCESS] Processing $($global:MyVegetables.count) items."
            if ($name -AND $RootOnly) {
                Write-Verbose "[PROCESS] Getting vegetable $name where it is a root vegetable"
                ($global:MyVegetables).where( { ($_.IsRoot) -And ($_.name -like $name) })
                # $global:MyVegetables | where {($_.IsRoot) -And ($_.name -like $name)}
            }
            elseif ($Name) {
                Write-Verbose "[PROCESS] Getting vegetable $name"
                $result = ($global:MyVegetables).where( { $_.name -like $name })
                if ($result) {
                    $result
                }
                else {
                    Throw "Can't find a vegetable with the name $Name"
                }
            }
            elseif ($RootOnly) {
                Write-Verbose "[PROCESS] Getting root vegetables only"
                ($global:MyVegetables).where( { $_.IsRoot })
            }
            else {
                Write-Verbose "[PROCESS] Getting all vegetables"
                $global:MyVegetables
            }
        } #if MyVegetables
        else {
            Write-Warning "Failed to find vegetable source."
        }
    } #Process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
