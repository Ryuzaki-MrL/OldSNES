@echo off
:begin
echo blargSNES -- Virtual Console Edition
set /p title=Game Title: 
if not exist "input\%title%\*.smc" if not exist "input\%title%\*.sfc" (
    echo ERROR: Missing rom file.
    echo Make sure you have a rom file in input\%title% folder.
    pause
    exit
)
set long=title
set /p long=Description: 
set /p author=Publisher: 
set /p serial=Product Code: 
set /p id=Unique Id: 
del /f /q romfs
if exist "input\%title%\*.smc" (
    copy /b "input\%title%\*.smc" romfs\rom.smc
) else (
    copy /b "input\%title%\*.sfc" romfs\rom.smc
)
if exist "input\%title%\*.bmp" copy /b "input\%title%\*.bmp" romfs\blargSnesBorder.bmp
if exist "input\%title%\*.ini" copy /b "input\%title%\*.ini" romfs\blargSnes.ini
if not exist "input\%title%\icon.png" if not exist "input\%title%\banner.png" (
    echo ERROR: Icon image not found.
    pause
    call :exit
)
if exist "input\%title%\icon.png" ( set file=icon.png
) else if exist "input\%title%\banner.png" set file=banner.png
tools\convert "input\%title%\%file%" -resize 42x42! output\tempicon.png
tools\convert tools\icon.png output\tempicon.png -gravity center -composite "output\%title%\icon.png"
del output\tempicon.png
tools\bannertool makesmdh -s "%title%" -l "%long%" -p "%author%" -i "output\%title%\icon.png" -o "icon.bin"
tools\3dstool -c -f banner.bin -t banner --banner-dir banner
echo %title%> romfs\rom.txt
tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID=0x%id% -DAPP_ROMFS="romfs"
del banner.bin
del icon.bin
del /f /q romfs
copy /b banner\backup banner
rmdir /s /q banner\backup
echo Done
set /p choice3="Do you want to build another CIA? (Y/N): "  %=%
if [%choice3%]==[Y] goto begin
if [%choice3%]==[y] goto begin
if [%choice3%]==[N] goto exit
if [%choice3%]==[n] goto exit

:exit
exit