<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.141
	 Created on:   	6/28/2017 2:54 PM
	 Created by:   	Maximo Trinidad
	 Organization: 	PutItTogether
	 Filename:     Execute_nonSMO_sqlqry.ps1	
	===========================================================================
	.DESCRIPTION
		This sample script uses System.Data namespace to connect, execute a
		SQL Query, and then create the proper PSObject.
#>

## - Connect and run T-SQL query
$Global:getSvr = "sapien01,1451";
$Global:getSvr = "mars";
$Global:con = "server=$Global:getSvr;database=Master;Integrated Security=false;User ID=sa;" + 'Password=$SqlPwd01!';

## - SQL Query:
$SqlQry = @'
sp_who2
'@;

## - Create connection to SQL Server and execute the T-SQL command:
$sda = New-Object System.Data.SqlClient.SqlDataAdapter ($SqlQry, $global:con);
$sdt = New-Object System.Data.DataTable;
$sda.fill($sdt) | Out-Null;

$sdt.rows | Select-Object -first 10 | Format-Table;

## - Export to a true CSV format file: (Windows)
$sdt.rows | Select-Object -first 10 `
| Export-Csv -Path c:/temp/nonSMO_Data.csv -NoTypeInformation -Encoding UTF8;

## - Export to a true CSV format file: (Linux)
$sdt.rows | Select-Object -first 10 `
| Export-Csv -Path /home/maxt/Temp/nonSMO_Data.csv -NoTypeInformation -Encoding UTF8;

