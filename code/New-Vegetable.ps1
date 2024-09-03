Function New-Vegetable {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none", "PSTeachingTools.PSVegetable")]
    [alias("nveg")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "What is the vegetable name?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(
            Position = 1,
            Mandatory,
            HelpMessage = "What is the vegetable color?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [PSTeachingTools.VegColor]$Color,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(1, 20)]
        [Int]$Count = 1,

        [Parameter(ValueFromPipelineByPropertyName)]
        [alias("IsRoot")]
        [Switch]$Root,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter a valid PLU code",
            ValueFromPipelineByPropertyName
        )]
        [Int]$UPC,

        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    }

    Process {
        if ($PSCmdlet.ShouldProcess($Name)) {
            Write-Verbose "[PROCESS] Creating [$UPC] $name Color: $color RootVegetable: $Root"
            $veggie = [PSTeachingTools.PSVegetable]::new($name, $Root, $color, $UPC)

            if ($veggie) {
                $veggie.count = $Count
                Write-Verbose "Adding to global list"
                $global:MyVegetables.Add($veggie)

                if ($PassThru) {
                    Write-Output $veggie
                }
            }
            else {
                Write-Warning "Oops. Something unexpected happened."
            }
        } #should process
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
