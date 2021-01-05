
<#
code used to generate the XML format file
This script file is not an published part of the module
#>

#formatting directives for the custom object
[xml]$format = @"
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
    <ViewDefinitions>
        <View>
            <Name>default</Name>
            <ViewSelectedBy>
                <TypeName>PSTeachingTools.PSVegetable</TypeName>
            </ViewSelectedBy>
            <TableControl>
            <!-- ################ TABLE DEFINITIONS ################ -->
                <TableHeaders>
                    <TableColumnHeader>
                        <Label>UPC</Label>
                        <Width>5</Width>
                        <Alignment>left</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>Count</Label>
                        <Width>7</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>Name</Label>
                        <Width>13</Width>
                        <Alignment>left</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>State</Label>
                        <Width>8</Width>
                        <Alignment>left</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>Color</Label>
                        <Width>10</Width>
                        <Alignment>left</Alignment>
                    </TableColumnHeader>
                 </TableHeaders>
                <TableRowEntries>
                    <TableRowEntry>
                        <TableColumnItems>
                            <TableColumnItem>
                                <PropertyName>UPC</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Count</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Name</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>CookedState</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Color</PropertyName>
                            </TableColumnItem>
                        </TableColumnItems>
                    </TableRowEntry>
                </TableRowEntries>
            </TableControl>
        </View>
    </ViewDefinitions>
</Configuration>
"@

#use Join-Path to avoid problems with open source platforms
$outfile = Join-Path -path $PSScriptRoot -childpath vegetable.format.ps1xml
if (-Not (Test-Path -path $outFile)) {
    $format.Save($outFile)
}

Update-FormatData -AppendPath $outfile
