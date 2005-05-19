From: mlists@you.oih.rwth-aachen.de (Hajo Noerenberg)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Follow up on ticket 954
Message-Id: <E17Xzdm-00039b-00@relay>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thank you very much for your quick answer ! I tried the
"force_subclients=0,0x2c,0x4a,0x4b"-option from ticket #840
yesterday and (of course - thats my fault) that did not
work (wrong chip address).

"modprobe w83781d force_subclients=0,0x2a,0x4a,0x4b" works
and both sensors are detected:

# sensors
w83782d-i2c-0-29
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.48 V  (min =  +1.37 V, max =  +1.52 V)       ALARM  
VCore 2:   +1.24 V  (min =  +1.37 V, max =  +1.52 V)              
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +5.07 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:     +12.08 V  (min = +10.79 V, max = +13.19 V)              
-12V:      -1.03 V  (min = -13.21 V, max = -10.90 V)              
-5V:       +2.84 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +5.11 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.32 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     6136 RPM  (min = 3000 RPM, div = 2)                     
fan2:     6617 RPM  (min = 3000 RPM, div = 2)                     
fan3:     7336 RPM  (min = 3000 RPM, div = 2)                     
temp1:       +44?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp2:     +18.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp3:     +18.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
vid:       +1.45 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

w83782d-i2c-0-2a
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
VCore 1:   +0.01 V  (min =  +0.00 V, max =  +0.00 V)       ALARM  
VCore 2:   +0.01 V  (min =  +0.00 V, max =  +0.00 V)       ALARM  
+3.3V:     +0.01 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +5.07 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +0.04 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -14.86 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -7.68 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +0.02 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.36 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:      +127?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp2:    +127.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
temp3:    +127.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor           
vid:       +0.00 V
alarms:   
beep_enable:
          Sound alarm disabled
#

Values from BIOS:
CPU1 - Temp:		37 - 38  	?C 
CPU2 - Temp:		37		?C
System - Temp:	42		?C
CPU1 - Fan:		3750 - 3792 	RPM
CPU1 - Fan:		3924 - 4017 	RPM
Chassis - Fan:	4326 - 4500	RPM
VCore:			1.47 - 1.48	V
Vcc +3.3V:		+3,36 - 3.37	V
Vcc +5V:		+5.08		V
Vcc +12V		+12.54		V

Comments:

1.) w83782d-i2c-0-2a does not seem to produce any usable values (with
different sensor types)
2.) w83782d-i2c-0-29 gets close(r) to the real values with sensor 3904 transistor (2)
3.) fan values are ~ 200%, temp2 and temp3 are ~ 50% of real values (wrong compute lines?)
4.) temp1 probably is the correct system temp 
5.) -12V and -5V seem to be measured by the same transistors as temp2/3 (values
change if you change sensor type)

I'll investigate further on that next week and provide feedback.

Thank you,
Hajo



