###########################################################################
## - TestSqlGui.py
## - Author: Maximo Trinidad, 06/15/2017
## - Comment: Block of code will read a SQL table to be display to a GUI.
## -          Columns Table are explicitly hardcoded.
###########################################################################

import pyodbc
from tkinter import *

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=mars;'+ \
                      'DATABASE=master;UID=sa;PWD=$SqlPwd01!')
cursor = cnxn.cursor()

#Execute T-SQL Query:
trecord = []
tsql = \
'SELECT Name, Location, Hire, HireDate FROM SampleDB1.dbo.HolidayEmployees;'
if cursor.execute(tsql):
    row = cursor.fetchone()
    while row:
        datarow = [str(row[0]),str(row[1]),str(row[2]),str(row[3])]
        trecord.append(datarow)
        row = cursor.fetchone()

## - list to screen list of data and will get number of rows in the list:
i = 0;
for i, rec in enumerate(trecord):
    print(rec);

for i, rec in enumerate(trecord):
    col = 0;
    for c in rec:
        Label(text=c, relief=RIDGE, width=15).grid(row=i, column=col)
        col = col + 1;

mainloop()
