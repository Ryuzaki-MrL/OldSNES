@echo off

:begin
cls
set f=14
set k=1
set w=6
set ln=1
echo GAME INFO:
set /p "title=Game Title: "
echo VIRTUAL CONSOLE INFO AND INFO STYLE:
set vc=%title%
set /p "vc=Virtual Console Title: "
set /p release=Release Year: 
set /p f=Font Size: 
set /p k=Letter Spacing: 
set /p w=Word Spacing: 
set /p ln=Number of Lines: 

if not exist "input\%title%" (
        CALL :bad
) else (
        call :exportfull
)

:bad
echo ERROR: Missing banner file
choice /C YN /M "Do you want to use blargSNES' default graphics?"
IF ERRORLEVEL 2 goto customname
IF ERRORLEVEL 1 goto defaults


:customname
choice /C YN /M "Do you want to use the data you typed?"
IF ERRORLEVEL 2 goto exit
IF ERRORLEVEL 1 goto exportdef

:defaults
set title=blargSNES
set vc=blargSNES
set release=2014
goto exportdef

:exportdef
cd /d %~dp0

if not exist "output\%title%" mkdir "output\%title%\"
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%vc%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" "output\%title%\USA_EN2.png"
if exist "input\blargSNES\icon.png" copy /b "input\blargSNES\icon.png" "input\%title%\icon.png" >NUL 2>NUL
goto end

:exportfull
cd /d %~dp0

if exist "input\%title%\banner.png" ( set "file1=banner.png"
) else if exist "input\%title%\banner.jpg" ( set "file1=banner.jpg"
) else if exist "input\%title%\banner.jpeg" ( set "file1=banner.jpeg"
) else goto bad

if exist "input\%title%\label.png" ( set "file2=label.png"
) else if exist "input\%title%\label.jpg" ( set "file2=label.jpg"
) else set "file2=label.jpeg"

if not exist "output\%title%" mkdir "output\%title%\"

tools\convert "input\%title%\%file2%" -rotate 270 -resize 23x44! output\label.png
tools\convert tools\USA_EN3.png output\label.png -geometry +122+205 -composite "output\%title%\USA_EN3.png"
tools\convert "input\%title%\%file2%" -resize 54x18! output\label.png
tools\convert tools\EUR_EN3.png "output\label.png" -geometry +198+227 -composite "output\%title%\EUR_EN3.png"
del output\label.png
tools\convert "input\%title%\%file1%" -resize 120x102! output\tempbanner.png
tools\convert tools\COMMON1.png output\tempbanner.png -geometry +4+6 -composite "output\%title%\common1.png"
tools\convert "input\%title%\%file1%" -resize 60x51! output\tempbanner.png
tools\convert tools\COMMON1_2.png output\tempbanner.png -geometry +2+3 -composite "output\%title%\common1_2.png"
tools\convert "input\%title%\%file1%" -resize 30x26! output\tempbanner.png
tools\convert tools\COMMON1_3.png output\tempbanner.png -geometry +1+1 -composite "output\%title%\common1_3.png"
del output\tempbanner.png
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing %w% -interline-spacing %lt% -annotate +45+0 "%vc%\n" -pointsize 14 -kerning 1.5 -interword-spacing 6 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" "output\%title%\USA_EN2.png"

cd "banner"
if not exist "backup\" mkdir "backup\"
copy ..\banner backup >NUL 2>NUL
cd ..
goto end

:end
cls
if exist tools\autobanner.py (
    python --version 2>NUL
    if errorlevel 0 goto autobanner
    if errorlevel 1 echo ERROR: Python not found. Couldn't generate banner automatically.
)

choice /C YN /M "Do you want to open Ohana3DS?"
IF ERRORLEVEL 2 goto exit
IF ERRORLEVEL 1 start /w tools\Ohana3DS.exe

tools\3dstool -c -f "output\%title%\banner.bin" -t banner --banner-dir banner >NUL 2>NUL
goto exit

:autobanner
py tools\autobanner.py "%title%"

:exit
if exist banner\backup (
    copy /b banner\backup banner >NUL 2>NUL
    rmdir /s /q banner\backup
)
cls
choice /C YN /M "Do you want to restart?"
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 goto begin
