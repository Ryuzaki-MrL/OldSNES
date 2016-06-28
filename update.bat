@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p quick="Do a quick update? This will update all CIAs without pausing or asking for individual romfs updates (Y/N): " %=% 
if [!quick!]==[Y] set mode=1
if [!quick!]==[y] set mode=1
if [!quick!]==[N] set mode=0
if [!quick!]==[n] set mode=0

set n=0

for /f "delims=" %%i in ('dir /b /s "*.cia"') do (
    cls
    echo Updating %%i...
    echo !n! CIAS UPDATED
    
    tools\ctrtool -x -t cia --contents ncch "%%i" >NUL 2>NUL
    for /f "delims=" %%j in ('dir /b /s "ncch*.*"') do (
        tools\ctrtool -x -t ncch --exefsdir exefs --romfsdir romfs "%%j" >NUL 2>NUL
        del "%%j"
    )
    
    tools\ciainfo "%%i"

    <info.txt (
        set /p "id="
        set /p "serial="
        set /p "title="
        set /p "long="
        set /p "author="
    )
    del info.txt
    
    if !mode! EQU 0 (
        set /p choice="Do you want to include or update any extra files for !title!? (Y/N): " %=% 
        if [!choice!]==[Y] (
            if exist "input\!title!\*.bmp" copy /b "input\!title!\*.bmp" romfs\blargSnesBorder.bmp
            if exist "input\!title!\*.ini" copy /b "input\!title!\*.ini" romfs\blargSnes.ini
            if exist "input\!title!\*.smc" (
                copy /b "input\!title!\*.smc" romfs\rom.smc
            ) else if exist "input\!title!\*.sfc" (
                copy /b "input\!title!\*.sfc" romfs\rom.smc
            )
        )
        if [!choice!]==[y] (
            if exist "input\!title!\*.bmp" copy /b "input\!title!\*.bmp" romfs\blargSnesBorder.bmp
            if exist "input\!title!\*.ini" copy /b "input\!title!\*.ini" romfs\blargSnes.ini
            if exist "input\!title!\*.smc" (
                copy /b "input\!title!\*.smc" romfs\rom.smc
            ) else if exist "input\!title!\*.sfc" (
                copy /b "input\!title!\*.sfc" romfs\rom.smc
            )
        )
        echo Change long title and author [OPTIONAL]
        set /p long="Description: "
        set /p author="Author: "
    )
    
    if exist "input\!title!\icon.png" ( set "file=input\!title!\icon.png"
    ) else if exist "input\!title!\icon.jpg" ( set "file=input\!title!\icon.jpg"
    ) else if exist "input\!title!\icon.jpeg" ( set "file=input\!title!\icon.jpeg"
    ) else if exist "input\!title!\banner.png" ( set "file=input\!title!\banner.png"
    ) else if exist "input\!title!\banner.jpg" ( set "file=input\!title!\banner.jpg"
    ) else if exist "input\!title!\banner.jpeg" ( set "file=input\!title!\banner.jpeg"
    ) else set file=":none"
    
    if exist "!file!" (
        tools\convert "!file!" -resize "40x40^!" output\tempicon.png
        tools\convert tools\icon.png output\tempicon.png -gravity center -composite "output\!title!\icon.png"
        del output\tempicon.png
        tools\bannertool makesmdh -s "!title!" -l "!long!" -p "!author!" -i "output\!title!\icon.png" -o "exefs\icon.bin" >NUL 2>NUL
    )
    
    tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "%%i" -exefslogo -icon "exefs\icon.bin" -banner "exefs\banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="!title!" -DAPP_PRODUCT_CODE="!serial!" -DAPP_UNIQUE_ID=0x!id! -DAPP_ROMFS="romfs" >NUL 2>NUL
    rmdir /s /q exefs
    del /f /q romfs
    set /a n+=1
    if !mode! EQU 0 pause
)
echo All CIAs were updated