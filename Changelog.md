# Change Log for PSTeachingTools

## v4.0.0

+ Updated license.
+ Reorganized module layout.
+ Updated `Start-TypedDemo` to work with all versions of PowerShell 7.x.
+ Updated `assets\sampledemo.txt` demo script file.
+ Moved `vegetable` class to a C# class definition with a new namespace and name, `PSTeachingTools.PSVegetable`. Enumerations have also been re-defined as `PSTeachingTools.VegColor` and `PSTeachingTools.VegStatus`. All of these changes are to make the object class more PowerShell-like and discoverable. __BREAKING CHANGE__
+ Added `Remove-Vegetable` command.
+ Added argument completers for the `Name` parameter in `Get-Vegetable`, `Set-Vegetable`, and `Remove-Vegetable`.
+ Updated help documentation.
+ Updated `README.md`.
+ Added online help links.

## v3.2.1

+ Modified module with additional verbose output to aid in troubleshooting command failures.
+ Moved vegetable creation from `vegetables.ps1` to the module file.
+ Explicitly defining `$vegetableplu` as a global variable and removing `Export-ModuleMember`.

## v3.2.0

+ Modified `Start-TypedDemo` to record commands in the `PSReadline` History file, command history, and history buffer.
+ Modified `Start-TypedDemo` to create a custom transcript file.
+ Fixed bug in module file that was preventing aliases from being exported.
+ Updated `sampledemo.txt`.
+ Updated help for `Start-TypedDemo`.

## v3.1.0

+ Updated `Start-TypedDemo` to reflect Windows PowerShell 5.1 or PowerShell 7 sessions.
+ Modified `Start-TypedDemo` to use a fully-qualified command name for `Write-Host`.
+ Updated module to export the enumerations and class definition.
+ Help updates.
+ Added an `about` help topic file (Issue #2)
+ Updated `sampledemo.txt`.
+ Updated `License`.

## v3.0.0

+ Updated `vegetables.ps1` with cleaner code to generate a collection of vegetables from a JSON file with legitimate PLU codes.
+ Updated copyright year in `License.txt`.
+ Modified `New-Vegetable` to support `-Whatif`.
+ Code reformatting in `vegetables.ps1`.
+ Modified class constructor to use a UPC code.
+ Modified the layout of `vegetables.format.ps1xml`.
+ Added a new table view called `statedir` to `vegetables.format.ps1xml`.
+ renamed `Docs` to `docs`.
+ Updates to help documentation.

## v2.0.0

+ File cleanup for the PowerShell Gallery.
+ moved alias definitions to respective functions.
+ Updated `README.md`.
+ Updated license.
+ Removed year from the fake header in `Start-TypedDemo`.
+ Removed typo feature from `Start-TypedDemo`.
+ Added sample demo script for `Start-TypedDemo`.
+ Updated manifest to support Desktop and Core.
+ Updated help documentation.

## v1.1.0

+ minor changes to vegetable creation.
+ Modified `Get-Vegetable` to accept pipeline input.
+ Modified `Set-Vegetable` to accept pipeline input.
+ Updated help.

## v1.0.1

+ updated `README.md`.

## v1.0.0

+ initial release to PowerShell Gallery.

## v0.0.6

+ modified ps1xml code to use Join-Path
+ updated manifest

## v0.0.5

+ updated manifest changes
+ updated UPC range to 4000-5000
+ Added `Start-TypedDemo` function and alias
+ updated help

## v0.0.4

+ modified `New-Vegetable` parameters to accept value by property name
+ updated help documents
+ updated module zip file

## v0.0.3

+ updated manifest with GitHub links
+ Created PowerShell module zip file

## v0.0.2

+ added vegetable markdown help
+ created XML help for vegetable commands
+ added aliases for vegetable commands

## v0.0.1

+ initial version with Vegetable commands
+ new module manifest
+ new README.md
