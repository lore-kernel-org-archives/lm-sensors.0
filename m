From: juanpedro@fibertel.com.ar (Juan Pedro Pereyra)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <200401311948.50570.juanpedro@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've managed to get running lv-sensors 2.8.3 on my debian box, but I'm getting 
some weird information out of "sensors" and "sensors -s".
Here is the "sensors" output:

juan@athos:~$ sensors
lm78-i2c-0-2c
Adapter: SMBus ALI1535 adapter at 0400
Algorithm: Non-i2c SMBus adapter
VCore 1:   +3.28 V  (min =  +3.04 V, max =  +3.36 V)
VCore 2:   +2.93 V  (min =  +3.04 V, max =  +3.36 V)
+3.3V:     +1.71 V  (min =  +1.70 V, max =  +2.10 V)
+5V:       +6.18 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)   ALARM
-12V:     -14.19 V  (min = -14.19 V, max = -14.19 V)   ALARM
-5V:       -6.14 V  (min =  -6.14 V, max =  -6.14 V)   ALARM
fan1:     4272 RPM  (min =   -1 RPM, div = 2)
fan2:        0 RPM  (min =   -1 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)          ALARM
temp:      +48.0?C  (high =  +120?C, hyst =  +115?C)
vid:       +3.20 V
alarms:   Chassis intrusion detection                  ALARM

eeprom-i2c-0-50
Adapter: SMBus ALI1535 adapter at 0400
Algorithm: Non-i2c SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

juan@athos:~$

As you can see, although the hardware is working fine (tested by other 
methods), there are serveral ALARM warnings.
The other thing is that when I run "sensors -s" I get a constant and 
continuous beep from the system's speaker, and I can only get rid of it 
rebooting the system.

I only ant to control the system temp, so I could do just fine with this 
errors, however, it would be even better if there weren't any errors.

Next, there is some information about my system, I'll provide more if asked:

Motherboard SY-K7ADA
Processor AMD Athlon XP 1600+
Debian Woody 3.0r2
2.4.24 custom kernel (i2c compiled as modules as specified in doc)


PS: Thanks for such a great piece of software, keep up!

-- 
Juan Pedro Pereyra <juanpedro@fibertel.com.ar>
Ciudad de Buenos Aires, Argentina
athos server @ athos.thesource.com.ar
Linux User number 344472

