From: info@i-service.de (Markus Pillmann)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <200308040114.06823.info@i-service.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there!

related to this part of your faq and to my motherboard Asus A7V266ex,  I 
want to report a solution for the fan settings in /etc/sensors.conf what 
actually didnt work with the default settings.

4.17.1 Bad readings from the AS99127F!

The Asus AS99127F is a modified version of the Winbond W83781D. Asus will 
not release a datasheet. The driver was developed by tedious 
experimentation. We've done the best we can. If you want to make 
adjustments to the readings please edit /etc/sensors.conf. Please don't ask 
us to fix the driver. Ask Asus to release a datasheet.

- ----------------------

I tried to find out the correct settings and I've seen that the Asus tool 
for watching the sensors is using a switch fan_div 4 and I tried that to 
set for the AS99127F settings in /etc/sensors.conf

What shell I say, it works and the fan speed is identic to that what my bios 
itself shows up in Hardware monitoring.
Dont wonder about the low speed, its an 80mm fan, the cpu itself is 
watercooled.

here is the output:

(markus@athlon) ~$ sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore:     +1.74 V  (min =  +1.66 V, max =  +1.82 V)
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.72 V  (min =  +4.72 V, max =  +5.24 V)       ALARM
+12V:     +12.27 V  (min = +10.79 V, max = +13.19 V)
- -12V:     -15.18 V  (min = -13.19 V, max = -10.73 V)       ALARM
- -5V:       -4.62 V  (min =  -5.24 V, max =  -4.74 V)       ALARM
CPU FAN:  2327 RPM  (min = 1328 RPM, div = 4)
fan2:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
temp1:       +37?C  (limit =  +60?C)
temp2:     +63.0?C  (limit = +120?C, hysteresis = +100?C)        (beep)
vid:      +1.750 V
alarms:
beep_enable:
          Sound alarm enabled

and here is the /etc/sensors.conf:

(markus@athlon) ~$ cat /etc/sensors.conf
# Asus A7V266ex

chip "as99127f-*"
# Dual power plane
#    label in0 "VCore 1"
#    label in1 "VCore 2"
# Single power plane (A7V133, A7M266)
  label in0 "VCore"
  ignore in1

    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"

label fan1 "CPU FAN"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

    compute temp2 @*2.0, @/2.0
ignore temp3

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage
set fan1_min 1800
set fan1_div 4 			### this is what I changed so far

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47


I hope this may help others users.

Kind regards

Markus Pillmann

- -- 
InternetService Rotenburg
http://www.i-service.de // info@i-service.de
Tel: +49 (0)4261-819687 // Fax: +49 (0)4261-819688
- -= Quality Webhosting in Germany =-

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LZc96BKF9iWmmLwRAh0jAKCCKyGsZk+bTEhpL7rB1B4lNM1eYQCdGS0O
8aTmBbb8RYA+nSpRx5v+GJY=kOEw
-----END PGP SIGNATURE-----

