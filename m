From: chris@nfluid.co.uk (Chris Smith)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Tyan S2460 Followup Ticket #808
Message-Id: <02020510271900.01320@oberon>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guys, here are the i2cdumps and sensors output that were produced during the 
investigation of the HW monitoring chipsets of the Tyan S2460 Dual CPU MB.

[Linux 2.4.2-2 
 i2c-2.6.2
 lm_sensors-2.6.2 
 (running in userland)
]

This is a tricky one I suspect as both monitoring chips need to be detected 
and read to get a complete set of results.......

How these help.
If you need any other info, please let me know - it's a new machine and so 
Hangs/reboots are not a problem!

Regards,
Chris

-- 
Chris Smith
  Technical Architect - netFluid Technology Limited.
  "Internet Technologies, Distributed Systems and Tuxedo Consultancy"
  E: chris@nfluid.co.uk  W: http://www.nfluid.co.uk
-------------- next part --------------
w83627hf-i2c-0-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.71 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
VCore 2:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.77 V  (min =  +4.72 V, max =  +5.24 V)       ALARM  
+12V:      +9.54 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -12.85 V  (min = -10.90 V, max = -13.21 V)              
-5V:       -0.17 V  (min =  -4.76 V, max =  -5.26 V)       ALARM  
V5SB:      +5.51 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +2.04 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     2860 RPM  (min = 3497 RPM, div = 2)              ALARM  
fan2:     2884 RPM  (min = 5578 RPM, div = 2)              ALARM  
fan3:        0 RPM  (min =  760 RPM, div = 8)                     
temp1:       +40?C  (limit =  +29?C, hysteresis =  +80?C) sensor = 3904 transistor   ALARM   
temp2:     +33.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
temp3:     +40.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
vid:      +1.85 V
alarms:   Chassis intrusion detection                             
beep_enable:
          Sound alarm enabled

-------------- next part --------------
w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.76 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
VCore 2:   +1.90 V  (min =  +1.74 V, max =  +1.93 V)              
+3.3V:     +3.31 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.72 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +4.71 V  (min = +10.79 V, max = +13.19 V)              
-12V:      -2.11 V  (min = -10.90 V, max = -13.21 V)              
-5V:       +2.84 V  (min =  -4.76 V, max =  -5.26 V)              
V5SB:      +4.30 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.31 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:       +42?C  (limit =  +70?C, hysteresis =  +60?C) sensor = 3904 transistor           
temp2:     +40.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
temp3:     +43.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = 3904 transistor           
vid:      +1.85 V
alarms:   Chassis intrusion detection                      ALARM  
beep_enable:
          Sound alarm enabled

-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 6e 7b cf b0 4e 9c d2 2a ff ff ff 80 67 80 67 ed 
30: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
40: 03 d2 1f 00 00 00 00 f4 2d 02 01 80 01 15 00 a3 
50: ff ff 00 ff ff ff 00 80 30 00 ff ff 11 0e ff ff 
60: 6e 7c cf b0 4e 9c d2 2a ff ff ff 80 67 80 67 ed 
70: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: 6e 7b cf b0 4c 9d d2 2a ff ff ff 80 67 80 67 ed 
b0: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
c0: 03 00 10 00 00 00 00 f4 2d 02 01 80 01 15 00 a3 
d0: ff ff 00 ff ff ff 00 80 30 00 ff ff 11 0e ff ff 
e0: 6e 7b cf b0 4e 9d d2 2a ff ff ff 80 67 80 67 ed 
f0: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 6d 77 cf b0 4e 9b d2 4c ff ff ff 80 67 80 67 ed 
30: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
40: 01 d2 1f 00 00 00 00 54 2d 02 01 44 01 15 80 5c 
50: ff ff 80 ff ff ff 00 80 30 70 ff ff 11 00 ff ff 
60: 6e 77 cf b0 4d 9c d2 4c ff ff ff 80 67 80 67 ed 
70: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: 6e 77 cf b0 4e 9c d2 4c ff ff ff 80 67 80 67 ed 
b0: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
c0: 01 00 10 00 00 00 00 54 2d 02 01 44 01 15 80 5c 
d0: ff ff 00 ff ff ff 00 80 30 70 ff ff 11 00 ff ff 
e0: 6e 77 cf b0 4e 9c d2 4c ff ff ff 80 67 80 67 ed 
f0: b0 bc aa a8 8a 0c 29 31 3b 46 3c e1 e1 e1 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 6b 6b cd b2 9d 1a 96 4d 3c 3a ff 80 67 80 67 ed 
30: b0 8c c1 3f 05 0a c9 d9 29 1c 50 d5 79 dc 00 00 
40: 01 db 0b 00 00 00 00 f4 2c 02 01 c0 18 15 00 a3 
50: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 00 ff 05 
60: 6d 6b cd b2 9d 19 96 4d 3c 3a ff 80 67 80 67 ed 
70: b0 8c c1 3f 05 0a c9 d9 29 1c 50 d5 79 dc 00 00 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: 6c 6c cd b2 9d 1a 96 4d 3b 3b ff 80 67 80 67 ed 
b0: b0 8c c1 3f 05 0a c9 d9 29 1c 50 d5 79 dc 00 00 
c0: 01 10 00 00 00 00 00 f4 2c 02 01 c0 18 15 00 a3 
d0: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 00 ff 05 
e0: 6d 6c cd b2 9d 19 96 4d 3c 3a ff 80 67 80 67 ed 
f0: b0 8c c1 3f 05 0a c9 d9 29 1c 50 d5 79 dc 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
