#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

RADIO=`python /home/barry/scripts/radio.py 2> /dev/null`

case $RADIO in
	"ON")
	rm /tmp/signal
	wvdial signal 2> /tmp/signal
	PROVIDER=`cat /tmp/signal | grep +COPS: | sed 's/+COPS: //g' | awk -F , '{print $3}' | sed 's/"//g'`
	ACT=`cat /tmp/signal | grep +COPS: | sed 's/+COPS: //g' | awk -F , '{print $4}' | sed 's/"//g'`

	case $ACT in
		"0 ")
			## GSM (GPRS)
	
			CSQ=`cat /tmp/signal | grep +CSQ: | sed 's/+CSQ: //g' | awk -F , '{print $1}'`
			#following calculation taken from http://www.gprsmodems.co.uk/acatalog/Technical_Topics.html
			RSSI=`echo "-113 + $CSQ * 2" | bc`
			PERCENTAGE=`echo "100 * $CSQ / 31" | bc`
			NETWORK="$PROVIDER (GPRS)"
			SIGNAL="$PERCENTAGE % ($RSSI dBm)"
		;;
		"2 ")
			## UTRAN (3G)

			## don't know how to calculate signal strength here...  
			NETWORK="$PROVIDER (3G)"
			SIGNAL=""
		;;
		*)
			NETWORK="No Network"
			SIGNAL=""
	esac
	;;
	"OFF")
		NETWORK="Radio Off"
		SIGNAL=""
	;;
	**)
		NETWORK="Comms Error"
		SIGNAL=""
	;;
esac

OUTPUT="Network: $NETWORK \nSignal: $SIGNAL"
case $1 in
	gui)
		zenity --title="Mobile Broadband Signal" --window-icon=/usr/share/pixmaps/vodafone.png --info --text="$OUTPUT"
	;;
	network)
		echo $NETWORK
	;;
	signal)
		echo $SIGNAL
	;;
	*)
		echo $OUTPUT
esac
