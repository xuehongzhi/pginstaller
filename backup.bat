@echo off
@setlocal EnableDelayedExpansion
cd /d %~dp0
@echo start to backup database
set logfile=backup.log

if not defined PGDATABASE (
set PGDATABASE=hhzj
)
if not defined PGUSER (
set PGUSER=postgres
)
if not defined pgpassword (
set pgpassword=POSTGRES
)
if not defined pgpath (
set pgpath="d:\program files\postgresql\9.5\bin"
set path=!pgpath:~1,-1!;!path!
)
pg_dump -F p  -v -T *.*migration* -T *.*content_type* -T *.auth_permission -a -b --column-inserts  -f %PGDATABASE%.back %PGDATABASE% > %logfile% 2>&1
if "%errorlevel%"=="0" (
  @echo backup success!!
  ren %PGDATABASE%.back %PGDATABASE%.backup
) else (
  @echo backup failed...
)
