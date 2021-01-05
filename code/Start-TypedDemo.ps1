#requires -modules @{ModuleName='PSReadline';ModuleVersion='2.0.0'}

Function Start-TypedDemo {
    [cmdletBinding(DefaultParameterSetName = "Random")]
    [Alias("std")]

    Param(
        [Parameter(Position = 0, Mandatory = $True, HelpMessage = "Enter the name of a text file with your demo commands")]
        [ValidateScript({Test-Path $_})]
        [string]$File,
        [ValidateScript( {$_ -gt 0})]
        [Parameter(ParameterSetName = "Static")]
        [int]$Pause = 80,
        [Parameter(ParameterSetName = "Random")]
        [ValidateScript( {$_ -gt 0})]
        [int]$RandomMinimum = 50,
        [Parameter(ParameterSetName = "Random")]
        [ValidateScript( {$_ -gt 0})]
        [int]$RandomMaximum = 140,
        [Parameter(ParameterSetName = "Random")]
        [string]$Transcript,
        [switch]$NoExecute,
        [switch]$NewSession
    )

    #this is an internal function so I'm not worried about the name
    Function PauseIt {
        [cmdletbinding()]
        Param()
        Write-Verbose "PauseIt"

        #wait for a key press
        $Running = $true
        #keep looping until a key is pressed
        While ($Running) {
            if ($host.ui.RawUi.KeyAvailable) {
                $key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                if ($key) {
                    $Running = $False
                    #check the value and if it is q or ESC, then bail out
                    if ($key -match "q|27") {
                        Microsoft.PowerShell.Utility\Write-Host "`r"
                        Return "quit"
                    } #if match q|27
                } #if $key
            } #if key available
            Start-Sleep -millisecond 100
        } #end While
    } #PauseIt function

    #abort if running in the ISE
    if ($host.name -match "PowerShell ISE") {
        Write-Warning "This will not work in the ISE. Use the PowerShell console host."
        Return
    }

    Clear-Host

    if ($NewSession) {
        #simulate a new PowerShell session
        #define a set of coordinates
        $z = new-object System.Management.Automation.Host.Coordinates 0, 0

        #get a header based on what version you are using.
        Switch -Regex ($PSVersionTable.PSVersion.toString()) {
            "^5.1" {
$header = @"
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Try the new cross-platform PowerShell https://aka.ms/pscore6

"@
            } #5.1
           "^7\." {
$header = @"
PowerShell $($psversiontable.psversion.tostring())
Copyright (c) Microsoft Corporation. All rights reserved.

https://aka.ms/powershell
Type 'help' to get help.

"@
            } #7.0
            Default {
                Write-Warning "This function only supports Windows PowerShell 5.1 or PowerShell 7."
                #abort the command
                return
            }
        } #switch

        Microsoft.PowerShell.Utility\Write-Host $header
    } #if new session

    if ($Transcript) {
        Try {
            $RunningTranscript = $True
            $startTranscript = @"

*******************************
PowerShell transcript start
Start time: $(Get-Date)
*******************************

"@
            $startTranscript | Out-File -filepath $Transcript -Encoding ascii -erroraction Stop
        }
        Catch {
            Write-Warning "Could not start a transcript. One may already be running."
        }
    }
    else {
        $RunningTranscript = $False
    }
    #strip out all comments and blank lines
    Write-Verbose "Getting commands from $file"

    $commands = Get-Content -Path $file | Where-Object {$_ -notmatch "#" -AND $_ -match "\w|::|{|}|\(|\)"}

    $count = 0

    #write a prompt using your current prompt function
    Write-Verbose "prompt"
    Microsoft.PowerShell.Utility\Write-Host $(prompt) -NoNewline

    $NoMultiLine = $True
    $StartMulti = $False

    #define a scriptblock to get typing interval
    Write-Verbose "Defining interval scriptblock"
    $interval = {
        if ($pscmdlet.ParameterSetName -eq "Random") {
            #get a random pause interval
            Get-Random -Minimum $RandomMinimum -Maximum $RandomMaximum
        }
        else {
            #use the static pause value
            $Pause
        }
    } #end Interval scriptblock

    Write-Verbose "Defining PipeCheck Scriptblock"
    #define a scriptblock to pause at a | character in case an explanation is needed
    $PipeCheck = {
        if ($command[$i] -eq "|") {
            If ((PauseIt) -eq "quit") {Return}
        }
    } #end PipeCheck scriptblock

    Write-Verbose "Processing commands"
    foreach ($command in $commands) {
        #trim off any spaces
        $command = $command.Trim()

        $count++
        #pause until a key is pressed which will then process the next command
        if ($NoMultiLine) {
            If ((PauseIt) -eq "quit") {Return}
        }

        #SINGLE LINE COMMAND
        if ($command -ne "::" -AND $NoMultiLine) {
            Write-Verbose "single line command"

            for ($i = 0; $i -lt $command.length; $i++) {

                #write the character
                Write-Verbose "Writing character $($command[$i])"
                Microsoft.PowerShell.Utility\Write-Host $command[$i] -NoNewline

                #insert a pause to simulate typing
                Start-Sleep -Milliseconds $(&$Interval)

                &$PipeCheck

            }

            #remove the backtick line continuation character if found
            if ($command.contains('`')) {
                $command = $command.Replace('`', "")
            }

            #Pause until ready to run the command
            If ((PauseIt) -eq "quit") {Return}
            Microsoft.PowerShell.Utility\Write-Host "`r"
            #execute the command unless -NoExecute was specified
            if ($RunningTranscript) {
              "$(prompt)$Command" | Out-File -filepath $Transcript -Encoding ascii -erroraction Stop -Append
            }
            if (-NOT $NoExecute) {
                [datetime]$start = [datetime]::now
                $h=@{
                    PSTypeName = "Microsoft.PowerShell.Commands.HistoryInfo"
                    CommandLine = $Command
                    StartExecutionTime = $start
                }

                Invoke-Expression $command -OutVariable r | Out-Default
                if ($RunningTranscript) {
                    $r | Out-File -filepath $Transcript -Encoding ascii -Append -ErrorAction stop
                }


                #Add to PSReadline History
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($command)

                #Add to command history
                [datetime]$end = [datetime]::now
                $h.Add("EndExecutionTime", $end)
                $h.Add("ExecutionStatus","Completed")
                if ($psversiontable.psversion.major -eq 7) {
                    $h.add("Duration",(New-Timespan -start $start -end $End))
                }
                [pscustomobject]$h | Add-History
            }
            else {
                Microsoft.PowerShell.Utility\Write-Host $command -ForegroundColor Cyan
            }
        } #IF SINGLE COMMAND
        #START MULTILINE
        #skip the ::
        elseif ($command -eq "::" -AND $NoMultiLine) {
            $NoMultiLine = $False
            $StartMulti = $True
            #define a variable to hold the multiline expression
            [string]$multi = ""
        } #elseif
        #FIRST LINE OF MULTILINE
        elseif ($StartMulti) {
            for ($i = 0; $i -lt $command.length; $i++) {
                if ($IncludeTypo -AND ($(&$Interval) -ge ($RandomMaximum - 5)))
                { &$Typo }
                else { Microsoft.PowerShell.Utility\Write-Host $command[$i] -NoNewline} #else
                Start-Sleep -Milliseconds $(&$Interval)
                #only check for a pipe if we're not at the last character
                #because we're going to pause anyway
                if ($i -lt $command.length - 1) {
                    &$PipeCheck
                }
            } #for

            $StartMulti = $False

            #remove the backtick line continuation character if found
            if ($command.contains('`')) {
                $command = $command.Replace('`', "")
            }
            #add the command to the multiline variable
            $multi += " $command"
            #     if (!$command.Endswith('{')) { $multi += ";" }
            if ($command -notmatch ",$|{$|}$|\|$|\($") { $multi += " ; " }
            If ((PauseIt) -eq "quit") {Return}

        } #elseif
        #END OF MULTILINE
        elseif ($command -eq "::" -AND !$NoMultiLine) {
            Microsoft.PowerShell.Utility\Write-Host "`r"
            Microsoft.PowerShell.Utility\Write-Host ">> " -NoNewline
            $NoMultiLine = $True
            If ((PauseIt) -eq "quit") {Return}
            #execute the command unless -NoExecute was specified
            Microsoft.PowerShell.Utility\Write-Host "`r"
            $cmd =  $(($multi -replace ';(\s=?)$','').trim())
            if ($RunningTranscript) {
                    "$(prompt)$cmd" | Out-File -path $Transcript -Encoding ascii -erroraction Stop -Append
            }
            if (-NOT $NoExecute) {
                [datetime]$start = [datetime]::now
                $h = @{
                    CommandLine        = $cmd
                    StartExecutionTime = $start
                }
                Invoke-Expression $cmd -OutVariable r | Out-Default

                if ($RunningTranscript) {
                    $r | Out-File -filepath $Transcript -Encoding ascii -append -erroraction stop
                }
                #Add clean command to PSReadline History
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($cmd)

                #Add to command history
                [datetime]$end = [datetime]::now
                $h.Add("EndExecutionTime", $end)
                $h.Add("ExecutionStatus", "Completed")
                if ($psversiontable.psversion.major -eq 7) {
                    $h.add("Duration",(New-Timespan -Start $start -end $end))
                }
                [pscustomobject]$h | Add-History
            }
            else {
                Microsoft.PowerShell.Utility\Write-Host $cmd -ForegroundColor Cyan
            }
        }  #elseif end of multiline
        #NESTED PROMPTS
        else {
            Microsoft.PowerShell.Utility\Write-Host "`r"
            Microsoft.PowerShell.Utility\Write-Host ">> " -NoNewLine
            If ((PauseIt) -eq "quit") {Return}
            for ($i = 0; $i -lt $command.length; $i++) {
                if ($IncludeTypo -AND ($(&$Interval) -ge ($RandomMaximum - 5)))
                { &$Typo  }
                else { Microsoft.PowerShell.Utility\Write-Host $command[$i] -NoNewline }
                Start-Sleep -Milliseconds $(&$Interval)
                &$PipeCheck
            } #for

            #remove the backtick line continuation character if found
            if ($command.contains('`')) {
                $command = $command.Replace('`', "")
            }
            #add the command to the multiline variable and include the line break
            #character
            $multi += " $command"
            #  if (!$command.Endswith('{')) { $multi += ";" }

            if ($command -notmatch ",$|{$|\|$|\($") {
                $multi += " ; "
                #$command
            }

        } #else nested prompts

        #reset the prompt unless we've just done the last command
        if (($count -lt $commands.count) -AND ($NoMultiLine)) {
            Microsoft.PowerShell.Utility\Write-Host $(prompt) -NoNewline
        }

    } #foreach

    #stop a transcript if it is running
    if ($RunningTranscript) {
        #stop this transcript if it is running
       # Stop-Transcript | Out-Null
        $stopTranscript = @"

*******************************
PowerShell transcript end
End time: $(Get-Date)
*******************************

"@
            $stopTranscript | Out-File -path $Transcript -Encoding ascii -erroraction Stop -Append
    }

} #function



