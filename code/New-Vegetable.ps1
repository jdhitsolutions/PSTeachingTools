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
