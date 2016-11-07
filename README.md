# OldSNES: SNES VC for Old 3DS users

INSTRUCTIONS:
- Create a folder for each game on the input folder (Earthbound, for example).
- Put your SNES rom on this folder.
- Put an icon image on this folder and rename it icon.png or icon.jpg. This can be whatever image you want for the home menu icon (a screenshot, for example).
- Run make_blarg.bat for blargSNES and make_snes9x.bat for Snes9x.
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
- Press Enter then DO NOT touch anything, just wait until it's done.

CUSTOM BORDERS AND CONFIG OVERRIDE (OPTIONAL, BLARGSNES ONLY):
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
- Run update_blarg.bat for blargSNES and update_snes9x.bat for Snes9x.
- OPTIONAL: If you want to add or replace files, put them into the folder you created for the game, then confirm when prompted to "include or update any extra files".
- OPTIONAL: If you want to delete existing files, go to the romfs folder and delete whichever file(s) you want. DO NOT DELETE ROM.SMC.


Credits:
- StapleButter and DiscostewSM for blargSNES.
- bubble2k16 for Snes9x 3DS.
- Asia81 for the SNES VC banner template.
