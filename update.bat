@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "delims=" %%i in ('dir /b /s "*.cia"') do (
    echo Updating %%i...
    tools\ciainfo "%%i"
    < info.txt (
        set /p "id="
        set /p "serial="
        set /p "title="
    )
    echo !id!
    echo !serial!
    echo !title!
    pause
    tools\ctrtool -x -t cia --contents ncch "%%i"
    for /f "delims=" %%j in ('dir /b /s "ncch*.*"') do (
        tools\ctrtool -x -t ncch --exefsdir exefs --romfsdir romfs "%%j"
        del "%%j"
    )
    tools\makerom -f cia -target t -rsf "tools\custom.rsf" -o "%%i" -exefslogo -icon "exefs\icon.bin" -banner "exefs\banner.bin" -elf "tools\blargSnes.elf" -DAPP_TITLE="!title!" -DAPP_PRODUCT_CODE="!serial!" -DAPP_UNIQUE_ID=0x!id! -DAPP_ROMFS="romfs"
    rmdir /s /q exefs
    del /f /q romfs
    del info.txt
    echo Done
)
echo All CIAs were updated