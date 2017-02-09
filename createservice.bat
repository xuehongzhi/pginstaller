@echo off
@setlocal EnableDelayedExpansion
cd /d %~dp0
@echo start to install postgres
set logfile=postgres.log

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

initdb -E utf8 -U postgres -W -D "%pgpath%\data"
pg_ctl register -N equipmgr -U "NT AUTHORITY\NETWORK SERVICE" -D  "%pgpath%\data" -S auto
