--1. Enabled External Scripts: (T-SQL)
sp_configure 'external scripts enabled', 1
Reconfigure

--(Restarting SQL Server Services needed)

--2. Run Test in SQL Query Panel:
execute sp_execute_external_script
@language = N'python',
@script = N'
import sys
print("Hello SQLServer, I am Python Version:")
print(sys.version)
';