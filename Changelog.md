# Change Log for PSTeachingTools

## [Unreleased]

## [4.3.0] - 2024-09-03

### Added

- Added a table view of vegetable objects called `Color`. This uses a new global variable called `AnsiVegColor`.
- Added an alias `State` for the `CookedState` property on vegetable objects.

### Changed

- Update vegetable JSON file to use proper casing for vegetable names.
- General code cleanup
- Modified root module to use the cooked state from the JSON data file on module import. This is technically a breaking change, but since it happens on module import, this shouldn't affect the end-user. The underlying class definition was not changed. [Issue #12](https://github.com/jdhitsolutions/PSTeachingTools/issues/12)
- Updated `README.md`.
- Help updates.

### Fixed

- Fixed broken online help links.

## [v4.2.0] - 2022-01-11

+ Reorganized the module separating functions out to separate files.
+ Updated `Set-Vegetable` to fix bugs parsing input. [Issue #11](https://github.com/jdhitsolutions/PSTeachingTools/issues/11)

## [v4.1.0] - 2022-01-03

+ Updated `Start-TypedDemo` to allow the use of live commands. This is an *experimental* feature.
+ Updated `Start-TypedDemo` to simulate PSReadLine coloring using AST processing
+ Updated `Start-TypedDemo` to better simulate new lines.
+ Updated `Start-TypedDemo` to better distinguish `::` as a multi-line indicator instead of the static member operator.
+ Fixed argument completer for vegetable commands to wrap items with spaces in quotes. [Issue #10](https://github.com/jdhitsolutions/PSTeachingTools/issues/10)
+ Created a `samples` folder.
+ Finally resolved case of the `docs` folder.

## [v4.0.0] - 2021-01-05

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

## [v3.2.1] - 2020-05-16

+ Modified module with additional verbose output to aid in troubleshooting command failures.
+ Moved vegetable creation from `vegetables.ps1` to the module file.
+ Explicitly defining `$vegetableplu` as a global variable and removing `Export-ModuleMember`.

## [v3.2.0] - 2020-04-13

+ Modified `Start-TypedDemo` to record commands in the `PSReadLine` History file, command history, and history buffer.
+ Modified `Start-TypedDemo` to create a custom transcript file.
+ Fixed bug in module file that was preventing aliases from being exported.
+ Updated `sampledemo.txt`.
+ Updated help for `Start-TypedDemo`.

## [v3.1.0] - 2020-04-02

+ Updated `Start-TypedDemo` to reflect Windows PowerShell 5.1 or PowerShell 7 sessions.
+ Modified `Start-TypedDemo` to use a fully-qualified command name for `Write-Host`.
+ Updated module to export the enumerations and class definition.
+ Help updates.
+ Added an `about` help topic file (Issue #2)
+ Updated `sampledemo.txt`.
+ Updated `License`.

## [v3.0.0] - 2019-02-21

+ Updated `vegetables.ps1` with cleaner code to generate a collection of vegetables from a JSON file with legitimate PLU codes.
+ Updated copyright year in `License.txt`.
+ Modified `New-Vegetable` to support `-Whatif`.
+ Code reformatting in `vegetables.ps1`.
+ Modified class constructor to use a UPC code.
+ Modified the layout of `vegetables.format.ps1xml`.
+ Added a new table view called `statedir` to `vegetables.format.ps1xml`.
+ renamed `Docs` to `docs`.
+ Updates to help documentation.

## [v2.0.0] - 2018-10-23

+ File cleanup for the PowerShell Gallery.
+ moved alias definitions to respective functions.
+ Updated `README.md`.
+ Updated license.
+ Removed year from the fake header in `Start-TypedDemo`.
+ Removed typo feature from `Start-TypedDemo`.
+ Added sample demo script for `Start-TypedDemo`.
+ Updated manifest to support Desktop and Core.
+ Updated help documentation.

## [v1.1.0] - 2017-06-01

+ minor changes to vegetable creation.
+ Modified `Get-Vegetable` to accept pipeline input.
+ Modified `Set-Vegetable` to accept pipeline input.
+ Updated help.

## [v1.0.1] - 2017-05-25

+ updated `README.md`.

## v1.0.0 - 2017-05-25

+ initial release to PowerShell Gallery.

## v0.0.6 - 2017-05-25

+ modified ps1xml code to use Join-Path
+ updated manifest

## v0.0.5 - 2017-05-16

+ updated manifest changes
+ updated UPC range to 4000-5000
+ Added `Start-TypedDemo` function and alias
+ updated help

## v0.0.4 - 2016-08-01

+ modified `New-Vegetable` parameters to accept value by property name
+ updated help documents
+ updated module zip file

## v0.0.3 - 2016-08-01

+ updated manifest with GitHub links
+ Created PowerShell module zip file

## v0.0.2 - 2016-08-01

+ added vegetable markdown help
+ created XML help for vegetable commands
+ added aliases for vegetable commands

## v0.0.1 - 2016-08-01

+ initial version with Vegetable commands
+ new module manifest
+ new README.md

[Unreleased]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v4.3.0..HEAD
[4.3.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/vv4.2.0..v4.3.0
[v4.2.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v4.1.0..v4.2.0
[v4.1.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v4.0.0..v4.1.0
[v4.0.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v3.2.1..v4.0.0
[v3.2.1]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v3.2.0..v3.2.1
[v3.2.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v3.1.0..v3.2.0
[v3.1.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v3.0.0..v3.1.0
[v3.0.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v2.0.0..v3.0.0
[v2.0.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v1.1.0..v2.0.0
[v1.1.0]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v1.0.1..v1.1.0
[v1.0.1]: https://github.com/jdhitsolutions/PSTeachingTools/compare/v1.0.0..v1.0.1