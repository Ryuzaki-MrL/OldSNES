@echo off
set f=14
set k=1
set ln=1

:begin
cls
echo VIRTUAL CONSOLE INFO:
set /p title=Game Title: 
set /p release=Release Year: 
echo VIRTUAL CONSOLE INFO STYLE:
set /p f=Font Size: 
set /p k=Letter Spacing: 
set /p ln=Number of Lines: 

if not exist input\%title% (
		CALL :bad
) else (
		call :exportfull
)

:bad
echo WARNING: Missing:
if not exist input\%title%\label.png echo   -"%title%\label.png"
if not exist input\%title%\banner.png echo   -"%title%\banner.png"
set /p choice1="Do you want to use blargSNES' default graphics? (Y/N): " %=%
if [%choice1%]==[Y] goto defaults
if [%choice1%]==[y] goto defaults
if [%choice1%]==[N] goto customname
if [%choice1%]==[n] goto customname

:customname
set /p choice2="Do you want to use the data you typed? (Y/N): " %=%
if [%choice2%]==[Y] goto exportdef
if [%choice2%]==[y] goto exportdef
if [%choice2%]==[N] goto exit
if [%choice2%]==[n] goto exit

:defaults
set title=blargSNES
set release=2014
goto exportdef

:exportdef
cd /d %~dp0

mkdir "output\%title%\"
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%title%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" output\%title%\USA_EN2.png
goto end

:exportfull
cd /d %~dp0

mkdir "output\%title%\"
tools\convert input\%title%\label.png -rotate 270 -resize 23x44! output\%title%\label.png
tools\convert tools\USA_EN3.png output\%title%\label.png -geometry +122+205 -composite output\%title%\USA_EN3.png
tools\convert input\%title%\label.png -resize 54x18! output\label.png
tools\convert tools\EUR_EN3.png output\%title%\label.png -geometry +198+227 -composite output\%title%\EUR_EN3.png
del output\label.png
tools\convert input\%title%\banner.png -resize 42x42! output\tempicon.png
tools\convert tools\icon.png output\tempicon.png -gravity center -composite output\%title%\icon.png
del output\tempicon.png
tools\convert input\%title%\banner.png -resize 120x102! output\tempbanner.png
tools\convert tools\COMMON1.png output\tempbanner.png -geometry +4+6 -composite output\%title%\common1.png
tools\convert input\%title%\banner.png -resize 60x51! output\tempbanner.png
tools\convert tools\COMMON1_2.png output\tempbanner.png -geometry +2+3 -composite output\%title%\common1_2.png
tools\convert input\%title%\banner.png -resize 30x26! output\tempbanner.png
tools\convert tools\COMMON1_3.png output\tempbanner.png -geometry +1+1 -composite output\%title%\common1_3.png
del output\tempbanner.png
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -fill #1e1e1e -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%title%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" output\%title%\USA_EN2.png

cd /d %~dp0\banner
copy banner0.bcmdl banner0.bak
set /p choicerg="What region are you building for? (1-13): "  %=% 
copy banner%choicerg%.bcmdl banner%choicerg%.bak
cd ..
goto end

:end
cd "tools"

set /p OpenOha="Do you want to open Ohana3DS? (Y/N): "  %=%
if [%OpenOha%]==[Y] start Ohana3DS.exe
if [%OpenOha%]==[y] start Ohana3DS.exe
if [%OpenOha%]==[N] goto exit
if [%OpenOha%]==[n] goto exit

:exit
cd ..
set /p choice3="Do you want to restart? (Y/N): "  %=%
if [%choice3%]==[Y] goto begin
if [%choice3%]==[y] goto begin
if [%choice3%]==[N] exit
if [%choice3%]==[n] exit
