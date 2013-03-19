@echo off

if [%1]==[] goto help
if /I "%1"=="help" goto help

if not defined GRAILS_ROOT echo ERROR: System variable GRAILS_ROOT is not set & goto fail
if not exist "%GRAILS_ROOT%" echo ERROR: GRAILS_ROOT path (%GRAILS_ROOT%) does not exist & goto fail

if /I "%1"=="list" goto list
if /I "%1"=="use" goto use
echo ERROR Unknown command (%1)
goto fail

:list
    setlocal enabledelayedexpansion
    for /D %%a in ("%GRAILS_ROOT%\*") do (
        set DIR=%%a
        if exist "!DIR!\bin\grails" echo !DIR:%GRAILS_ROOT%\=!
    )
    endlocal
    goto end

:use
    if [%2]==[] echo ERROR: No version specified & goto fail
    setlocal enabledelayedexpansion
    set NEW_GRAILS_HOME=%GRAILS_ROOT%\%2
    if not exist "!NEW_GRAILS_HOME!\bin\grails" echo ERROR: No installation for version (%2) found & goto fail
    if defined GRAILS_HOME (
        set NEW_PATH=!PATH:%GRAILS_HOME%=%NEW_GRAILS_HOME%!
    ) else (
        set NEW_PATH=!NEW_GRAILS_HOME!;!PATH!
        echo !NEW_PATH!
    )
    endlocal & set GRAILS_HOME=%NEW_GRAILS_HOME%& set PATH=%NEW_PATH%
    echo Configuration completed, launching version verification
    call grails -version
    goto end

:help
    echo Usage: %~n0 ^<command^> [version]
    echo.
    echo Commands: list - show available versions
    echo           use  - switch to given version 
    echo           help - show this information 
    echo.
    echo Example: %~n0 use 2.2.0
    echo.
    echo Individual Grails versions are expected to be unpacked within common 
    echo root directory, each in a sub-folder named by respective version. 
    echo Full path to the common root needs to be specified in GRAILS_ROOT 
    echo system variable (without the trailing slash).
    echo.
    echo Example: C:\Grails\2.1.4
    echo          C:\Grails\2.2.0
    echo          GRAILS_ROOT=C:\Grails
    goto end

:fail
    exit /B 1

:end
    exit /B 0
