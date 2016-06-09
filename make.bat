@echo off
echo blargSNES -- Virtual Console Edition
if not exist romfs\rom.smc (
    echo ERROR: Missing rom file.
    echo Make sure you have a rom.smc file on the romfs folder.
    pause
    exit
)
set /p title=Game Title: 
set /p author=Publisher: 
set /p serial=Product Code: 
set /p id=Unique Id: 
tools\bannertool makesmdh -s "%title%" -l "%title%" -p "%author%" -i "output\icon.png" -o "icon.bin"
tools\3dstool -c -f banner.bin -t banner --banner-dir banner
echo %title%> romfs\rom.txt
tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID=0x%id% -DAPP_ROMFS="romfs"
del banner.bin
del icon.bin
del romfs\rom.txt
echo Done!