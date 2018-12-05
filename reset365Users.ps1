"Coded By Thomas Reilly 15/02/2016"
##Requires Both Microsoft Online services sign in assistant and Azure active directory module for windows powershell
#variable declarations
#path to secure string password file (Admin password shouldn't be hard-coded
$pwpath="C:\Users\administrator.NHSTUDENT\Documents\ResetUsers\cred.txt"
#run THIS LINE only to change admin password file
#read-host -assecurestring | convertfrom-securestring | out-file $pwpath
#path to user account csv file
$csvpath="C:\Users\administrator.NHSTUDENT\Documents\ResetUsers\o365-import.csv"

#to find sku id run Get-MsolAccountSku after connecting to MSOL service. must change after new trial assigned.
$accountSKU="m365xxxxxxx:ENTERPRISEPREMIUM"


#Get-MsolSubscription | select SkuPartNumber,NextLifecycleDate,Status

#connect to msol service
"Connecting to MSOL Service, Please Wait"
$password = get-content $pwpath | convertto-securestring
$credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist "admin@m365xxxxxxx.onmicrosoft.com",$password
connect-msolservice -credential $credentials


$users = import-csv $csvpath
#Get-MsolUser | select UserPrincipalName,DisplayName | Sort-Object DisplayName | ft
"Deleting User Accounts"
$users | ForEach-Object { Remove-MsolUser -UserPrincipalName $_.UserPrincipalName -Force}

"Creating User Accounts"
$users | ForEach-Object { 
#create user
New-MsolUser -UserPrincipalName $_.UserPrincipalName -City $_.City -Country $_.Country -DisplayName $_.DisplayName -UsageLocation "AU"
#set password as Pa$$word
Set-MsolUserPassword -UserPrincipalName $_.UserPrincipalName -ForceChangePassword 0 -NewPassword "Pa`$`$w0rd"
#assign licences
Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalName -AddLicenses $accountSKU
}

#Get-MsolContact -All | Remove-MsolContact -Force
#Get-MsolGroup -All | Remove-MsolGroup -Force