#. $PSScriptRoot\vegetable-class.ps1

#create an argument completer for a subset of vegetable commands
$verbs = "Get","Set","Remove"
foreach ($verb in $verbs) {
    Register-ArgumentCompleter -CommandName "$verb-Vegetable" -ParameterName Name -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #PowerShell code to populate $wordtoComplete
        $global:myvegetables.name | Where-Object { $_ -Like "$WordToComplete*" } |
        ForEach-Object {
            #wrap items with spaces in quotes [Issue #10]
            if ($_ -match "\s") {
                $complete = "'$_'"
            }
            else {
                $complete = $_
            }
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($complete, $complete, 'ParameterValue', $complete)
        }
    }
}
