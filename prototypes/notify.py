#!/usr/bin/env python

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

import pygtk
pygtk.require('2.0')
import pynotify
import sys

if not pynotify.init("Basics"):
	sys.exit(1)

URI="file://usr/share/pixmaps/vodafone.png"
n = pynotify.Notification(sys.argv[1],sys.argv[2],URI)

if not n.show():
	print "Failed to send notification"
	sys.exit(1)
