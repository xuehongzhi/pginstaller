@echo off
@setlocal EnableDelayedExpansion
cd /d %~dp0
@echo start to backup database
set "MyDate="
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%

set logfile=backup.log
set BACKUP_FILE=d:\data\backup\%DBNAME%_%datestr%.backup

if not defined pghost (
set pghost=localhost
)

if not defined pgport (
set pgport=5432
)

if not defined PGDATABASE (
set PGDATABASE=wyzx
)
if not defined PGUSER (
set PGUSER=postgres
)
if not defined pgpssword (
set pgpassword=postgres
)

if not defined pgpath (
set pgpath="d:\program files\postgresql\9.5\bin"
set path=!pgpath:~1,-1!;!path!
)
rem pg_dump -F p  -v -T *.*migration* -T *.*content_type* -T *.auth_permission -a -b --column-inserts  -f %BACKUP_FILE% %PGDATABASE% > %logfile% 2>&1
pg_dump  -F c -b -n equiptr -f %BACKUP_FILE% > %logfile% 2>&1 
if "%errorlevel%"=="0" (
  @echo backup success!!
) else (
  @echo backup failed...
)
