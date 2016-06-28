# blargSNES Virtual Console Edition

INSTRUCTIONS:
- Create a folder for each game on the input folder (Earthbound, for example).
- Put your SNES rom on this folder.
- Put an icon image on this folder and rename it icon.png or icon.jpg. This can be whatever image you want for the home menu icon (a screenshot, for example).
- Run make.bat.
- Type in the game's title, description (optional), publisher, product code (SNS-MW-USA, for example), and unique id (whatever you want from 00000 to fffff).
- Install the generated CIA file.
- Enjoy.

Note: If you don't provide an icon image, banner.png/banner.jpg will be used for the icon instead.


CUSTOM BANNER (OPTIONAL):
- Put a screenshot of the game on the folder you created for the game, and rename it banner.png or banner.jpg.
- OPTIONAL: Put a box art or cartridge label image of the game on the folder you created for the game, and rename it label.png or label.jpg.
- Run banner.bat.
- Type in the game's title and release year.
- OPTIONAL: Type in the virtual console's title (the title that will be appear on the banner).
- OPTIONAL: Set the banner text's font size, number of lines, letter spacing and word spacing. Leave it blank to use default values.
- IF YOU HAVE PYTHON 2.7 INSTALLED:
    - Don't touch anything, just wait until it's done.
- IF YOU DON'T HAVE PYTHON 2.7 INSTALLED:
    - Press Y to open Ohana3DS, when prompted.
    - Select the Textures tab then click Open.
    - Navigate to the banner folder and select banner0.bcmdl.
    - Select COMMON1 and click Import.
    - Navigate to the output folder, then to the game's folder, and select COMMON1.png.
    - Repeat steps 11 and 12 with COMMON1_2 and COMMON1_3, selecting COMMON1_2.png and COMMON1_3.png.
    - Save your changes then click Open again.
    - Navigate to the banner folder again, and select the banner file matching your console's region and language.
      - banner1.bcmdl = English ~ EUR_EN
      - banner2.bcmdl = French ~ EUR_FR
      - banner3.bcmdl = German ~ EUR_GE
      - banner4.bcmdl = Italian ~ EUR_IT
      - banner5.bcmdl = Spanish ~ EUR_SP
      - banner6.bcmdl = Dutch ~ EUR_DU
      - banner7.bcmdl = Portuguese ~ EUR_PO
      - banner8.bcmdl = Russian ~ EUR_RU
      - banner9.bcmdl = Japanese ~ JPN_JP
      - banner10.bcmdl = English ~ USA_EN
      - banner11.bcmdl = French ~ USA_FR
      - banner12.bcmdl = Spanish ~ USA_SP
      - banner13.bcmdl = Portuguese ~ USA_PO
    - Select the first file and click Import.
    - Navigate to the output folder, then to the game's folder, and select USA_EN2.png.
    - Select the next file and click Import.
    - Select EUR_EN3.png or USA_EN3.png, depending on the selected banner's region.
    - Repeat for every other region if you want.
    - Save your changes then exit Ohana3DS.

CUSTOM BORDERS AND CONFIG OVERRIDE (OPTIONAL):
- Put your border on the folder you created for the game. It can be named whatever you want, as long as it is a .bmp image file.
- Go to config folder and select a config template.
  - Mode7: activate Mode 7 filtering.
  - Normal: normal template.
  - Borders: sets scaling to 1:1 so you can use a custom border.
  - Fullscreen: sets scaling to fullscreen.
- Copy the config template to the folder you created for the game.

Note: You need to use the "borders" config template if using custom borders.


UPDATING EXISTING CIAS:
- Put all of yours cias inside the cia folder (keep a backup of them just in case something goes wrong).
- Run update.bat.
- OPTIONAL: If you want to add or replace files, put them into the folder you created for the game, then confirm when prompted to "include or update any extra files".
- OPTIONAL: If you want to delete existing files, go to the romfs folder and delete whichever file(s) you want. DO NOT DELETE ROM.SMC.


Credits:
- StapleButter and DiscostewSM for blargSNES.
- Asia81 for the SNES VC banner template.
