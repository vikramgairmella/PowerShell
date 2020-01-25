Import-Csv "users.csv" | % {


Set-ExecutionPolicy -Force Unrestricted

$userName=$_.userName
$HomeFolder=$_.HomeFolder


#user Creation
Write-Host "Creating User $userName"
$password = ConvertTo-SecureString "Welcome@1234" -AsPlainText  -Force
New-LocalUser $userName -Password $password

Write-Host "Creating Home Folder For $userName"
#Folder Creation 
New-Item -Path $HomeFolder -Name $userName  -ItemType "directory"

#Set Folder Permissions 
Write-Host "Settiing Folder Permissions"
$acl=Get-Acl "$HomeFolder\$userName"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:COMPUTERNAME\$userName","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "$HomeFolder\$userName"


}

Set-ExecutionPolicy Restricted -Force -ErrorAction SilentlyContinue