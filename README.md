# Dell 5530 / Ericsson f3507g 3G Signal Monitor for Linux

The code `dell5530_mon.py`, `radio.py` and `current_bandwidth.sh` are covered under a Creative Commons Attribute-Share Alike licence.  The SVG icons are taken from the /usr/share/icons/Human/scalable/status folder - not entirely sure what licence they are covered under.  They are unmodified and distributed in case the are not available on the users computer.  

Usage:

    dell5530_mon.py <SERIAL> <INSTALLLOCATION>

For example:

    ~/scripts/dell5530_mon/dell5530_mon.py /dev/ttyACM0 ~/scripts/dell5530_mon

Will run the monitor using serial device at `/dev/ttyACM0` and will use the icon folder in `~/scripts/dell5530_mon` along with the shell script for bandwidth usage.  

If you have vnstat installed and configured to monitor ppp0, then clicking on the status icon will display the current months bandwidth usage (download + upload) as a notification.  

The monitor will display a notification if the network changes or the network access type changes (e.g. GPRS -> 3G or 3G -> 3G+).  

The icon will automatically update depending on the signal strength and access type.  

Right clicking the icon will open a context menu offering an ability to change the radio state from Normal (which prefers 3G), UMTS/HSPA which forces 3G only and GPRS which forces GPRS only connections.  The radio can also be switched off from the same menu.  

Under `NetworkManagerDispatcher.d` is a configuration file to start the monitor whenever the connection is enabled via Network Manager (or at least used to with Ubuntu 9.10). 

Under `prototypes` is some random scripts which may be useful, for example enabling the GPS chip, starting the connection via a wvdial script or toggling the radio. These are not used within the main application, but relevant. 

Any suggestions for this program most welcome!  

Many of the AT commands used in this program have been sniffed out from monitoring the serial port in windows in between the modem and both Vodafone Mobile Connect and Ericsson's Connect Software.  

Barry John Williams 
https://github.com/bazwilliams/dell5530mon

Acknowledgements to:
<arno@natisbad.org> http://www.natisbad.org/E4300/Dell_Wireless_5530_AT_cmd_ref.html
Alexander (comments in http://blog.bjw.me.uk/2009/03/dell-5530ericsson-f3507g-on-linux.html) for making current_bandwidth.sh locale independent
