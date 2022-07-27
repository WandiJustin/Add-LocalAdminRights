# Add-LocalAdminRights
I was tasked with creating a powershell script with the following expectations:
  * adds the active directory group "G_SSV_Server_Local_Admin" to the local administrators
  * on all servers except the domain controllers
  * creates an log with the servers that are done
  
The complete powershell script is in this repository.
