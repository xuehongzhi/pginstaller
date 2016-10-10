@echo off
cd /d %~dp0
set role=equiptr
set SCHEMA=%role%
set PGDATABASE=testhh

set SCHEMA=%role%
set PGPORT=5432
set PGHOST=localhost
set PGUSER=
set PGPATH=d:\program files\postgresql\9.5\bin
set PGPASSWORD=
set PASSWORD=equip678
set PYPATH=c:\users\xuehz\pywithdj
set path=%PYPATH%;%pypath%\scripts;%PGPATH%;%PATH%

rem call backup.bat
call :create_role_SCHEMA
call :migrate_database
if "%errorlevel%" NEQ  "0" (
  goto :end
)
if exist "createview.sql"  (
  psql -f createview.sql
) 
call restore.bat
goto :end

:create_role_SCHEMA
set PGUSER=postgres
set PGPASSWORD=POSTGRES
:call create.bat
goto :eof

:migrate_database
set PGUSER=%role%
set PGPASSWORD=%PASSWORD%

copy /Y equipmgr\migrations\__init__.pyc equipmgr\migrations.pyc>nul 2>nul
del /s /q equipmgr\migrations\*
copy /Y equipmgr\migrations.pyc equipmgr\migrations\__init__.pyc>nul 2>nul
call migrate.bat
goto :eof
:end
