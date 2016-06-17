@echo off
:begin
cls
echo blargSNES -- Virtual Console Edition
set /p "title=Game Title: "
if not exist "input\%title%\*.smc" if not exist "input\%title%\*.sfc" (
    echo ERROR: Missing rom file.
    echo Make sure you have a rom file in input\%title% folder.
    pause
    exit
)
set long=%title%
set /p "long=Description: "
if not exist "output\%title%" mkdir "output\%title%"
set /p "author=Publisher: "
set /p "serial=Product Code: "
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
    exit
)
if exist "input\%title%\icon.png" ( set file=icon.png
) else if exist "input\%title%\banner.png" set file=banner.png
tools\convert "input\%title%\%file%" -resize 42x42! output\tempicon.png
tools\convert tools\icon.png output\tempicon.png -gravity center -composite "output\%title%\icon.png"
del output\tempicon.png
tools\bannertool makesmdh -s "%title%" -l "%long%" -p "%author%" -i "output\%title%\icon.png" -o "icon.bin"
if not exist "output\%title%\banner.bin" tools\3dstool -c -f "output\%title%\banner.bin" -t banner --banner-dir banner
(echo %title%)>romfs\rom.txt
tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "output\%title%\banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID=0x%id% -DAPP_ROMFS="romfs"
del icon.bin
del /f /q romfs
if exist banner\backup (
    copy /b banner\backup banner
    rmdir /s /q banner\backup
)
echo Done
pause
cls
choice /C YN /M "Do you want to build another CIA?"
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 goto begin
