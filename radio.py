#!/usr/bin/python

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

import serial
import sys

STR_OFF = 'OFF'
STR_ON = 'ON'
STR_ERROR = 'ERROR'
STR_PREFER = 'PREFER'
STR_UMTS = 'UMTS'
STR_GPRS = 'GPRS'

PREFER = 1
GPRS = 5
UMTS = 6

def on(ser, type):
	ser.write('ATZ E0 V1 X4 &C1\r\n')
	ser.readline()
	ser.flushOutput()
	ser.flushInput()
	ser.write('AT+CFUN='+str(type)+'\r\n')
	response = [r.replace('\r\n', '') for r in ser.readlines()
		if not r.startswith(('^', '_')) and r.replace('\r\n','')]

def off(ser):
	ser.write('AT+CFUN=4\r\n')
	response = [r.replace('\r\n', '') for r in ser.readlines()
		if not r.startswith(('^', '_')) and r.replace('\r\n','')]

def status(ser):
	ser.write('AT+CFUN?\r\n')
	response = [r.replace('\r\n', '') for r in ser.readlines()
		if not r.startswith(('^', '_')) and r.replace('\r\n','')]
	if len(response) > 2:
		output = response[1].replace('+CFUN: ','')
		if (output == '1'):
			return STR_PREFER
		elif (output == '4'):
			return STR_OFF
		elif (output == '5'):
			return STR_GPRS
		elif (output == '6'):
			return STR_UMTS
	else:
		return STR_ERROR

if __name__ == '__main__':
	ser = serial.Serial('/dev/ttyACM0', 19200, timeout=0.2)

	for arg in sys.argv:
		if arg in ("ON","on"):
			on(ser,UMTS)
		elif arg in ("OFF","off"):
			off(ser)
		
	print status(ser)

	ser.close()
