# blargSNES Virtual Console Edition

INSTRUCTIONS:
<<<<<<< HEAD
- Put your SNES rom on the romfs folder.
- Rename it rom.smc.
=======
-  Put your SNES rom on the romfs folder.
-  Rename it rom.smc.
>>>>>>> 870f7ce81efcb5214da927541fecc01729467fe7
- Run make.bat.
- Type in the game's title, publisher, product code (whatever you want) and unique id (whatever you want from 000000 to ffffff).
- Install the generated CIA file.
- Enjoy.
<<<<<<< HEAD

MAKING CUSTOM BANNER AND ICON (OPTIONAL):
- Put a screenshot of the game on the input folder.
=======


MAKING CUSTOM BANNER AND ICON (OPTIONAL):
-  Put a screenshot of the game on the input folder.
>>>>>>> 870f7ce81efcb5214da927541fecc01729467fe7
- Rename it banner.png.
- Put a box art or cartridge label image of the game on the input folder.
- Rename it label.png.
- OPTIONAL: If you want your custom banner as much accurate as possible to the oficial VC, search for SCE-PS3-RD-R-LATIN.TTF on google
<<<<<<< HEAD
  and put it on the input folder.
=======
   and put it on the input folder.
>>>>>>> 870f7ce81efcb5214da927541fecc01729467fe7
- Run banner.bat.
- Type in the game's title and release year.
- OPTIONAL: set the banner text's font size, number of lines and spacing: Leave it blank to use default values.
- Navigate to the tools folder and start Ohana3DS.exe.
- Select the Textures tab then click Open.
- Navigate to the banner folder and select banner0.bcmdl.
- Select COMMON1 and click Import.
- Navigate to the output folder and select COMMON1.png.
- Repeat steps 11 and 12 with COMMON1_2 and COMMON1_3, selecting COMMON1_2.png and COMMON1_3.png.
- Save your changes then click Open again.
- Navigate to the banner folder again, and select the banner file matching your console's region and language.
    banner1.bcmdl = English ~ EUR_EN
    banner2.bcmdl = French ~ EUR_FR
    banner3.bcmdl = German ~ EUR_GE
    banner4.bcmdl = Italian ~ EUR_IT
    banner5.bcmdl = Spanish ~ EUR_SP
    banner6.bcmdl = Dutch ~ EUR_DU
    banner7.bcmdl = Portuguese ~ EUR_PO
    banner8.bcmdl = Russian ~ EUR_RU
    banner9.bcmdl = Japanese ~ JPN_JP
    banner10.bcmdl = English ~ USA_EN
    banner11.bcmdl = French ~ USA_FR
    banner12.bcmdl = Spanish ~ USA_SP
    banner13.bcmdl = Portuguese ~ USA_PO
- Select the first file and click Import.
- Navigate to the output folder and select USA_EN2.png.
- Select the next file and click Import.
- Select EUR_EN3.png or USA_EN3.png, depending on your 3DS's region.
- Save your changes then exit Ohana3DS.
<<<<<<< HEAD

CUSTOM BORDERS AND CONFIG OVERRIDE (OPTIONAL):
- Put your border on the romfs folder. Should be named blargSnesBorder.bmp
- Go to config folder and select a config template.
    Mode7: for roms that need hardware assisted mode7 (see compatibility list).
    Normal: for every other rom.
    Borders: sets scaling to 1:1 so you can use a custom border.
    Fullscreen: sets scaling to fullscreen.
- Copy the config template to romfs.
Note: You need to use config override if using custom borders, but don't need custom borders to use config override.

UPDATING EXISTING CIAS:
- Put all of yours cias inside the cia folder (keep a backup of them just in case something goes wrong).
- Run update.bat.
=======
- Now follow the instructions on how to build your CIA.
>>>>>>> 870f7ce81efcb5214da927541fecc01729467fe7


Credits:
- StapleButter and DiscostewSM for blargSNES.
- Asia81 for the SNES VC banner template.
