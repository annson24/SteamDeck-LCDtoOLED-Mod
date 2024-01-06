#!/bin/bash
clear
echo "LCD to OLED Mod by annson24"
echo "https://github.com/annson24/SteamDeck-LCDtoOLED-Mod"
echo

# define paths
echo "Defining paths..."
sleep 1
script_dir="$(dirname "$(readlink -f "$0")")"
splash_orig_oled="/usr/share/plymouth/themes/steamos/steamos-galileo.png"
splash_orig_lcd="/usr/share/plymouth/themes/steamos/steamos-jupiter.png"
splash_temp="$script_dir/steamos-jupiter.png"
bgrt_logo="/esp/efi/steamos/steamos.png"
univ_splash="/usr/share/plymouth/themes/steamos/steamos-jupiter.png"
mov_dir_orig="/home/deck/.local/share/Steam/steamui"
mov_dir_temp="$script_dir/movies"
bak_dir="$script_dir/LCDtoOLEDModBackup"
echo "Done!"

# backup original files
echo "Creating backups..."
sleep 1
mkdir -p "$bak_dir"

if [ -e "$bak_dir/steamos-jupiter.png" ]; then
    : # File exists, do nothing
else
	sudo cp "$splash_orig_lcd" "$bak_dir/steamos-jupiter.png"
fi

if [ -e "$bak_dir/deck_startup.webm" ]; then
    : # File exists, do nothing
else
	sudo cp "$mov_dir_orig/movies/oled_startup.webm" "$bak_dir/deck_startup.webm"
fi

if [ -e "$bak_dir/deck-suspend-animation.webm" ]; then
    : # File exists, do nothing
else
	sudo cp "$mov_dir_orig/movies/oled-suspend-animation.webm" "$bak_dir/deck-suspend-animation.webm"
fi

if [ -e "$bak_dir/deck-suspend-animation-from-throbber.webm" ]; then
    : # File exists, do nothing
else
	sudo cp "$mov_dir_orig/movies/oled-suspend-animation-from-throbber.webm" "$bak_dir/deck-suspend-animation-from-throbber.webm"
fi
echo "Done!"

echo
echo "Initializing mod..."
sleep 2
echo

# Splash screen change
echo "Modding splashes"
sleep 1
sudo cp -f "$splash_orig_oled" "$splash_temp"
sudo cp -f "$splash_temp" "$bgrt_logo"
truncate --size=17550 "$splash_temp"
sudo cp -f "$splash_temp" "$univ_splash"
echo "Done!"

# Boot & sleep video change
echo "Modding boot & sleep videos"
sleep 1
mkdir -p "$mov_dir_temp"
sudo cp -f "$mov_dir_orig/movies/oled_startup.webm" "$mov_dir_temp/deck_startup.webm"
sudo cp -f "$mov_dir_orig/movies/oled-suspend-animation.webm" "$mov_dir_temp/deck-suspend-animation.webm"
sudo cp -f "$mov_dir_orig/movies/oled-suspend-animation-from-throbber.webm" "$mov_dir_temp/deck-suspend-animation-from-throbber.webm"
truncate --size=1840847 "$mov_dir_temp/deck_startup.webm"
truncate --size=160008 "$mov_dir_temp/deck-suspend-animation.webm"
truncate --size=323401 "$mov_dir_temp/deck-suspend-animation-from-throbber.webm"
sudo cp -rf "$mov_dir_temp" "$mov_dir_orig/"
echo "Done!"
sleep 2
clear
echo "LCD to OLED Mod by annson24"
echo "https://github.com/annson24/SteamDeck-LCDtoOLED-Mod"
echo
echo
echo "Tasks completed successfully!"
echo

# cleanup
rm -f "$splash_temp"
rm -rf "$mov_dir_temp"
rm -f "$0"
