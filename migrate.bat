@echo off
setlocal EnableDelayedExpansion
echo start to migrate db 
set logfile=migrations.log
if not defined PYPATH (
	set pypath=C:\python34
        set path=!pypath!;!pypath!\scripts;!path!
)
python manage.py makemigrations 1>%logfile% 2>&1
python manage.py migrate>%logfile% 2>&1
if "%errorlevel%"=="0" (
  @echo migrate success!!
) else (
  @echo migrate failed...
)
