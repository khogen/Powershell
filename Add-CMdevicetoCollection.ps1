<#
PSScriptInfo
.VERSION 1.0.0
.AUTHOR Khogen Maibam
.TAGS SCCM Device Collection
.PROJECTURI https://github.com/SCConfigMgr/Intune/blob/master/Autopilot/Upload-WindowsAutopilotDeviceInfo.ps1
.Synopsis
   This script can be handy in adding computers to existing collection when Right click tool is not integrated with the console.
.DESCRIPTION
   The function Add-CMdevicetoCollection can add single or multiple device to collection. It also can read device list from text file as well. It user direct membership rule.
   
.EXAMPLE
   Add-cmdevicetocollection -SiteServerName xyz.com -SiteCode PRI -Collectionname test -Computer Computer1,Computer2,Computer3
.EXAMPLE
   Add-cmdevicetocollection -SiteServerName xyz.com -SiteCode PRI -Collectionname test -Computer(Get-Content -Path "C:\Users\sccmadmin\Documents\comp.txt")
.EXAMPLE
   Get-help Add-CMdevicetoCollection to view help file
#> Function Add-CMdevicetoCollection{

    [CmdletBinding(SupportsShouldProcess=$true, 
                   ConfirmImpact='Medium')]
   
   param(
   [Parameter(Mandatory = $true)]
   $SiteServerName,
   
   [Parameter(Mandatory = $true)]
   $SiteCode,
   
   [Parameter(Mandatory = $true)]
   [String]$Collectionname,
   
   [parameter(Mandatory=$true, 
   Valuefrompipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
   [string[]]$Computer
   
   
   )
   
   Import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
   cd $SiteCode":"
   
   
   foreach($C in $computer) {
   
   try {
   Write-Host “Adding $c to $collectionname” -ForegroundColor Green 
   Add-CMDeviceCollectionDirectMembershipRule -CollectionName $collectionname -ResourceId (get-cmdevice -Name $C).ResourceID
   
   }
   catch {
   Write-error "Computer $c is not a valid device and cannot be added"
   
   }
   }}