#!/bin/bash
clear
echo "LCD to OLED Mod by annson24"
echo "https://github.com/annson24"

# define paths

# splash_orig="/usr/share/plymouth/themes/steamos/steamos-
splash_temp="steamos-jupiter.png"
bgrt_logo="/esp/efi/steamos/steamos.png"
univ_splash="/usr/share/plymouth/themes/steamos/steamos-jupiter.png"
mov_dir_orig="/home/deck/.local/share/Steam/steamui"
mov_dir_temp="/movies"

# pull original splash file
sudo cp -f "$splash_orig" "$splash_temp"

# BGRT Logo change
sudo cp -f "$splash_temp" "$bgrt_logo"

# universal splash screen change
truncate --size=17550 "$splash_temp"
sudo cp -f "$splash_temp" "$univ_splash"

# pull original video files
mkdir "$mov_dir_temp"
sudo cp -f "$mov_dir_orig/oled_startup.webm" "$mov_dir_temp/deck_startup.webm"
sudo cp -f "$mov_dir_orig/oled-suspend-animation.webm" "$mov_dir_temp/deck-suspend-animation.webm"
sudo cp -f "$mov_dir_orig/oled-suspend-animation-from-throbber.webm" "$mov_dir_temp/deck-suspend-animation-from-throbber.webm"

# resize video files
truncate --size=1840847 "$mov_dir_temp/deck_startup.webm"
truncate --size=160008 "$mov_dir_temp/deck-suspend-animation.webm"
truncate --size=323401 "$mov_dir_temp/deck-suspend-animation-from-throbber.webm"

# boot & sleep video change
sudo cp -rf "$mov_dir_temp" "$mov_dir_orig/"

echo "Tasks completed successfully!"

# cleanup
rm -f "$splash_temp"
rm -rf "$mov_dir_temp"
rm -f "$0"