From: tonu@jes.ee (Tonu Samuel)
Date: Sun, 16 Oct 2005 19:44:42 +0000
Subject: [lm-sensors] SE95 patch, try2
Message-Id: <200510162044.02898.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I did some work on Philips SE95 driver and got zero feedback on my previous 
posting with some questions. Newer patch is:

http://www.jes.ee/~tonu/se95.patch2

I modified original LM75 to accept more bits when sensor can do so. Some 
example output:

http://www.jes.ee/temp/cgi-bin/temp.cgi

Two sensors there SE95 and LM75 located few millimeters from each other but 
show nearly 3 degrees C difference! 

test:/usr/src # cat /sys/bus/i2c/devices/0-004a/temp1_input
17000
test:/usr/src # cat /sys/bus/i2c/devices/0-004e/temp1_input
3843
test:/usr/src # cat /sys/bus/i2c/devices/0-004f/temp1_input
14687
test:/usr/src #      
test:/usr/src # echo 20000 > /sys/bus/i2c/devices/0-004a/temp1_max_hyst
test:/usr/src # echo 20000 > /sys/bus/i2c/devices/0-004f/temp1_max_hyst
test:/usr/src # echo 20000 > /sys/bus/i2c/devices/0-004e/temp1_max_hyst
test:/usr/src # sensors
w83781d-isa-0290
Adapter: ISA adapter
VCore 1:   +1.46 V  (min =  +1.90 V, max =  +2.10 V)       ALARM
VCore 2:   +1.98 V  (min =  +1.90 V, max =  +2.10 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.49 V  (min = +11.37 V, max = +12.59 V)
-12V:     -11.29 V  (min = -12.57 V, max = -11.35 V)       ALARM
-5V:       -4.94 V  (min =  -5.25 V, max =  -4.74 V)
fan1:     3552 RPM  (min = 2812 RPM, div = 2)
fan2:        0 RPM  (min = 10714 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 3668 RPM, div = 2)              ALARM
temp1:       +21?C  (high =  +120?C, hyst =  +115?C)
temp2:     +19.5?C  (high =  +120?C, hyst =  +115?C)
temp3:     +17.0?C  (high =  +120?C, hyst =  +115?C)
vid:      +2.000 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled

lm75-i2c-0-4a
Adapter: SMBus PIIX4 adapter at 5000

temp:      +17.5?C  (high = +80.0?C, hyst = +20.0?C)

lm75-i2c-0-4e
Adapter: SMBus PIIX4 adapter at 5000

temp:       +3.8?C  (high = +80.0?C, hyst = +20.0?C)

lm75-i2c-0-4f
Adapter: SMBus PIIX4 adapter at 5000

temp:      +14.4?C  (high = +80.0?C, hyst = +20.0?C)

test:/usr/src #                                                          


If you like the way I did it, I go to shop and buy more sensors similar to 
LM75 and make it compatible with all of them. Plus detection of course :)

   Tonu
