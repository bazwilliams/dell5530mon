#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

RADIO=`python /home/barry/scripts/radio.py`

case $RADIO in
	"ON")
	/usr/bin/poff
	python /home/barry/scripts/radio.py off
	#sudo /usr/bin/aircraft-manager-util WIFI on
	OUTPUT="3G Disabled"
	;;
	"OFF")
	#sudo /usr/bin/aircraft-manager-util WIFI off
	python /home/barry/scripts/radio.py on
	#/usr/bin/pon &
	#/home/barry/scripts/enable_gps.sh wait &
	OUTPUT="3G Enabled"
esac

case $1 in
	gui)
	#	zenity --title="Mobile Broadband Radio State" --window-icon=/usr/share/pixmaps/vodafone.png --info --text="$OUTPUT"
		/home/barry/scripts/notify.py "Mobile Broadband" "$OUTPUT"
	;;
	*)
		echo $OUTPUT
esac
