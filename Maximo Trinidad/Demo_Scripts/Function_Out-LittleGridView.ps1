<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.141
	 Created on:   	6/20/2017 2:54 PM
	 Created by:   	Maximo Trinidad
	 Organization: 	PutItTogether
	 Filename:     Function Out-CsvToGridView.ps1	
	===========================================================================
	.DESCRIPTION
		This is a sample script that integrates the Python code 'TestGuiRead2Gui.py'
		which display the data in a gridview-type GUI.
#>
#Requires -Version 6

Function Out-CsvToGridView{
    param(
        [string] [Parameter(ValueFromPipeline)] $csvFilePath
	)
	
	if ($IsLinux -eq $true)
	{
		Write-Host "Executing in Linux - $($psversionTable.platform.ToString())" -ForegroundColor Green;
		#Linux path:
		/home/maxt/anaconda3/bin/python /home/maxt/Scripts/TestGuiRead2Gui.py $csvFilePath;
	}
	else
	{
		if ($IsWindows -eq $true)
		{
			Write-Host "Executing in Windows - $($psversionTable.platform.ToString())" -ForegroundColor Green;
			#Windows path;
			python.exe "C:\TampaSQLSaturday_02242018\Tampa_SQLSaturday_2018\Demo_Scripts\TestGuiRead2Gui.py" $csvFilePath;
		}
		else
		{
			Write-Host "Can't execute under this OS!";
		};
	};
};

## - To Test Function: (Windows)
Out-CsvToGridView -csvFilePath C:\Temp\SMO_Data2.csv;
Out-CsvToGridView -csvFilePath c:\Temp\nonSMO_Data.csv;

## - Using Pipeline value:
'c:/Temp/SMO_Data2.csv' | Out-CsvToGridView

## - To Test Function: (Linux)
Out-CsvToGridView -csvFilePath /home/maxt/Temp/SMO_Data2.csv;
Out-CsvToGridView -csvFilePath /home/maxt/Temp/nonSMO_Data.csv;

## - Using Pipeline value:
'/home/maxt/Temp/SMO_Data2.csv' | Out-CsvToGridView