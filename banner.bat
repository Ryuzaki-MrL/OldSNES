@echo off
if not exist input\label.png echo WARNING: Missing label image.
if not exist input\banner.png echo WARNING: Missing banner image.
set title=blargSNES
set release=2014
set f=14
set k=1
set ln=1
echo VIRTUAL CONSOLE INFO:
set /p title=Game Title: 
set /p release=Release Year: 
echo VIRTUAL CONSOLE INFO STYLE:
set /p f=Font Size: 
set /p k=Letter Spacing: 
set /p ln=Number of Lines: 
tools\convert input\label.png -rotate 90 -resize 23x44! output\label.png
tools\convert tools\USA_EN3.png output\label.png -geometry +122+205 -composite output\USA_EN3.png
tools\convert input\label.png -resize 54x18! output\label.png
tools\convert tools\EUR_EN3.png output\label.png -geometry +198+227 -composite output\EUR_EN3.png
del output\label.png
tools\convert input\banner.png -resize 42x42! output\tempicon.png
tools\convert tools\icon.png output\tempicon.png -gravity center -composite output\icon.png
del output\tempicon.png
tools\convert input\banner.png -resize 120x102! output\tempbanner.png
tools\convert tools\COMMON1.png output\tempbanner.png -geometry +4+6 -composite output\common1.png
tools\convert input\banner.png -resize 60x51! output\tempbanner.png
tools\convert tools\COMMON1_2.png output\tempbanner.png -geometry +2+3 -composite output\common1_2.png
tools\convert input\banner.png -resize 30x26! output\tempbanner.png
tools\convert tools\COMMON1_3.png output\tempbanner.png -geometry +1+1 -composite output\common1_3.png
del output\tempbanner.png
set lt=3
set lr=6
if %ln% EQU 2 ( set lt=1
set lr=20 )
tools\convert tools\USA_EN2.png -gravity center -font input\SCE-PS3-RD-R-LATIN.TTF -pointsize %f% -kerning %k% -interword-spacing 6 -interline-spacing %lt% -annotate +44+0 "%title%\n" -pointsize 14 -kerning 1.5 -interline-spacing %lr% -annotate +46+0 "\nReleased: %release%" output\USA_EN2.png
echo Done!