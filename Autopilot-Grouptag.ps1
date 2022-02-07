<#
<#PSScriptInfo : This script will update Autopilot device GroupTag in Bulk or update only devices that doesn't have GroupTag or update individual device group tag.
.VERSION 1.0.0
.AUTHOR Khogen Maibam
#>
<#
.DESCRIPTION
   This cmdlet will update all autopilot devices GroupTag. This function requires module Microsoft.Graph.Intune and WindowsAutopilotintune install on the machine
.EXAMPLE
   Example of how to use this cmdlet
   Update-AutopilotdeviceGrouptag -GroupTag 'yourgrouptag'
#>
Function Update-AutopilotdeviceGrouptag 
{

    [CmdletBinding()]

    param( 
       
        [Parameter(Mandatory=$true )]
        [String]$GroupTag

       
        
    )

    Begin {
       
        $IntuneGraphmodule= Get-Module -ListAvailable|Where-Object{$_.Name -eq 'Microsoft.Graph.Intune'}
        $Autopilotmodule = Get-Module -ListAvailable|Where-Object{$_.Name -eq 'WindowsAutoPilotIntune'}
               
        Write-Verbose -Message "Attempting to locate Microsoft.Graph.Intune and WindowsAutopilotintune module. If modules is not installed you will be prompted to install, please click on yes!"
        
            If(!($IntuneGraphmodule.Name -eq 'Microsoft.Graph.Intune')) 
            
            { 
               
                Install-Module -Name Microsoft.Graph.Intune -force -Confirm
            }

            else{
                
                Write-Verbose -Message " Microsoft.Graph.Intune module already installed on the machine" -verbose
            }
        
                if(!($Autopilotmodule.Name -eq 'WindowsAutoPilotIntune')){        
                
                Install-Module -Name  WindowsAutoPilotIntune -RequiredVersion 4.8 -force -Confirm }

                else{
                
                    Write-Verbose -Message " WindowsAutoPilotIntune module already installed on the machine" -Verbose
                }
          
          } 
               
    Process
        {      
                               
    
                   try{
                #Connect to MSGraph    
                    Connect-MSGraph -ForceInteractive

                    $AllDeviceID= Get-AutopilotDevice

                    foreach($devid in $AllDeviceid.id) 
                    {
                        Write-Verbose -Message 'Updating GroupTag to all Autopilot devices' -Verbose
                        Set-AutopilotDevice -id $devid -groupTag $GroupTag
                    }
                }
                    catch [System.Exception] 
                    {   
                        Write-Warning -Message "$($_.Exception.Message)"
                    }

        
}}

<#
.DESCRIPTION
   This cmdlet will update selected autopilot devices GroupTag. 
.EXAMPLE 1
   to update individual device or multiple device
   Update-SelectedAutopilotDeviceGrouptag -Deviceid '390eb861-5680-4cb0-8e62-4786b7b3d0a2' -GroupTag Financedept
   Update-SelectedAutopilotDeviceGrouptag -Deviceid '390eb861-5680-4cb0-8e62-4786b7b3d0a2', '390eb861-5680-4cb0-8e62-4786b7b3d0a2' -GroupTag Financedept

.EXAMPLE 2
   To update all devices that doesnt have GroupTag name
   (Get-AutopilotDevice | Where-Object -FilterScript {$_.Grouptag -eq ""}).id | Update-SelectedAutopilotDeviceGrouptag -GroupTag Financedept
   
#>
Function Update-SelectedAutopilotDeviceGrouptag
{

    [CmdletBinding()]

    param( 
        [Parameter(
        Mandatory=$true,
        ValueFromPipeline=$True
        )]
        [string[]]$Deviceid, 

      
        [Parameter(Mandatory=$true )]
        [String]$GroupTag
        
        
    )

    Begin {
            
        $IntuneGraphmodule= Get-Module -ListAvailable|Where-Object{$_.Name -eq 'Microsoft.Graph.Intune'}
        $Autopilotmodule = Get-Module -ListAvailable|Where-Object{$_.Name -eq 'WindowsAutoPilotIntune'}

        Write-Verbose -Message "Attempting to locate Microsoft.Graph.Intune and WindowsAutopilotintune module. If modules is not installed you will be prompted to install, please click on yes!"
        
            If(!($IntuneGraphmodule.Name -eq 'Microsoft.Graph.Intune')) 
            
            { 
               
                Install-Module -Name Microsoft.Graph.Intune -force -Confirm
            }

            else{
                
                Write-Verbose -Message " Microsoft.Graph.Intune module already installed on the machine" -verbose
            }
        
                if(!($Autopilotmodule.Name -eq 'WindowsAutoPilotIntune')){        
                
                Install-Module -Name  WindowsAutoPilotIntune -RequiredVersion 4.8 -force -Confirm }

                else{
                
                    Write-Verbose -Message " WindowsAutoPilotIntune module already installed on the machine" -Verbose
                }
           
          } 
               
    Process
        {      
                               
            try{
                #Connect to MSGraph    
                    Connect-MSGraph -ForceInteractive

                    Write-Verbose -Message 'Updating GroupTag to selected Autopilot devices' -Verbose
                        Set-AutopilotDevice -id $DeviceId -groupTag $GroupTag }

                        catch [System.Exception] 
                        {   
                            Write-Warning -Message "$($_.Exception.Message)"
                        }
     
                        
                    
               

        }
        
}