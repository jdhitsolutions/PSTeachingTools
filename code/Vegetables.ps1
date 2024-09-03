#create an argument completer for a subset of vegetable commands
$verbs = "Get","Set","Remove"
foreach ($verb in $verbs) {
    Register-ArgumentCompleter -CommandName "$verb-Vegetable" -ParameterName Name -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #PowerShell code to populate $wordToComplete
        $global:MyVegetables.name | Where-Object { $_ -Like "$WordToComplete*" } |
        ForEach-Object {
            #wrap items with spaces in quotes [Issue #10]
            if ($_ -match "\s") {
                $complete = "'$_'"
            }
            else {
                $complete = $_
            }
            # completion text,listItem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($complete, $complete, 'ParameterValue', $complete)
        }
    }
}

#Add object property aliases

Update-TypeData -TypeName PSTeachingTools.PSVegetable -MemberType AliasProperty -MemberName "State" -Value "CookedState" -Force
