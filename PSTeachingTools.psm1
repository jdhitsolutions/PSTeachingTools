
#dot source teaching commands and tools
. $PSScriptRoot\Vegetables.ps1
. $PSScriptRoot\Start-TypedDemo.ps1

#create a global variable with PLU data
$vegetableplu = Import-CSV $PSScriptRoot\plu.csv

Export-ModuleMember -Variable vegetableplu -Alias *