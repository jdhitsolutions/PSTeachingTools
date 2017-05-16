---
external help file: PSTeachingTools-help.xml
online version: 
schema: 2.0.0
---

# Start-TypedDemo

## SYNOPSIS
Simulate a PowerShell session

## SYNTAX

### Random (Default)
```
Start-TypedDemo [-File] <String> [-RandomMinimum <Int32>] [-RandomMaximum <Int32>] [-IncludeTypo]
 [-Transcript <String>] [-NoExecute] [-NewSession]
```

### Static
```
Start-TypedDemo [-File] <String> [-Pause <Int32>] [-Transcript <String>] [-NoExecute] [-NewSession]
```

## DESCRIPTION
This command simulates an interactive PowerShell session. It will process a text file of PowerShell commands. The function will insert your prompt and "type" out each command when you press any key. At the end of the typed command or whenever a pipe character is inserted, the script will pause. Press Enter or any key to continue. If it is the end of the command pressing Enter will execute the command. 

Use the -NoExecute parameter to run through the demo without executing any commands.

Commented lines will be skipped.

Press 'q' or ESC at any pause to quit the demo.

This function will NOT run properly in the PowerShell ISE.

VARIABLE NAMES
Do not use any variables in your script file that are also used in this script. These are the variables you most likely need to avoid:

 $file
 $i
 $running
 $key
 $command
 $count

MULITLINE COMMANDS
To use a multiline command, in your demo file, put a :: before the first line and :: after the last line:

...
Get-Date
::
get-wmiobject win32_logicaldisk -filter "Drivetype=3" | 
Select Caption,VolumeName,Size,Freespace | 
format-table -autosize
::
Get-Process
...

The function will simulate a nested prompt. Press any key after the last \>\> to execute. Avoid using the line continuation character in your demo file.

TIMING
By default the function will insert a random pause interval between characters. This is a random value in milliseconds between the -RandomMinimum and -RandomMaximum parameters which have default values of 50 and 140 respectively. If you want a static or consisent interval, then use the -Pause parameter. The recommended value is 80.

TYPOS
The -IncludeTypo parameter will introduce a typo at random intervals, then backspace over it and insert the correct text. You should not use this parameter with the -Transcript parameter. The transcript will have control characters for every backspace. It is not recommended to use -IncludeTypo when running any sort of transcript.

SCOPE
All the commands in your demo script are executed in the context of the Start-TypedDemo function. This means you have to be very aware of scope. While you can access items in the global scope like PSDrives, anything you create in the demo script will not persist.

This also means that none of the commands in your demo script will show up in PowerShell history.

COMMENTS
Any line that begins with # will be treated as a comment and skipped. If you have a multi-line comment you will need to put a # at the begininng of each line. You can't use PowerShell's block comment characters.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Start-TypedDemo c:\work\demo.txt
```

Run the commands in c:\work\demo.txt using the random defaults

### -------------------------- EXAMPLE 2 --------------------------
```
Start-TypedDemo c:\work\demo.txt -pause 100 -NoExecute
```

Run the commands in c:\work\demo.txt using a static interval of 100 milliseconds.
The function will only type the commands. They will not be executed.

### -------------------------- EXAMPLE 3 --------------------------
```
Start-TypedDemo c:\work\demo.txt -transcript c:\work\demotrans.txt
```

Run the commands in c:\work\demo.txt using the random defaults and create a transcript file.

## PARAMETERS

### -File
The file name of PowerShell commands to execute

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pause
The typing speed interval between characters in milliseconds. The recommended value is 100.

```yaml
Type: Int32
Parameter Sets: Static
Aliases: 

Required: False
Position: Named
Default value: 80
Accept pipeline input: False
Accept wildcard characters: False
```

### -RandomMinimum
The minimum time interval between characters in milliseconds. The default is 50.

```yaml
Type: Int32
Parameter Sets: Random
Aliases: 

Required: False
Position: Named
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -RandomMaximum
The maximum time interval between characters in milliseconds. The default is 140.

```yaml
Type: Int32
Parameter Sets: Random
Aliases: 

Required: False
Position: Named
Default value: 140
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTypo
When specified, the function will simulate typing mistakes. It is not recommended to use this parameter with -Transcript.

```yaml
Type: SwitchParameter
Parameter Sets: Random
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Transcript
The file name and path for a transcript session file. Existing files will be overwritten. It is not recommended to use this parameter with -IncludeTypo.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoExecute
Do not execute any of the commands.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewSession
Simulate a new PowerShell session with the copyright header and a prompt. This works best if you start your demo from the C: drive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### None. This only writes to the host console, not the pipeline.

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Write-Host]() 
[Invoke-Command]()

