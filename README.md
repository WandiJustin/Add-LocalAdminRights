# Add-LocalAdminRights
I was tasked with creating a powershell script with the following expectations:
  * adds the active directory group "G_SSV_Server_Local_Admin" to the local administrators
  * on all windows servers except the domain controllers
  * creates an log with the servers that are done
  * works with older powershell versions (Windows Server 2012 use an older powershell version) 
  
The complete powershell script is in this repository.
