#!/bin/bash
clear
echo "LCD to OLED Mod Reverter by annson24"
echo "https://github.com/annson24/SteamDeck-LCDtoOLED-Mod"
echo

# define paths
echo "Defining paths..."
sleep 1
script_dir="$(dirname "$(readlink -f "$0")")"
splash_orig_lcd="/usr/share/plymouth/themes/steamos/steamos-jupiter.png"
bgrt_logo="/esp/efi/steamos/steamos.png"
mov_dir_orig="/home/deck/.local/share/Steam/steamui"
bak_dir="$script_dir/LCDtoOLEDModBackup"
echo "Done!"

# restore files
echo "Restoring backups..."
sleep 1
if [ -d "$bak_dir" ]; then
	sudo rm "$bgrt_logo"
	sudo cp -f "$bak_dir/steamos-jupiter.png" "$splash_orig_lcd"
	sudo cp -rf "$bak_dir" "$mov_dir_orig/"
	echo "Done!"
	sleep 2
	clear
	echo "LCD to OLED Mod Reverter by annson24"
	echo "https://github.com/annson24/SteamDeck-LCDtoOLED-Mod"
	echo
	echo
	echo "Restoration completed successfully!"
	echo
else
	echo "Error: Backup directory not found. No restoration performed."
fi