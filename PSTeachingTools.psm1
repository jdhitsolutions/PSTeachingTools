if ($myinvocation.line -match "-verbose") {
    $VerbosePreference = "continue"
}

#dot source teaching commands and tools
Write-Verbose "loading vegatables.ps1"
. $PSScriptRoot\Vegetables.ps1

#create a global variable with PLU data
Write-Verbose "Creating `$vegatableplu"

$pluPath = Join-Path $PSScriptRoot -ChildPath plu.csv
if (Test-Path -path $pluPath ) {
    $global:vegetableplu = Import-Csv -path $pluPath
}
else {
    Write-Warning "Failed to find $pluPath"
}

#region create some vegetable objects and store them in a global array
Write-Verbose "Defining `$myvegetables"
$global:myvegetables = @()

$rawPath = Join-Path -path $PSScriptRoot -ChildPath .\rawveggies.json
if (Test-Path -path $rawPath) {
    Write-Verbose "Converting vegetable data from $Rawpath"
    $raw = Get-Content -Path $rawpath | ConvertFrom-Json
    $raw | New-Vegetable
    Write-Verbose "Updating vegetables"
    foreach ($item in $global:myvegetables) {
        $raw.where( {$_.upc -eq $item.upc}) | Set-Vegetable
    }
}
else {
    Write-Warning "Failed to find $rawpath"
}
#endregion

Write-Verbose "loading Start-TypedDemo.ps1"
. $PSScriptRoot\Start-TypedDemo.ps1

#reset verbose preference
$VerbosePreference = "SilentlyContinue"