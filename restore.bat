@echo off
@setlocal EnableDelayedExpansion
cd /d %~dp0

@echo start to restore database
set logfile=restore.log

if not defined PGDATABASE (
set PGDATABASE=wyzx
)
if not defined PGUSER (
set PGUSER=postgres
)

if not defined pgpassword (
set pgpassword=postgres
)

if not defined pgpath (
set pgpath="d:\program files\postgresql\9.5\bin"
set path=!pgpath:~1,-1!;!path!
)

if exist "%PGDATABASE%.backup"  (
@echo start to restore
psql -f %PGDATABASE%.backup>nul 2>nul
	if "%errorlevel%" == "0" (
	 del /S /Q %PGDATABASE%.backup
	 @echo retore success!!
	)
)
