@echo off
echo blargSNES -- Virtual Console Edition
set /p title=Game Title: 
if not exist romfs\%title%.smc (
    echo ERROR: Missing rom file.
    echo Make sure you have a(n) %title%.smc file in the romfs folder.
    pause
    exit
)
set /p author=Publisher: 
set /p serial=Product Code: 
set /p id=Unique Id: 
set /p region=Region:
cd romfs
rename %title%.smc rom.smc
cd ..
tools\bannertool makesmdh -s "%title%" -l "%title%" -p "%author%" -i "output\%title%\icon.png" -o "icon.bin"
tools\3dstool -c -f banner.bin -t banner --banner-dir banner
echo %title%> romfs\rom.txt
tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID=0x%id% -DAPP_ROMFS="romfs"
del banner.bin
del icon.bin
del romfs\rom.txt
cd romfs
rename rom.smc %title%.smc
cd ..
cd banner
del banner0.bcmdl
rename banner0.bak banner0.bcmdl
del banner%region%.bcmdl
rename banner%region%.bak banner%region%.bcmdl
cd ..
echo Done
