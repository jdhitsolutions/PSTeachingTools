# PSTeachingTools

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSTeachingTools.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSTeachingTools/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSTeachingTools.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSTeachingTools/)

## Installation

You should install this module from the PowerShell Gallery:

```powershell
install-module psteachingtools [-scope currentuser]
```

If installing on PowerShell 7 you may need to include the `-scope currentuser` parameter. Do not attempt to download and install from this repository unless you are an experienced PowerShell user.

The module should work in both Windows PowerShell and PowerShell 7. Please post an issue with any feedback, suggestions or problems.

## Teaching PowerShell

This PowerShell module includes tools and techniques for teaching PowerShell. Many of the commands will create a set of sample objects and commands that can be used to demonstrate a variety of PowerShell techniques and concepts without having to worry about anything technical like Active Directory, services or file objects.

![Using objects in the pipeline](assets/get-vegetable.jpg)

![setting objects](assets/set-vegetable.jpg)

See the [about_psteachingtools](Docs/about_PSTeachingTools.md) help file for more information.

## Typed Demos

The module also includes a function for simulating an interactive PowerShell console session. You can type your commands in a file and have the function "play back" the commands just as if you were typing the commands. The function will pause after every `|` character. Pressing `Enter` will advance the demo. Read help for [Start-TypedDemo](Docs/Start-TypedDemo.md). A [sample file](assets/sampledemo.txt) is included in this module.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

_last updated: 2020-05-16 13:21:23Z UTC_
