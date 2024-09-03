if ($MyInvocation.Line -match '-verb') {
    $saved = $VerbosePreference
    $VerbosePreference = 'continue'
}

#dot source teaching commands and tools
Write-Verbose 'loading vegetables.ps1'
Get-ChildItem -Path $PSScriptRoot\code\*Vegetable*.ps1 |
ForEach-Object {
    . $_.FullName
}

#create a global variable with PLU data
Write-Verbose 'Creating $VegetablePLU'

$pluPath = Join-Path "$PSScriptRoot\Code" -ChildPath plu.csv
if (Test-Path -Path $pluPath ) {
    $global:VegetablePLU = Import-Csv -Path $pluPath
}
else {
    Write-Warning "PSTeachingTools: Failed to find $pluPath"
}

#region create some vegetable objects and store them in a global list
Write-Verbose "Defining `$MyVegetables"
$global:MyVegetables = [System.Collections.Generic.list[PSTeachingTools.PSVegetable]]::new()

$rawPath = Join-Path -Path "$PSScriptRoot\Code" -ChildPath rawveggies.json
if (Test-Path -Path $rawPath) {
    Write-Verbose "Converting vegetable data from $rawPath"
    $raw = Get-Content -Path $rawPath | ConvertFrom-Json
    #$raw | New-Vegetable
    #3 September 2024 - set the cooking state from the JSON file. Issue #12
    Foreach ($item in $raw) {
        $v = $item | New-Vegetable -Passthru
        $v.CookedState = $item.CookingState
    }

}
else {
    Write-Warning "Failed to find $rawPath"
}

#create a global hashtable of ANSI color codes used by the Color view
$global:AnsiVegColor = @{
    Yellow = "$([char]27)[93m"
    Red    = "$([char]27)[91m"
    Green  = "$([char]27)[92m"
    Purple = "$([char]27)[35m"
    Orange = "$([char]27)[38;5;220m"
    Brown = "$([char]27)[38;5;94m"
    White = "$([char]27)[97m"
}

#endregion

Write-Verbose 'loading Start-TypedDemo.ps1'
. $PSScriptRoot\Code\Start-TypedDemo.ps1

#reset verbose preference
$VerbosePreference = $saved