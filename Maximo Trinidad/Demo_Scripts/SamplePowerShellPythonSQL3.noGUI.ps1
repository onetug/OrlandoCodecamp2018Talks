#SamplePoweShellPythonSQL3_noGUI.ps1
#Updated: 10/02/2017
#
#Description: This sample code is meant to be copy/paste to the console
#             showing the progression of the script been develop.
#             (Do not run the whole script)

## - Windows: sqlsvr1,1451 (instance1), sqlsvr2,1441
## - Linux: sqlsvr1 (default 1437)

$RunPython = @'
import pyodbc

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=sapien01,1451;DATABASE=master;UID=sa;PWD=$SqlPwd01!')
cursor = cnxn.cursor()

#Execute T-SQL Query:

trecord = []
tsql = 'SELECT Name, Location, Hire, HireDate FROM SampleDB1.dbo.HolidayEmployees;'
if cursor.execute(tsql):
    row = cursor.fetchone()
    while row:
        datarow = [str(row[0]),str(row[1]),str(row[2]),str(row[3])]
        trecord.append(datarow)
        row = cursor.fetchone()

## - list to screen list of data:
for i, r in enumerate(trecord):
    print(i,r);
    
exit();
'@;

$result = python -c $RunPython;
$result;

## ----------------------------------- ##

[array]$HolidayEmployees = $null;
[array]$HolidayEmployees = foreach ($line in $result) {
	
    $obj = ($line.Replace("[", '').Replace("'", '').Replace("]", '').split(',')).trim();
	
    ## - Build PSCustomObject:
    [PSCustomObject]$data = New-Object PSObject -Property @{
        Name     = $obj[0].Split(' ')[1] + ' ' + $obj[0].Split(' ')[2];
        Location = $obj[1];
        Hire     = $obj[2];
        HireDate = $obj[3];
    }; $data;
};

$HolidayEmployees | Select-Object Name, Location, Hire, HireDate `
    | Format-Table -AutoSize;

## - In Linux=> /home/maxt/anaconda3/bin/python /home/maxt/Scripts/TestGuiRead2Gui.py '//home//maxt//temp//displaydata.csv'
## - In PowerShell Core Win10: => python c:/Users/maxt/OneDrive/MyDocs/MyCrossPlatCode/CrossPlatScripts/PowerShell_Asia/TestGuiRead2Gui.py 'C:\Temp\displaydata.csv' 
