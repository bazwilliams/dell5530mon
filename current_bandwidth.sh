#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

vnstat -u -i ppp0 > /dev/null

#DATE=`date "+%b '%y"`
#As suggested by Alexander in comments (http://www.bjw.me.uk/2009/03/dell-5530ericsson-f3507g-on-linux.html)
DATE=`LANG=en_US.UTF-8 date "+%b '%y"`
MONTH_BANDWIDTH=`vnstat -m | grep "${DATE}"`
CURRENT_BANDWIDTH=`echo $MONTH_BANDWIDTH | awk '{print $9}'`
UNITS=`echo $MONTH_BANDWIDTH | awk '{print $10}'`
MAX_BANDWIDTH_GB=3
case "$1" in
	current)
		echo $CURRENT_BANDWIDTH $UNITS
	;;
	max)
		echo $MAX_BANDWIDTH_GB GB
	;;
	gui)
		zenity --title="Mobile Broadband" --window-icon=/usr/share/pixmaps/vodafone.png --info --text="Bandwidth used this month ($DATE):\n$CURRENT_BANDWIDTH $UNITS / $MAX_BANDWIDTH_GB GB"
	;;
	perc)
		case "$UNITS" in
		"GiB")
			echo "100 * $CURRENT_BANDWIDTH / $MAX_BANDWIDTH_GB" | bc -l
		;;
		"MiB")
			echo "$CURRENT_BANDWIDTH / $MAX_BANDWIDTH_GB * 0.1" | bc -l
		;;
		"kiB")
			echo "$CURRENT_BANDWIDTH / $MAX_BANDWIDTH_GB * 0.001" | bc -l
		;;
		esac
	;;
	*)
		echo "Usage: $0 {current|max|gui|perc}"
	;;
esac
