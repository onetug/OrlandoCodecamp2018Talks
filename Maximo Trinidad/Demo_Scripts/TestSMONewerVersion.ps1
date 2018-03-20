<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.148
	 Created on:   	1/24/2018 11:01 AM
	 Created by:   	Maximo Trinidad
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:    TestSMONewerVersion.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
	https://www.nuget.org/packages/Microsoft.SqlServer.SqlManagementObjects
#>

sqlcmd -S localhost -U SA -P '$SqlPwd01!'

## - Find if package is currently available for download:
Find-Package Microsoft.SqlServer.SqlManagementObjects;

## - Find if package is already installed locally:
Get-Package Microsoft.SqlServer.SqlManagementObjects;

#New Version SMO: 140.17220.0 (wget https://int.nugettest.org/api/v2/package/Microsoft.SqlServer.SqlManagementObjects/140.17220.0)
Install-Package Microsoft.SqlServer.SqlManagementObjects -Source 'C:\Users\max_t\D
ownloads\microsoft.sqlserver.sqlmanagementobjects.140.17220.0.nupkg';


Install-Package Microsoft.SqlServer.SqlManagementObjects -Source 'C:\Users\max_t\Downloads';

## - Package installed location:
"C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SqlServer.SqlManagementObjects.140.17220.0\"


function Verify-NugetRegistered
{
	[CmdletBinding()]
	Param ()
	# Microsoft provided code:
	# Register NuGet package source, if needed
	# The package source may not be available on some systems (e.g. Linux/Windows)
	if (-not (Get-PackageSource | Where-Object{ $_.Name -eq 'Nuget' }))
	{
		Register-PackageSource -Name Nuget -ProviderName NuGet -Location https://www.nuget.org/api/v2
	}
	else
	{
		Write-Host "NuGet Already Exist! No Need to install."
	};
};

## - Execute:
Verify-NugetRegistered

## - Help find and save the location of the SMO dll's in a PowerShell variable:
$smopath = Join-Path ((Get-Package Microsoft.SqlServer.SqlManagementObjects).Source `
	| Split-Path) (Join-Path lib netstandard2.0)

# Add types to load SMO Assemblies only:
Add-Type -Path (Join-Path $smopath Microsoft.SqlServer.Smo.dll)
Add-Type -Path (Join-Path $smopath Microsoft.SqlServer.ConnectionInfo.dll)

## - Prepare connection and credential strings for SQL Server:
## - (Connection to Windows SQL Server multi-instance sample)
#
$SQLServerInstanceName = 'sapien01,1451'; $SQLUserName = 'sa'; $sqlPwd = '$SqlPwd01!';

## - Turn ON below for Linux:
## - (Connection to Linux SQL Server multi-instance sample)
$SQLServerInstanceName = 'mars'; $SQLUserName = 'sa'; $sqlPwd = '$SqlPwd01!';

## - Prepare connection passing credentials to SQL Server:
$SQLSrvConn = New-Object Microsoft.SqlServer.Management.Common.SqlConnectionInfo($SQLServerInstanceName, $SQLUserName, $SqlPwd);
$SQLSrvObj = new-object Microsoft.SqlServer.Management.Smo.Server($SQLSrvConn);

## - SMO Get SQL Server Info:
$SQLSrvObj.Information `
| Select-Object parent, platform, product, productlevel, `
				OSVersion, Edition, version, HostPlatform, HostDistribution `
| Format-List;

## - More SQLServer script:

## - Sample T-SQL Queries:
$SqlQuery = @"
SELECT TOP (1000) [Name]
      ,[Location]
      ,[Hire]
      ,[HireDate]
  FROM [sampledb1].[dbo].[HolidayEmployees]
"@;

$SqlQuery = "SP_WHO2"

## - Execute T-SQL Query:
[array]$result = $SQLSrvObj.Databases['master'].ExecuteWithResults($SqlQuery);
$result.tables.Rows | Select-object -first 5 $_ | Format-Table -AutoSize;


## - Export to a true CSV format file:
#-Windows
$result.tables.Rows | Select-object -first 5 $_ `
| Export-Csv -Path c:/Temp/SMO_Data2.csv -NoTypeInformation -Encoding UTF8;

#-Linux
$result.tables.Rows | Select-object -first 5 $_ `
| Export-Csv -Path /home/maxt/Temp/SMO_Data2.csv -NoTypeInformation -Encoding UTF8;
