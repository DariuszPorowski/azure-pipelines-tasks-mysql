try {
	$ErrorActionPreference = "Stop";
	#cd $PSScriptRoot
	#Invoke-WebRequest -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile nuget.exe
	#.\nuget.exe install MySQL.Data -Version 6.10.6 -outputdirectory $PSScriptRoot
	#$mySQLDataDLL =  "$PSScriptRoot\MySql.Data.6.10.6\lib\net452\MySQL.Data.dll"
	$mySQLDataDLL =  "$PSScriptRoot\MySQL.Data.dll"
	[void][System.Reflection.Assembly]::LoadFrom($mySQLDataDLL);
	#[System.Reflection.Assembly]::LoadWithPartialName("MySql.Data") | Out-Null;
	$Global:MySQLConnection = $null;
}
catch {
	Write-Error $_
	break
}

Function Connect-MySqlServer {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Server = 'localhost',
		[Parameter(Mandatory = $true)]
		[int]$Port = 3306,
		[Parameter(Mandatory = $true)]
		[string]$Username,
		[Parameter(Mandatory = $true)]
		[string]$Password,
		[int]$Timeout = 30,
		[string]$Database = $null
	)

	Begin {
		Write-Verbose "Build connection string";
		if ($Database) {
			$connectionString = "Server=$($Server);Port=$($Port);Uid=$($Username);Pwd=$($Password);database=$($Database);SslMode=Preferred;Connection Timeout=$($Timeout);Allow User Variables=True;";
		}
		else {
			$connectionString = "Server=$($Server);Port=$($Port);Uid=$($Username);Pwd=$($Password);SslMode=Preferred;Connection Timeout=$($Timeout);Allow User Variables=True;";
		}
	}
	Process {
		try {
			$ErrorActionPreference = "Stop";
			Write-Verbose "Create MySQL connection object";
			[MySql.Data.MySqlClient.MySqlConnection]$connection = New-Object MySql.Data.MySqlClient.MySqlConnection($connectionString);
			Write-Verbose "Open MySQL connection";
			$connection.Open();
			if ($Database) {
				Write-Verbose "Using $($Database)";
				[MySql.Data.MySqlClient.MySqlCommand]$command = New-Object MySql.Data.MySqlClient.MySqlCommand("USE $($Database)", $connection);
			}
		}
		catch {
			Write-Error $_
			break
		}
	}
	End {
		$Global:MySQLConnection = $connection;
		return $connection;
	}
}

Function Disconnect-MySqlServer {
	[CmdletBinding()]
	Param (
		[MySql.Data.MySqlClient.MySqlConnection]$connection = $Global:MySQLConnection
	)

	Begin { }
	Process {
		Write-Verbose "Close MySQL connection";
		$connection.Close();
	}
	End { }
}

Function Invoke-MySqlQuery {
	[CmdletBinding()]
	Param (
		[MySql.Data.MySqlClient.MySqlConnection]$connection = $Global:MySQLConnection,
		[Parameter(Mandatory = $true)]
		[string]$Query
	)

	Begin { }
	Process {
		try {
			$ErrorActionPreference = "Stop";
			Write-Verbose "Creating the Command object";
			[MySql.Data.MySqlClient.MySqlCommand]$command = New-Object MySql.Data.MySqlClient.MySqlCommand;
			Write-Verbose "Assigning Connection object to Command object";
			$command.Connection = $connection;
			Write-Verbose "Assigning Query to Command object";
			$command.CommandText = $Query;
			Write-Verbose $Query;
			Write-Verbose "Creating DataAdapter with Command object";
			[MySql.Data.MySqlClient.MySqlDataAdapter]$dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($command);
			Write-Verbose "Creating Dataset object to hold records";
			[System.Data.DataSet]$dataSet = New-Object System.Data.DataSet;
			Write-Verbose "Filling Dataset";
			$recordCount = $dataAdapter.Fill($dataSet);
			Write-Verbose "$($recordCount) records found";
		}
		catch {
			Write-Error $_
			break
		}
	}
	End {
		Write-Verbose "Returning Tables object of Dataset";
		return $dataSet.Tables;
	}
}

Export-ModuleMember *