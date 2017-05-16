#requires -version 5.0

#dot source teaching commands and tools
. $PSScriptRoot\Vegetables.ps1
. $PSScriptRoot\Start-TypedDemo.ps1

#define aliases
Set-Alias -Name gveg -Value Get-Vegetable
Set-Alias -Name sveg -Value Set-Vegetable
Set-Alias -Name nveg -Value New-Vegetable
Set-Alias -Name std -Value Start-TypedDemo
