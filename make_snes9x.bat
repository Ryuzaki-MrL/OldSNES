@echo off
:begin
cls
echo OldSNES -- SNES VC for Old 3DS users
echo Currently using: Snes9x
set /p "title=Game Title: "
if not exist "input\%title%\*.smc" if not exist "input\%title%\*.sfc" (
    echo ERROR: Missing rom file.
    echo Make sure you have a rom file in input\%title% folder.
    pause
    exit
)
set long=%title%
set /p "long=Description: "
set /p "author=Publisher: "
set /p "serial=Product Code: "
set /p "id=Unique Id: "
if not exist "output\%title%" mkdir "output\%title%"
if not exist romfs mkdir romfs
del /f /q romfs
if exist "input\%title%\*.smc" (
    copy /b "input\%title%\*.smc" romfs\rom.smc >NUL 2>NUL
) else (
    copy /b "input\%title%\*.sfc" romfs\rom.smc >NUL 2>NUL
)
if exist "input\%title%\*.bmp" copy /b "input\%title%\*.bmp" romfs\blargSnesBorder.bmp >NUL 2>NUL
if exist "input\%title%\*.ini" copy /b "input\%title%\*.ini" romfs\blargSnes.ini >NUL 2>NUL
if exist "input\%title%\icon.png" ( set file=icon.png
) else if exist "input\%title%\icon.bin" ( set file=icon.bin
) else if exist "input\%title%\icon.jpg" ( set file=icon.jpg
) else if exist "input\%title%\icon.jpeg" ( set file=icon.jpeg
) else if exist "input\%title%\banner.bin" ( set file=banner.bin
) else if exist "input\%title%\banner.png" ( set file=banner.png
) else if exist "input\%title%\banner.jpg" ( set file=banner.jpg
) else if exist "input\%title%\banner.jpeg" ( set file=banner.jpeg
) else (
    echo ERROR: Icon image not found.
    pause
    exit
)

if "%file%"=="icon.bin" set useBin=T
if "%file%"=="banner.bin" set useBin=T

if not "%useBin%"=="T" (
	tools\convert "input\%title%\%file%" -resize 40x40! output\tempicon.png
	tools\convert tools\icon.png output\tempicon.png -gravity center -composite "output\%title%\icon.png"
	del output\tempicon.png
	tools\bannertool makesmdh -s "%title%" -l "%long%" -p "%author%" -i "output\%title%\icon.png" -o "icon.bin" >NUL 2>NUL
	if not exist "output\%title%\banner.bin" tools\3dstool -c -f "output\%title%\banner.bin" -t banner --banner-dir banner
)

(echo %title%)>romfs\rom.txt
if not exist cia mkdir cia
if "%useBin%"=="T" (
	tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "input\%title%\icon.bin" -banner "input\%title%\banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID="0x%id%" -DAPP_ROMFS="romfs"
) else (	
	tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "cia\%title%.cia" -exefslogo -icon "icon.bin" -banner "output\%title%\banner.bin" -elf "tools\snes9x_3ds.elf" -DAPP_TITLE="%title%" -DAPP_PRODUCT_CODE="%serial%" -DAPP_UNIQUE_ID="0x%id%" -DAPP_ROMFS="romfs" >NUL 2>NUL
	del icon.bin
)
del /f /q romfs
if exist banner\backup (
    copy /b banner\backup banner >NUL 2>NUL
    rmdir /s /q banner\backup
)
echo Done
pause
cls
choice /C YN /M "Do you want to build another CIA?"
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 goto begin
