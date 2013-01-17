#!/usr/bin/python

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

import serial

ser = serial.Serial('/dev/ttyACM2', 19200, timeout=2)
ser.write('AT S7=45 S0=0 L1 V1 X4 &c1 E0 Q0\r\n')
response = [r.replace('\r\n', '') for r in ser.readlines()
	if not r.startswith(('^', '_')) and r.replace('\r\n','')]
print response
ser.flushOutput()
ser.flushInput()

ser.write('AT*E2GPSCTL=1,2,1\r\n')
response = [r.replace('\r\n', '') for r in ser.readlines()
	if not r.startswith(('^', '_')) and r.replace('\r\n','')]
print response
ser.flushOutput()
ser.flushInput()

ser.write('AT*E2GPSNPD\r\n')
response = [r.replace('\r\n', '') for r in ser.readlines()
	if not r.startswith(('^', '_')) and r.replace('\r\n','')]
print response
ser.flushOutput()
ser.flushInput()

ser.close()
