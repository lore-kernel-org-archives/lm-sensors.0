From: robs@multiplayer.it (robs@multiplayer.it)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: kernel 2.6.0test10 and sensors 2.8.1 CVS wrong temperature values
Message-Id: <1069852347.3fc4a6bb69deb@webmail.multiplayer.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I have 2.6.0test10 running with /sys mounted
My motherboard is an Asus A7n8x-8 rev2 (nforce2 chipset)

When I run sensors I get:
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Unavailable from sysfs
ERROR: data 1

as99127f-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Unavailable from sysfs
VCore 1:   +1.71 V  (min =  +1.49 V, max =  +1.81 V)
VCore 2:   +1.71 V  (min =  +1.49 V, max =  +1.81 V)
+3.3V:     +3.41 V  (min =  +2.98 V, max =  +3.63 V)
+5V:       +4.95 V  (min =  +4.52 V, max =  +5.48 V)
+12V:     +11.61 V  (min = +10.82 V, max = +13.13 V)
-12V:     -12.14 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.60 V  (min =  -0.00 V, max =  -0.00 V)
fan1:     4411 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
M/B Temp:     +4?C  (high =   +13?C, hyst =    +6?C)
CPU Temp:   +3.3?C  (high =   +12?C, hyst =   +10?C)
temp3:     +25.5?C  (high =   +12?C, hyst =   +10?C)
vid:      +1.650 V
alarms:   
beep_enable:
          Sound alarm enabled

The values are incorrect, CPU temp can't be 3.3?C (I don't usually havemy
computer in a fridge). The correct value would be between 40? and 50?for the CPU
and 20? and 30? for the M/B
Both the bios and the asus utility on Windows show the correct values



Regards,
Roberto Sebastiano

-------------------------------------------------------------
Servizio Webmail di Multiplayer.it http://www.multiplayer.it
