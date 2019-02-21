# PSTeachingTools

This PowerShell module includes tools and techniques for teaching PowerShell. Many of the commands will create a set of sample objects and commands that can be used to demonstrate a variety of PowerShell techniques and concepts without having to worry about anything technical like Active Directory, services or file objects.

![Using objects in the pipeline](./assets/get-vegetable.jpg)

![setting objects](./assets/set-vegetable.jpg)

You can install this module from the PowerShell Gallery:

```powershell
install-module psteachingtools
```
If installing on PowerShell core you may need to include the `-scope currentuser` parameter.

The module also includes a function for simulating an interactive PowerShell console session. You can type your commands in a file and have the function "play back" the commands just as if you were typing the commands. The function will pause after every | character. Pressing Enter will advance the demo. Read help for [Start-TypedDemo](./docs/Start-TypedDemo.md). A [sample file](./assets/sampledemo.txt) is included in this module.

The module should work in both Windows PowerShell and PowerShell Core. Please post an issue with any feedback, suggestions or problems.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

_last updated: 21 February 2019_
