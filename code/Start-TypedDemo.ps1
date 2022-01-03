#requires -modules @{ModuleName='PSReadline';ModuleVersion='2.0.0'}

Function Start-TypedDemo {
    [cmdletBinding(DefaultParameterSetName = "Random")]
    [Alias("std")]

    Param(
        [Parameter(Position = 0, Mandatory = $True, HelpMessage = "Enter the name of a text file with your demo commands")]
        [ValidateScript( { Test-Path $_ })]
        [string]$File,
        [ValidateScript( {$_ -gt 0 })]
        [Parameter(Mandatory,ParameterSetName = "Static")]
        [int]$Pause,
        [Parameter(ParameterSetName = "Random")]
        [ValidateScript( { $_ -gt 0 })]
        [int]$RandomMinimum = 50,
        [Parameter(ParameterSetName = "Random")]
        [ValidateScript( { $_ -gt 0 })]
        [int]$RandomMaximum = 110,
        [Parameter(ParameterSetName = "Random")]
        [parameter(HelpMessage = "Enter the path for a transcript file")]
        [ValidateNotNullOrEmpty()]
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

    Function EnterCommand {
        [cmdletbinding()]
        Param()
        $typing = $true
        #keep looping until a key is pressed
        $list = [System.Collections.Generic.list[object]]::new()
        do {
            if ($host.ui.RawUi.KeyAvailable) {
                $key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                if ($key.VirtualKeyCode -eq 13) {
                    $typing = $False
                } #if return
                else {
                    Microsoft.PowerShell.Utility\Write-Host $key.Character -NoNewline
                    $list.add($key.character)
                }
            } #if key available
           # Start-Sleep -millisecond 10
        } while ($typing) #end do

        $cmd = $list -join ""
        $sb = [scriptblock]::create($cmd)
        $start = Get-Date
        Invoke-Command -ScriptBlock $sb -OutVariable result | Out-Host
        $end = Get-Date
        if ($RunningTranscript) {
            "$(prompt)$Cmd" | Out-File -FilePath $Transcript -Encoding ascii -ErrorAction Stop -Append
            $result | Out-File -FilePath $Transcript -Encoding ascii -ErrorAction Stop -Append
        }
        #add to PSReadlineHistory
        [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($cmd)

        $h = @{
            PSTypeName         = "Microsoft.PowerShell.Commands.HistoryInfo"
            CommandLine        = $cmd
            StartExecutionTime = $start
        }

        [datetime]$end = [datetime]::now
        $h.Add("EndExecutionTime", $end)
        $h.Add("ExecutionStatus", "Completed")
        if ($psversiontable.psversion.major -eq 7) {
            $h.add("Duration", (New-TimeSpan -Start $start -End $End))
        }
        [pscustomobject]$h | Add-History

    } #enterCommand function

    Function WriteWord {
        [cmdletbinding()]
        Param([string]$command)

        Write-Debug $command
        Function writechar {
            [cmdletbinding()]
            Param([string]$word, [string]$color)

            for ($i = 0; $i -lt $word.length; $i++) {

                #write the character
                Write-Verbose "Writing character $($word[$i])"
                Microsoft.PowerShell.Utility\Write-Host $word[$i] -NoNewline -ForegroundColor $color

                #insert a pause to simulate typing
                if ($Pause) {
                    $rest = $pause
                }
                else {
                    $rest = Get-Random -Minimum $RandomMinimum -Maximum $RandomMaximum
                }
                Start-Sleep -Milliseconds $rest

                if ($word -eq "|") {
                    If ((PauseIt) -eq "quit") { Return }
                }

            } #for
            #Write-Host " " -NoNewline
        } #writechar

        $sb = [scriptblock]::Create($command)
        New-Variable astTokens -Force
        New-Variable astErr -Force

        $ast = [System.Management.Automation.Language.Parser]::ParseInput($sb, [ref]$astTokens, [ref]$astErr)

        $run = $False
        foreach ($item in $asttokens) {
            #insert spaces
            if ($Run -AND ($item.Extent.StartOffset -gt $last)) {
                Microsoft.PowerShell.Utility\Write-Host " " -NoNewline
            }
            if ($item.kind -eq 'NewLine') {
                If ((PauseIt) -eq "quit") { Return }
                Microsoft.PowerShell.Utility\Write-Host ""
                Microsoft.PowerShell.Utility\Write-Host ">>" -NoNewline
                $Inmulti = $True
            }
            else {
                if ($item.TokenFlags -match "Operator") {
                    $color = "darkgray"
                }
                Else {
                    switch -regex ($item.Kind) {
                        "Generic" { $color = "Yellow" }
                        "Variable" { $color = "green" }
                        "String" { $color = "darkcyan" }
                        "Parameter" { $color = "darkgray" }
                        default { $color = "white" }
                    }
                }
              writechar -word $item.text -color $color
                $run = $True
                $last = $item.Extent.EndOffset
            } #not a new line
        }

        If ($Inmulti) {
            Microsoft.PowerShell.Utility\Write-Host ""
        }

    } #WriteWord function

    #abort if NOT running in the console host
    if ($host.name -ne "ConsoleHost") {
        Write-Warning "This command will only work in Windows PowerShell or PowerShell 7.x console host."
        Return
    }

    Clear-Host

    if ($NewSession) {
        #simulate a new PowerShell session
        #define a set of coordinates
        $z = New-Object System.Management.Automation.Host.Coordinates 0, 0

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
            $startTranscript | Out-File -FilePath $Transcript -Encoding ascii -ErrorAction Stop
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

    $commands = Get-Content -Path $file | Where-Object { $_ -notmatch "^#|(Return)" -AND $_ -match "\w|::|{|}|\(|\)" }

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
            If ((PauseIt) -eq "quit") { Return }
        }
    } #end PipeCheck scriptblock

    Write-Verbose "Processing commands"
    foreach ($command in $commands) {
        #trim off any spaces
        $command = $command.Trim()
        Write-Debug "processing: $command"
        $count++
        #pause until a key is pressed which will then process the next command
        if ($NoMultiLine) {
            If ((PauseIt) -eq "quit") { Return }
        }
        if ($command -eq "<live>") {
            Write-Debug "going live"
            if ($NoExecute) {
                "# Insert live PowerShell here"
            }
            else {
                entercommand
            }
        }
        #SINGLE LINE COMMAND
        elseif ($command -notmatch "^::" -AND $NoMultiLine) {
            Write-Debug "single line command: $command"

            WriteWord $command

            #remove the backtick line continuation character if found
            if ($command.contains('`')) {
                $command = $command.Replace('`', "")
            }

            #Pause until ready to run the command
            If ((PauseIt) -eq "quit") { Return }
            Microsoft.PowerShell.Utility\Write-Host "`r" # "`n"
            #execute the command unless -NoExecute was specified
            if ($RunningTranscript) {
                "$(prompt)$Command" | Out-File -FilePath $Transcript -Encoding ascii -ErrorAction Stop -Append
            }
            if (-NOT $NoExecute) {
                [datetime]$start = [datetime]::now
                $h = @{
                    PSTypeName         = "Microsoft.PowerShell.Commands.HistoryInfo"
                    CommandLine        = $Command
                    StartExecutionTime = $start
                }

                Invoke-Expression $command -OutVariable rex | Out-Default
                #  Invoke-Command -ScriptBlock ([scriptblock]::Create($command)) -NoNewScope -OutVariable rex | Out-Default
                if ($RunningTranscript) {
                    $rex | Out-File -FilePath $Transcript -Encoding ascii -Append -ErrorAction stop
                }

                #Add to PSReadline History
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($command)

                #Add to command history
                [datetime]$end = [datetime]::now
                $h.Add("EndExecutionTime", $end)
                $h.Add("ExecutionStatus", "Completed")
                if ($psversiontable.psversion.major -eq 7) {
                    $h.add("Duration", (New-TimeSpan -Start $start -End $End))
                }
                [pscustomobject]$h | Add-History
            }
            else {
                Microsoft.PowerShell.Utility\Write-Host $command -ForegroundColor Cyan
            }
        } #IF SINGLE COMMAND
        #START MULTILINE
        #skip the ::
        elseif ($command -match "^::" -AND $NoMultiLine) {
            $NoMultiLine = $False
            $StartMulti = $True
            Write-Debug "initializing `$multi"
            #define a variable to hold the multiline expression
            [string]$multi = @'

'@
        } #elseif
        #FIRST LINE OF MULTILINE
        elseif ($StartMulti) {

            <#
            $command.split() | ForEach-Object { WriteWord $_ }
            Start-Sleep -Milliseconds $(&$Interval)
            #only check for a pipe if we're not at the last character
            #because we're going to pause anyway
            if ($i -lt $command.length - 1) {
                &$PipeCheck
            }
            #>
            <#
            for ($i = 0; $i -lt $command.length; $i++) {

                else {
                   # Microsoft.PowerShell.Utility\Write-Host $command[$i] -NoNewline
                  write-host ""
                } #else
                Start-Sleep -Milliseconds $(&$Interval)
                #only check for a pipe if we're not at the last character
                #because we're going to pause anyway
                if ($i -lt $command.length - 1) {
                    &$PipeCheck
                }
            } #for #>

            $StartMulti = $False

            #remove the backtick line continuation character if found
          #  if ($command.contains('`')) {
          #      $command = $command.Replace('`', "")
          #  }
            #add the command to the multiline variable
            Write-Debug "Adding $command to `$multi"
            $multi += "$command`r"
            #     if (!$command.Endswith('{')) { $multi += ";" }
            #  if ($command -notmatch ",$|{$|}$|\|$|\($") { $multi += " ; " }
            If ((PauseIt) -eq "quit") { Return }

        } #elseif
        elseif (!$NoMultiline) {
            #add next line
            if ($command -match "^::") {
                Write-Debug "ending multiline"
                WriteWord $multi
                $NoMultiLine = $True

                $cmd = $multi # $(($multi -replace ';(\s=?)$', '').trim())
                Write-Debug "cmd = $cmd"
                #Microsoft.PowerShell.Utility\Write-Host "`r"

            if ($RunningTranscript) {
                "$(prompt)$cmd" | Out-File -path $Transcript -Encoding ascii -ErrorAction Stop -Append
            }
            if (-NOT $NoExecute) {
                [datetime]$start = [datetime]::now
                $h = @{
                    CommandLine        = $cmd
                    StartExecutionTime = $start
                }
                Invoke-Expression $cmd -OutVariable rex | Out-Default
                #Invoke-Command -ScriptBlock ([scriptblock]::Create($cmd)) -NoNewScope -OutVariable rex | Out-Default

                if ($RunningTranscript) {
                    $rex | Out-File -FilePath $Transcript -Encoding ascii -Append -ErrorAction stop
                }
                #Add clean command to PSReadline History
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($cmd)

                #Add to command history
                [datetime]$end = [datetime]::now
                $h.Add("EndExecutionTime", $end)
                $h.Add("ExecutionStatus", "Completed")
                if ($psversiontable.psversion.major -eq 7) {
                    $h.add("Duration", (New-TimeSpan -Start $start -End $end))
                }
                [pscustomobject]$h | Add-History
            }
            else {
                Microsoft.PowerShell.Utility\Write-Host $cmd -ForegroundColor Cyan
            }
            }
            else {
                Write-Debug "Adding $command to `$multi"
                $multi += "$command`r"
            }
        }
        #END OF MULTILINE
        elseif ($command -match "^::" -AND !$NoMultiLine) {
            #TODO This might be deleted
            #  Microsoft.PowerShell.Utility\Write-Host "`r"
            #  Microsoft.PowerShell.Utility\Write-Host ">> " -NoNewline
            Write-Debug "show multiline"
            WriteWord $multi

            $NoMultiLine = $True

            Write-Warning "execute multi"
            #If ((PauseIt) -eq "quit") { Return }
            #execute the command unless -NoExecute was specified
            Microsoft.PowerShell.Utility\Write-Host "`r"
            $cmd = $multi # $(($multi -replace ';(\s=?)$', '').trim())
            Write-Warning "cmd = $cmd"
            if ($RunningTranscript) {
                "$(prompt)$cmd" | Out-File -path $Transcript -Encoding ascii -ErrorAction Stop -Append
            }
            if (-NOT $NoExecute) {
                [datetime]$start = [datetime]::now
                $h = @{
                    CommandLine        = $cmd
                    StartExecutionTime = $start
                }
                Invoke-Expression $cmd -OutVariable rex | Out-Default
                #Invoke-Command -ScriptBlock ([scriptblock]::Create($cmd)) -NoNewScope -OutVariable rex | Out-Default

                if ($RunningTranscript) {
                    $rex | Out-File -FilePath $Transcript -Encoding ascii -Append -ErrorAction stop
                }
                #Add clean command to PSReadline History
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($cmd)

                #Add to command history
                [datetime]$end = [datetime]::now
                $h.Add("EndExecutionTime", $end)
                $h.Add("ExecutionStatus", "Completed")
                if ($psversiontable.psversion.major -eq 7) {
                    $h.add("Duration", (New-TimeSpan -Start $start -End $end))
                }
                [pscustomobject]$h | Add-History
            }
            else {
                Microsoft.PowerShell.Utility\Write-Host $cmd -ForegroundColor Cyan
            }
        }  #elseif end of multiline
        #NESTED PROMPTS
        else {
            #TODO I think this can be deleted
            Write-Debug "in nested prompts"
            Microsoft.PowerShell.Utility\Write-Host "`r"
            Microsoft.PowerShell.Utility\Write-Host ">> " -NoNewline
            If ((PauseIt) -eq "quit") { Return }
            $command.split() | ForEach-Object { WriteWord $_ }
            Start-Sleep -Milliseconds $(&$Interval)
            &$PipeCheck
            <#
            for ($i = 0; $i -lt $command.length; $i++) {
                else {
#                Microsoft.PowerShell.Utility\Write-Host $command[$i] -NoNewline
                }
                Start-Sleep -Milliseconds $(&$Interval)
                  &$PipeCheck
            } #for #>

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
            Write-Debug "prompt"
            Microsoft.PowerShell.Utility\Write-Host $(prompt) -NoNewline
        }

    } #foreach command

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
        $stopTranscript | Out-File -path $Transcript -Encoding ascii -ErrorAction Stop -Append
    }
Write-Debug "end"
} #function



