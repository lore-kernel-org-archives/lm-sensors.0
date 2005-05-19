From: ebenard@free.fr (Eric BENARD / Free)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: adm1026 driver for 2.7.0
Message-Id: <200304291729.05179.ebenard@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

both these patches add adm1026 support to lm_sensors & i2c release 2.7.0.

TODO :
- Alarms are not yet handled but this is planned for next release ;-)
- sensord not yet changed.
- computation in /etc/sensors.conf not all validated.

sample output :
adm1026-i2c-0-2c
Adapter: SMBus Via Pro adapter at 0500
Algorithm: Non-I2C SMBus adapter
+3.3V SB:  +3.34 V  (min =  +0.00 V, max =  +4.39 V)
+3.3V MN:  +3.37 V  (min =  +0.00 V, max =  +4.39 V)
+5V:       +5.10 V  (min =  +0.00 V, max =  +6.63 V)
Vccp:      +1.46 V  (min =  +0.00 V, max =  +3.06 V)
+12V:     +11.69 V  (min =  +0.00 V, max = +15.94 V)
-12V:     -11.04 V  (min = -15.93 V, max =  +2.69 V)
ain0:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain1:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain2:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain3:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain4:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain5:      +0.00 V  (min =  +0.00 V, max =  +2.55 V)
ain6:      +2.54 V  (min =  +0.00 V, max =  +2.55 V)
ain7:      +0.02 V  (min =  +0.00 V, max =  +2.55 V)
auxin0:    +1.86 V  (min =  +1.94 V, max =  +2.20 V)
auxin1:    +0.00 V  (min =  +1.96 V, max =  +1.28 V)
temp:      +31.0?C  (min =   +0?C, max =   +0?C) 0
rtemp1:    +22.0?C  (min =  +10?C, max =  +13?C) 0
rtemp2:    +12.8?C  (min =  +10?C, max =  +13?C) -1717986918
fan0:     13200 RPM  (min = 16500 RPM)
fan1:     9078 RPM  (min = 14318 RPM)
fan2:     8551 RPM  (min = 14318 RPM)
fan3:     9078 RPM  (min = 14318 RPM)
fan4:     8551 RPM  (min = 14318 RPM)
fan5:     8066 RPM  (min = 14318 RPM)
fan6:     8385 RPM  (min = 14318 RPM)
fan7:        0 RPM  (min =    0 RPM)

Regards
Eric
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-2.7.0.diff
Type: text/x-diff
Size: 1688 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030429/3b7a0e94/i2c-2.7.0.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.7.0.diff
Type: text/x-diff
Size: 38968 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030429/3b7a0e94/lm_sensors-2.7.0.bin
