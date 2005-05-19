From: twisti@gmx.net (TWISTI)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: tyan S2460
Message-Id: <1015780374.550.3.camel@sector17.home.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As in ticket #813 described, i initialized the chip with bios. There i
had values like this:

CPU0: 52C
FAN0: 2743
CPU1: 56C
FAN1: 2700

After booting and inserting the module with:

modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b

I got this:

w83627hf-i2c-2-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.64 V, max =  +2.04 V)       ALARM  
VCore 2:   +1.71 V  (min =  +1.64 V, max =  +2.04 V)       ALARM  
+3.3V:     +3.28 V  (min =  +2.81 V, max =  +3.79 V)              
+5V:       +4.84 V  (min =  +6.37 V, max =  +5.98 V)              
+12V:      +9.65 V  (min = +10.56 V, max = +13.49 V)              
-12V:     -12.29 V  (min =  +6.06 V, max =  -7.77 V)              
-5V:       -0.05 V  (min =  +3.28 V, max =  +4.88 V)              
V5SB:      +5.51 V  (min =  +6.42 V, max =  +3.41 V)              
VBat:      +0.46 V  (min =  +4.08 V, max =  +4.04 V)              
fan1:     1328 RPM  (min =  803 RPM, div = 8)                     
fan2:     1350 RPM  (min =    0 RPM, div = 8)                     
fan3:        0 RPM  (min =  706 RPM, div = 8)                     
temp1:       +77?C  (limit =  -69?C, hysteresis =  -75?C) sensor thermistor           
temp2:      +4.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor thermistor           
temp3:      +4.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor thermistor           
vid:       +1.85 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

I really don't know what to do with these values.

Regards.

TWISTI
