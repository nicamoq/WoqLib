@echo off
title WoqLib
mode con: cols=53 lines=10
:lib-detection
IF EXIST C:\woq-chan\srolib.bat set lib=C:
IF EXIST D:\woq-chan\srolib.bat set lib=D:
IF EXIST E:\woq-chan\srolib.bat set lib=E:
IF EXIST F:\woq-chan\srolib.bat set lib=F:
IF EXIST G:\woq-chan\srolib.bat set lib=G:
IF EXIST H:\woq-chan\srolib.bat set lib=H:
IF EXIST I:\woq-chan\srolib.bat set lib=I:
goto lib-start

:lib-start
set libfolder=%lib%\woq-chan
CD "%lib%\woq-chan"
goto lib-check

:lib-check
cls
echo Counting stuff..
IF EXIST "%libfolder%\srolib.bat" goto :lib-check-2
IF NOT EXIST "%libfolder%\srolib.bat" goto lib-check-fail
goto lib-check

:lib-check-fail
cls
echo Where the fuck is %lib%\woq-chan\srolib.bat ???
pause >nul
exit

:lib-check-2
cls
CALL "%libfolder%\srolib.bat"
goto lib-count
:lib-count
title Counting library (1)
cls
IF EXIST "%libfolder%\cache.bat" goto cache
for /f %%a in ('dir /b /ad %anisc%^|find /c /v "" ') do set ani=%%a
for /f %%a in ('dir /b /ad %anisc2%^|find /c /v "" ') do set ani2=%%a
for /f %%a in ('dir /b /ad %mangsc%^|find /c /v "" ') do set manga=%%a
for /f %%a in ('dir /b /ad %hensc%^|find /c /v "" ') do set hent=%%a
for /f %%a in ('dir /b /ad %doujsc1%^|find /c /v "" ') do set douj=%%a
for /f %%a in ('dir /b /ad %doujsc2%^|find /c /v "" ') do set douj2=%%a
set /a doujt=%douj% + %douj2%
goto lib-count-2
:lib-count-2
title Counting library (2)
cls
Setlocal EnableDelayedExpansion
for /f "tokens=*" %%a in ('dir %anisc% /b /s /a:-d') do set /a anif+=1
for /f "tokens=*" %%a in ('dir %anisc2% /b /s /a:-d') do set /a anif2+=1
for /f "tokens=*" %%a in ('dir %mangsc% /b /s /a:-d') do set /a mangaf+=1
for /f "tokens=*" %%a in ('dir %hensc% /b /s /a:-d') do set /a hentf+=1
for /f "tokens=*" %%a in ('dir %doujsc1% /b /s /a:-d') do set /a doujf+=1
for /f "tokens=*" %%a in ('dir %doujsc2% /b /s /a:-d') do set /a doujf2+=1
cls
goto lib-count-3
:lib-count-3
cls
(
echo :: Set 1
echo set /a ani=%ani%
echo set /a ani2=%ani2%
echo set /a manga=%manga%
echo set /a hent=%hent%
echo set /a douj=%douj%
echo set /a douj2=%douj2%
echo set /a doujt=%douj% + %douj2%
echo :: Set 2
echo set /a anif=%anif%
echo set /a anif2=%anif2%
echo set /a mangaf=%mangaf%
echo set /a doujf=%doujf%
echo set /a doujf2=%doujf2%
) > "%libfolder%\cache.bat"
goto main

:cache
cls
IF EXIST "%libfolder%\cache.bat" CALL "%libfolder%\cache.bat"
goto main
:cache-2
cls
DEL /Q "%libfolder%\cache.bat"
goto lib-check

:main
title WoqLib
cls
color %bgcolor%
IF %disablebg%==1 goto menu

for /R "fuji" %%A in (*.BMP) do (
	Start /b "" CMDBkg "%%~A" %opacity%
	Timeout /t 0 /nobreak >nul
	)
	
goto menu

:menu
color %bgcolor%
cls
batbox /c 0xF /d "What are you craving today?"
echo.
echo.
batbox /c 0xF0 /d " Anime DB:" /c 0xA0 /d "%ani%" /c 0xC0 /d "%ani2%" /c 0xF0 /d " Manga DB:" /c 0x5F /d "%manga%" /c 0xF0 /d " Hentai:" /c 0x3F /d "%hent%" /c 0xF0 /d " Doujinshi:" /c 0xDF /d "%doujt%"
:main-buttons
call Button 5 5 8F " Animu " 17 5 DF "ARA ARA~ NANI DOUSHITE" 44 5 0F "@" X _Box _hover
GetInput /M %_Box% /H %highlight%

IF %ERRORLEVEL%==1 goto animu
IF %ERRORLEVEL%==2 goto hentai
IF %ERRORLEVEL%==3 goto cache-2

:animu
color %bgcolor%
cls
echo Choose type:
echo.
echo.
echo.
echo.
batbox /c 0x3 /d " %anif%" /c 0xC /d "              %anif2%" /c 0x7 /d "             %mangaf%"
call Button 1 6 F3 " Completed " 17 6 FC "  Ongoing " 32 6 F8 "  Manga  " 37 1 4F "Back" X _Box _hover
GetInput /M %_Box% /H %highlight%

IF %ERRORLEVEL%==1 start "%SysRoot%\explorer.exe" "%anisc%"
IF %ERRORLEVEL%==2 start "%SysRoot%\explorer.exe" "%anisc2%"
IF %ERRORLEVEL%==3 start "%SysRoot%\explorer.exe" "%mangsc%"
IF %ERRORLEVEL%==4 goto menu
goto animu

:hentai
color %bgcolor%
cls
echo Choose source:
echo.
echo.
echo.
echo.
batbox /c 0xD /d " %hentf%" /c 0xC /d "             %doujf%" /c 0x3 /d "            %doujf2%"
call Button 1 6 FD "  Hentai  " 16 6 FC "  Nhentai  " 32 6 F3 " Tsumino " 37 1 4F "Back" X _Box _hover
GetInput /M %_Box% /H %highlight%

IF %ERRORLEVEL%==1 start "%SysRoot%\explorer.exe" "%hensc%"
IF %ERRORLEVEL%==2 start "%SysRoot%\explorer.exe" "%doujsc1%"
IF %ERRORLEVEL%==3 start "%SysRoot%\explorer.exe" "%doujsc2%"
IF %ERRORLEVEL%==4 goto menu
goto hentai