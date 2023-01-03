###Name - Add-LocalAdminRights.ps1
###User - WandJ0 | Justin Wandeler
###Date - 05/05/2022

#Creating a logfile
$Logfile = "C:\Temp\log$(get-date -f dd-MM-yyyy).log"

#WriteLog-Function for later use
function WriteLog{
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("dd-MM-yyyy HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $LogFile -value $LogMessage
    }   

function Add-LocalAdminRights {
 #Gets all servers except DC001, DC002, DC003 and puts it in a Text-File 
    Get-ADComputer -Filter * -SearchBase "OU=Servers,OU=Computers, ou=xx, dc=xy, dc=xz, dc=ch" |
    Where-Object name -notlike 'domaincontroller1, domaincontroller2, domaincontroller3' |
    select-object -expandproperty name |
    Out-File c:\temp\servers.txt 
    WriteLog "servers file was created"

#Adds GPO G_SSV_Server_Local_Admin to the local Administrator group for each server in the servers.txt
    $servers= Get-Content -path c:\temp\servers.txt
    foreach($server in $servers){
    Write-Host $server 
    Invoke-Command -ComputerName $server -ScriptBlock{
        #Chooses PowerShell CMDlet depending on operating system
        $OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
        $CurrentSystem = (HOSTNAME.EXE)
        If($OSVersion -eq "Windows Server 2012 R2 Standard"){    
            $AdminGroup = [ADSI]("WinNT://$CurrentSystem/Administrators,Group")
            $AdminGroup.Add("WinNT://xy/Server_Local_Admin,Group")
        } else {
    Add-LocalGroupMember -Group "Administrators" -Member "Server_Local_Admin"}
        }
    WriteLog "| $server done"
    }
    WriteLog "| all servers done"
}

Add-LocalAdminRights;
