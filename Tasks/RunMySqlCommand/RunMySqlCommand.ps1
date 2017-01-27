[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Write-Host "Starting RunMySqlCommand"
Trace-VstsEnteringInvocation $MyInvocation

try {
	Import-VstsLocStrings -LiteralPath "$PSScriptRoot/task.json"

	[string]$serverHost = Get-VstsInput -Name serverHost -Require
	[string]$serverPort = Get-VstsInput -Name serverPort -Require
	[bool]$executeOnDbLvl = Get-VstsInput -Name executeOnDbLvl -AsBool
	[string]$databaseName = Get-VstsInput -Name databaseName
	[string]$connectionTimeout = Get-VstsInput -Name connectionTimeout
	[string]$serverUserName = Get-VstsInput -Name serverUsername -Require
	[string]$serverPassword = Get-VstsInput -Name serverPassword -Require
	[string]$mysqlCommand = Get-VstsInput -Name mysqlCommand -Require

	Import-Module "$PSScriptRoot\ps_modules\MySql\MySql.psm1"

	if ($executeOnDbLvl) {
		Connect-MySqlServer -Server $serverHost -Port $serverPort -Username $serverUserName -Password $serverPassword -Database $databaseName -Timeout $connectionTimeout
		Write-Host "Running MySQL command on database: $databaseName"
	}
	else {
		Connect-MySqlServer -Server $serverHost -Port $serverPort -Username $serverUserName -Password $serverPassword -Timeout $connectionTimeout
		Write-Host "Running MySQL command on server: $serverHost"
	}
	
	Invoke-MySqlQuery -Query $mysqlCommand -Verbose
	Disconnect-MySqlServer -Verbose

	Write-Host "Finished"
}
catch {
	Write-Error "Error running MySQL command: $_"
}
finally {
	Trace-VstsLeavingInvocation $MyInvocation
}

Write-Host "Ending RunMySqlCommand"