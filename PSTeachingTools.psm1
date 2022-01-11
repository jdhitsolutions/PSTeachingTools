if ($myinvocation.line -match "-verbose") {
    $saved = $VerbosePreference
    $VerbosePreference = "continue"
}

#dot source teaching commands and tools
Write-Verbose "loading vegatables.ps1"
Get-Childitem -path $PSScriptRoot\code\*Vegetable*.ps1 |
ForEach-Object {
    . $_.fullname
}


#create a global variable with PLU data
Write-Verbose "Creating `$vegetableplu"

$pluPath = Join-Path "$PSScriptRoot\Code" -ChildPath plu.csv
if (Test-Path -path $pluPath ) {
    $global:vegetableplu = Import-Csv -path $pluPath
}
else {
    Write-Warning "PSTeachingTools: Failed to find $pluPath"
}

#region create some vegetable objects and store them in a global list
Write-Verbose "Defining `$myvegetables"
$global:myvegetables = [System.Collections.Generic.list[PSTeachingTools.PSVegetable]]::new()

$rawPath = Join-Path -path "$PSScriptRoot\Code" -ChildPath rawveggies.json
if (Test-Path -path $rawPath) {
    Write-Verbose "Converting vegetable data from $Rawpath"
    $raw = Get-Content -Path $rawpath | ConvertFrom-Json
    $raw | New-Vegetable
<#     Write-Verbose "Updating vegetables"
    foreach ($item in $global:myvegetables) {
        $raw.where({$_.upc -eq $item.upc}) | Set-Vegetable
    }
 #>
}
else {
    Write-Warning "Failed to find $rawpath"
}
#endregion

Write-Verbose "loading Start-TypedDemo.ps1"
. $PSScriptRoot\Code\Start-TypedDemo.ps1

#reset verbose preference
$VerbosePreference = $saved