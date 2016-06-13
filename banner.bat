@echo off
set f=14
set k=1
set ln=1

:begin
cls
echo GAME INFO:
set /p title=Game Title: 
echo VIRTUAL CONSOLE INFO AND INFO STYLE:
set vc=%title%
set /p vc=Virtual Console Title: 
set /p release=Release Year: 
set /p f=Font Size: 
set /p k=Letter Spacing: 
set /p ln=Number of Lines: 

if not exist "input\%title%" (
		CALL :bad
) else (
		call :exportfull
)

:bad
echo WARNING: Missing:
if not exist "input\%title%\label.png" echo   -"%title%\label.png"
if not exist "input\%title%\banner.png" echo   -"%title%\banner.png"
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

mkdir "output\%title%\"
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%vc%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" "output\%title%\USA_EN2.png"
goto end

:exportfull
cd /d %~dp0

if not exist "input\%title%\banner.png" goto bad

mkdir "output\%title%\"
if exist "input\%title%\label.png" ( tools\convert "input\%title%\label.png" -rotate 270 -resize 23x44! output\label.png
) else if exist "input\%title%\label.jpg" tools\convert "input\%title%\label.jpg" -rotate 270 -resize 23x44! output\label.png
tools\convert tools\USA_EN3.png output\label.png -geometry +122+205 -composite "output\%title%\USA_EN3.png"
tools\convert "input\%title%\label.png" -resize 54x18! output\label.png
tools\convert tools\EUR_EN3.png "output\label.png" -geometry +198+227 -composite "output\%title%\EUR_EN3.png"
del output\label.png
tools\convert "input\%title%\banner.png" -resize 120x102! output\tempbanner.png
tools\convert tools\COMMON1.png output\tempbanner.png -geometry +4+6 -composite "output\%title%\common1.png"
tools\convert "input\%title%\banner.png" -resize 60x51! output\tempbanner.png
tools\convert tools\COMMON1_2.png output\tempbanner.png -geometry +2+3 -composite "output\%title%\common1_2.png"
tools\convert "input\%title%\banner.png" -resize 30x26! output\tempbanner.png
tools\convert tools\COMMON1_3.png output\tempbanner.png -geometry +1+1 -composite "output\%title%\common1_3.png"
del output\tempbanner.png
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%vc%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" "output\%title%\USA_EN2.png"

cd "banner"
mkdir "backup\"
copy banner0.bcmdl backup\banner0.bcmdl
set /p choicerg="What region are you building for? (1-13): "  %=% 
if [%choicerg%]==[] (
    copy ..\banner backup
) else (
    copy banner%choicerg%.bcmdl backup\banner%choicerg%.bcmdl
)
cd ..
goto end
Pause

:end
cls
cd "tools"

choice /C YN /M "Do you want to open Ohana3DS?"
IF ERRORLEVEL 2 goto exit
IF ERRORLEVEL 1 start Ohana3DS.exe

:exit
cls
cd ..
choice /C YN /M "Do you want to restart?"
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 goto begin
