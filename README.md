# Add-LocalAdminRights
I was tasked with creating a powershell script with the following expectations:

  * 🍸 Adds the active directory group "Server_Local_Admin" to the local administrators
  * 📵 On all windows servers except the domain controllers
  * 📝 Creates an log with the servers that are done
  * 🚀 Works with older powershell versions (Windows Server 2012 use an older powershell version) 
  
The complete powershell script is in this repository.
