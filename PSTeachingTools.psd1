
@{

    RootModule           = 'PSTeachingTools.psm1'
    ModuleVersion        = '4.2.0'
    CompatiblePSEditions = "Desktop", "Core"
    GUID                 = '782b8a85-3c54-4586-96e8-b477781505a3'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2016-2022 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of commands and tools for teaching PowerShell.'
    PowerShellVersion    = '5.1'
    FormatsToProcess     = @("formats\vegetable.format.ps1xml")
    FunctionsToExport    = 'Get-Vegetable', 'New-Vegetable', 'Set-Vegetable', , 'Remove-Vegetable', 'Start-TypedDemo'
    VariablesToExport    = 'vegetableplu', 'myvegetables'
    AliasesToExport      = 'gveg', 'sveg', 'nveg', 'rveg', 'std'
    PrivateData          = @{
        PSData = @{
            Tags         = 'training', 'teaching', 'tutorial', 'demo'
            LicenseUri   = 'https://github.com/jdhitsolutions/PSTeachingTools/blob/master/LICENSE.txt'
            ProjectUri   = 'https://github.com/jdhitsolutions/PSTeachingTools'
            # IconUri = ''
            ReleaseNotes = 'https://github.com/jdhitsolutions/PSTeachingTools/blob/master/Changelog.md'

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}

