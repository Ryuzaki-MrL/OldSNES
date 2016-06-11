@echo off
echo blargSNES -- Virtual Console Edition
set /p title=Game Title: 
if not exist "input\%title%\*.smc" if not exist "input\%title%\*.sfc" (
    echo ERROR: Missing rom file.
    echo Make sure you have a rom file in input\%title% folder.
    pause
    exit
)
set /p author=Publisher: 
set /p serial=Product Code: 
set /p id=Unique Id: 
if exist "input\%title%\*.smc" (
    copy /b "input\%title%\*.smc" romfs\rom.smc
) else (
    copy /b "input\%title%\*.sfc" romfs\rom.smc
)
if exist "input\%title%\*.bmp" copy /b "input\%title%\*.bmp" romfs\blargSnesBorder.bmp
if exist "input\%title%\*.ini" copy /b "input\%title%\*.ini" romfs\blargSnes.ini
tools\bannertool makesmdh -s "%title%" -l "%title%" -p "%author%" -i "output\%title%\icon.png" -o "icon.bin"
tools\3dstool -c -f banner.bin -t banner --banner-dir banner
echo %title%> romfs\rom.txt
tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID=0x%id% -DAPP_ROMFS="romfs"
del banner.bin
del icon.bin
del /f /q romfs
copy /b banner\backup banner
rmdir /s /q banner\backup
echo Done
