From: reg@dwf.com (Reg Clemens)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 2.6.4 works, CVS broken...
Message-Id: <200212022319.gB2NJF51001794@orion.dwf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Just a report of something that USED to work, but is now broken
in the CVS distribution.

My system is a 733MHz Pentium III on an ASUS P3V4X Motherboard.

With lm_sensors-2.6.4 and a 2.4.19 kernel things work as well as one
can expect with the as99127f (the temperatures are WRONG, but the code
at least works)

Here is what I see:

[root@orion-rh8 sensors]# ./sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.68 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +2.51 V  (min =  +4.08 V, max =  +4.08 V)
+3.3V:     +3.45 V  (min =  +3.13 V, max =  +3.45 V)       ALARM
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.78 V  (min = +10.79 V, max = +13.19 V)
-12V:      -2.03 V  (min = -13.19 V, max = -10.73 V)
-5V:       -1.32 V  (min =  -5.24 V, max =  -4.74 V)
fan1:     4687 RPM  (min = 1500 RPM, div = 4)
fan2:        0 RPM  (min = 1500 RPM, div = 4)
fan3:        0 RPM  (min = 1500 RPM, div = 4)
temp1:       +320C  (limit =  +600C)
temp2:     +36.30C  (limit =  +670C, hysteresis =  +600C)
temp3:    +127.70C  (limit =  +600C, hysteresis =  +500C)
vid:      +16.500 V
alarms:
beep_enable:
          Sound alarm enabled

---

With the i2c & lm_sensors from the CVS tree (pulled this evening
1dec 2002), executing sensors gives:

[root@orion-rh8 root]# sensors
No sensors found!

---

Not good.

The problem seems to be in the SENSORS program itself, as with
either set of kernel modules loaded, executing the (old) sensors
and sensord programs work, but the new (1dec2002) sensors program
gives the 'No sensors found' message.

                                Reg.Clemens
                                reg@dwf.com
