From: bbkr@post.pl (Pawel Pabian)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: ticket 1599 explanation
Message-Id: <20040306020526.50077.qmail@home.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello 

the problem is, that I have ONLY mainboard sensors output. GeForce
card sensors are detected by sensors-detect but not visible after
runing "sensors".

on 2.4 kernel I had BOTH Mainborad and GeForce output:

bash-2.05b# sensors
as99127f-i2c-1-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.66 V  (min =  +1.58 V, max =  +1.92 V)
VCore 2:   +1.66 V  (min =  +1.58 V, max =  +1.92 V)
+3.3V:     +3.13 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.17 V  (min = +10.79 V, max = +13.11 V)
-12V:     -11.68 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.42 V  (min =  -0.00 V, max =  -0.00 V)
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min =  750 RPM, div = 8)
fan3:        0 RPM  (min =  750 RPM, div = 8)
temp1:       +29?C  (limit =  +60?C)
temp2:     +46.4?C  (limit = +120?C, hysteresis = +100?C)
temp3:    +255.4?C  (limit = +120?C, hysteresis = +100?C)
vid:      +1.750 V
alarms:
beep_enable:
          Sound alarm enabled


w83781d-i2c-2-2d
Adapter: NVIDIA display adapter bus 1
Algorithm: Bit-shift algorithm
VCore 1:   +2.84 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
VCore 2:   +1.40 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+3.3V:     +2.97 V  (min =  +2.97 V, max =  +3.63 V)       ALARM
+5V:       +4.91 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.48 V  (min = +10.79 V, max = +13.11 V)
-12V:      -0.00 V  (min = -13.18 V, max = -10.78 V)       ALARM
-5V:       -0.00 V  (min =  -5.48 V, max =  -4.50 V)       ALARM
fan1:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
temp1:       +54?C  (limit =  +60?C)
temp2:     +54.0?C  (limit =  +60?C, hysteresis =  +50?C)
temp3:     +11.0?C  (limit =  +60?C, hysteresis =  +50?C)
vid:      +0.000 V
alarms:
beep_enable:
          Sound alarm disabled

on 2.6.3 kernel output looks like this:

linux root # sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
VCore 1:   +1.68 V  (min =  +1.18 V, max =  +1.79 V)
VCore 2:   +1.68 V  (min =  +1.18 V, max =  +1.79 V)
+3.3V:     +3.12 V  (min =  +2.96 V, max =  +3.63 V)
+5V:       +5.03 V  (min =  +4.49 V, max =  +5.51 V)
+12V:     +11.19 V  (min =  +9.55 V, max = +14.41 V)
-12V:     -11.70 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.43 V  (min =  -0.00 V, max =  -0.00 V)
fan1:        0 RPM  (min = 3994 RPM, div = 2)              ALARM
fan2:        0 RPM  (min =  998 RPM, div = 8)              ALARM
fan3:        0 RPM  (min =  998 RPM, div = 8)              ALARM
temp1:       +22?C  (high =   +80?C, hyst =   +75?C)
temp2:     +39.0?C  (high =  +100?C, hyst =   +90?C)
temp3:      -0.5?C  (high =   +80?C, hyst =   +75?C)
vid:      +1.750 V
alarms:
beep_enable:
          Sound alarm enabled

as you see there are no readings from GF card. so that was the problem
in ticket I posted.

thanx for your time.
bbkr
