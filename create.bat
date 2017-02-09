@echo off
@setlocal EnableDelayedExpansion
cd /d %~dp0
set BACKUP_FILE=%1
@echo start to create database
set logfile=create.log

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
set pgpath="d:\program files\postgresql\9.4\bin"
set path=!pgpath:~1,-1!;!path!
)
psql -d postgres -c "drop database if exists %pgdatabase% cascade;" >%logfile% >2&1
psql -d postgres -c "create role %role%;">%logfile% >2&1
psql -d postgres -c "alter role %role% with CREATEUSER LOGIN PASSWORD '%PASSWORD%';">%logfile% >2&1
psql -d postgres  -c "create database %PGDATABASE% with owner=%role%;">%logfile% >2&1
if %errorlevel% ==0 (
 @echo "create db success!!!"
) else (
 @echo "create failed..."
)

pg_restore.exe -e %BACKUP_FILE%
