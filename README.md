# O365-UserCreationTool
Used to Create users on online only Office365. Extracts emails from CSV.

This script will 'reset' the office 365 user accounts. 
It relies on both the Microsoft Online Services Sign in Assistant and Azure Active Directory Module for windows powershell
After the assignment of a new tenant, the following needs to changed 
•	The list of users in the CSV file
•	The $pwpath variable
•	The $csvpath variable
•	The $accountSKU variable
•	To find this run Get-MsolAccountSku after running lines 17-19
•	The domain name on line 18
The password for each user will be Pa$$w0rd it can be changed on line 31.
