# module manifest for the PSTeachingTools module
@{
    RootModule           = 'PSTeachingTools.psm1'
    ModuleVersion        = '4.3.0'
    CompatiblePSEditions = "Desktop", "Core"
    GUID                 = '782b8a85-3c54-4586-96e8-b477781505a3'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2016-2024 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of commands and tools for teaching PowerShell. This module is used in my beginning PowerShell courses from Pluralsight.'
    PowerShellVersion    = '5.1'
    FormatsToProcess     = @("formats\vegetable.format.ps1xml")
    FunctionsToExport    = 'Get-Vegetable', 'New-Vegetable', 'Set-Vegetable', , 'Remove-Vegetable', 'Start-TypedDemo'
    VariablesToExport    = 'vegetableplu', 'MyVegetables'
    AliasesToExport      = 'gveg', 'sveg', 'nveg', 'rveg', 'std'
    PrivateData          = @{
        PSData = @{
            Tags         = 'training', 'teaching', 'tutorial', 'demo'
            LicenseUri   = 'https://github.com/jdhitsolutions/PSTeachingTools/blob/master/LICENSE.txt'
            ProjectUri   = 'https://github.com/jdhitsolutions/PSTeachingTools'
            ReleaseNotes = @"
## 4.3.0

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
"@

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}

