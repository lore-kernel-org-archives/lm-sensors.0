From: "John Smith" <Kidfromaussie@gmx.com>
Date: Mon, 25 Jul 2011 08:04:43 +0000
Subject: [lm-sensors]  Config for Gigabyte GA-G31M-ES2L
Message-Id: <20110725080443.315720@gmx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="========GMX315721311581083611666"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--========GMX315721311581083611666
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Proposed config for gigabyte ga-g31m-es2l
--------------------------------------------------------------------
#  lm_sensors configuration file for the Gigabyte GA G31-M ES2L motherboard, bios FH ,(rev. 2.x ?)
#  compiled by cross referencing configurations 
#  MA770 DS3,GA-770TA-UD3 and as primary  G33-DS3R

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "DDR18V"    # "DDR18V" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "in4"     # Not in BIOS Misterious ?? 0.34v idle; 0.62v under load
   ignore in5         # raw reads: +4.08 V
   ignore in6         # raw reads: +4.08 V
   label  in7  "+12V"
# i think in8 should be ignored too ,verbatim from G33-DS3R
   label  in8  "Vbat"    # Not in BIOS,raw reads +3.14 V as in7 ?? 

   # verbatim from G33-DS3R.
   # Vcore, DDR18V, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. For +12V value from GA-770TA-UD3 is used

   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in7  @ * 3.963,      @ / 3.963


   # have no idea how to set voltages, may have been set by BIOS

   # vid is not acurate at point of measuring as i've read on mailing list 
   #   set in0_min vid * 0.95
   #   set in0_max vid * 1.05
      set in1_min 1.8 * 0.95
      set in1_max 1.8 * 1.05
      set in2_min 3.3 * 0.95
      set in2_max 3.3 * 1.05
      set in3_min   5 * 0.95
      set in3_max   5 * 1.05
      set in7_min  12 * 0.95
      set in7_max  12 * 1.05

### Temperatures
   
   # only ONE sensor attached = low budget motherboard
   label  temp3  "CPU Temp"
   ignore temp1  # raw reads -55C
   ignore temp2  # raw reads -2C

   compute temp3 @ +7, @ -7 # aproximation, i suspect bad sensor as on Charles' mobo

   set temp3_low  10
   set temp3_over 60

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "Case Fan"

   # fan1 has 4 pin connector for CPU heatsink
   # fan2 has 3 pin standard
   # Adjust for your own fans
   set fan1_min 800
   set fan2_min 2000

--------------------------------------------------------------------
compiled by using three other gigabyte config's and other measuring:
numbers from bios and cpuid hwmon utility

http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/GA-770TA-UD3
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA770-DS3


kernel 2.6.27 has included drivers:
modprobe it87
modprobe coretemp

CPU: wolfdale celeron E3300
(needs newer coretemp)

$ sensors -v
sensors version 2.10.7 with libsensors version 2.10.7

listing before any adittional config:
--------------------------------------------------------------
$ sensors   
it8718-isa-0290               
Adapter: ISA adapter
in0:       +1.26 V  (min =  +0.00 V, max =  +4.08 V)
in1:       +1.81 V  (min =  +0.00 V, max =  +4.08 V)
in2:       +3.34 V  (min =  +0.00 V, max =  +4.08 V)
in3:       +3.02 V  (min =  +0.00 V, max =  +4.08 V)
in4:       +0.34 V  (min =  +0.00 V, max =  +2.10 V)
in5:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in6:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in7:       +3.14 V  (min =  +0.00 V, max =  +4.08 V)
in8:       +3.14 V
fan1:     1024 RPM  (min =    0 RPM)
fan2:     2327 RPM  (min =    0 RPM)
temp1:       -55°C  (low  =  +127°C, high =  +127°C)   sensor = thermistor
temp2:        -2°C  (low  =  +127°C, high =  +127°C)   sensor = thermistor
temp3:       +26°C  (low  =  +127°C, high =   +70°C)   sensor = diode
vid:      +3.300 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +37°C  (high =  +100°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +34°C  (high =  +100°C)
--------------------------------------------------------------

listing after applying config, ignored in5, in6 :
--------------------------------------------------------------
$ sensors
it8718-isa-0290
Adapter: ISA adapter
Vcore:     +1.06 V  (min =  +0.00 V, max =  +4.08 V)
DDR18V:    +1.81 V  (min =  +1.71 V, max =  +1.89 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.08 V  (min =  +4.76 V, max =  +5.24 V)
in4:       +0.34 V  (min =  +0.00 V, max =  +2.10 V)
+12V:     +12.43 V  (min = +11.41 V, max = +12.62 V)
Vbat:      +3.14 V
CPU Fan:  1016 RPM  (min =  799 RPM)
Case Fan: 2327 RPM  (min = 1997 RPM)
CPU Temp:    +33°C  (low  =   +10°C, high =   +60°C)   sensor = diode
vid:      +3.300 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +36°C  (high =  +100°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +34°C  (high =  +100°C)
--------------------------------------------------------------


attach image: ksensors after applied config
attach image: cpuid hw monitor from windows

I really can not tell why is temperature reading temp3 = 26 deg. C.
Is it because of wolfdale core? Or bad sensor on motherboard?
Where is it connected , on-cpu-package thermal diode or other place ?
Trying to offset +7 deg. C , to approximate to BIOS readings.

About CPU fan...
In BIOS there is a feature called "smart fan"
and it does work - rpm is lower when temperatures are.
Only catch - it is configurable by using windows only utility,
it changes some ACPI settings , minimal treshold temperature or something similar.


in bios i've look up folowing information:  (under health submenu)
--------------------------------------------------------------

Reset  Case open Status [Disabled]
...
Case opened           Yes
Vcore             1.284 V
DDR18V            1.808 V
+3.3V             3.344 V
+12V             12.365 V
Current CPU temperature   35 C  ( slowly rised from 33 -- 34 -- 35 )
Current CPU FAN speed      1081 RPM
Current SYSTEM FAN speed   2311 RPM
...
CPU WARNING temperature  [70 C / 158 F]
CPU FAN fail warning     [Disabled]
System FAN fail warning  [Disabled]
CPU Smart FAN controll   [Enabled]

--------------------------------------------------------------



--========GMX315721311581083611666
Content-Type: text/plain; charset="utf-8"; name="ga-g31m-es2l-post.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ga-g31m-es2l-post.txt"
Content-Description: Attachment: ga-g31m-es2l-post.txt

#  lm_sensors configuration file for the Gigabyte GA G31-M ES2L motherboard, bios FH ,(rev. 2.x ?)
#  compiled by cross referencing configurations 
#  MA770 DS3,GA-770TA-UD3 and as primary  G33-DS3R

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "DDR18V"    # "DDR18V" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "in4"     # Not in BIOS Misterious ?? 0.34v idle; 0.62v under load
   ignore in5         # raw reads: +4.08 V
   ignore in6         # raw reads: +4.08 V
   label  in7  "+12V"
# i think in8 should be ignored too ,verbatim from G33-DS3R
   label  in8  "Vbat"    # Not in BIOS,raw reads +3.14 V as in7 ?? 

   # verbatim from G33-DS3R.
   # Vcore, DDR18V, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. For +12V value from GA-770TA-UD3 is used

   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in7  @ * 3.963,      @ / 3.963


   # have no idea how to set voltages, may have been set by BIOS

   # vid is not acurate at point of measuring as i've read on mailing list 
   #   set in0_min vid * 0.95
   #   set in0_max vid * 1.05
      set in1_min 1.8 * 0.95
      set in1_max 1.8 * 1.05
      set in2_min 3.3 * 0.95
      set in2_max 3.3 * 1.05
      set in3_min   5 * 0.95
      set in3_max   5 * 1.05
      set in7_min  12 * 0.95
      set in7_max  12 * 1.05

### Temperatures
   
   # only ONE sensor attached = low budget motherboard
   label  temp3  "CPU Temp"
   ignore temp1  # raw reads -55C
   ignore temp2  # raw reads -2C

   compute temp3 @ +7, @ -7 # aproximation, i suspect bad sensor as on Charles' mobo

   set temp3_low  10
   set temp3_over 60

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "Case Fan"

   # fan1 has 4 pin connector for CPU heatsink
   # fan2 has 3 pin standard
   # Adjust for your own fans
   set fan1_min 800
   set fan2_min 2000

--========GMX315721311581083611666
Content-Type: image/png; charset="utf-8"; name="cpuid-hwmonitor.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cpuid-hwmonitor.png"
Content-Description: Attachment: cpuid-hwmonitor.png

iVBORw0KGgoAAAANSUhEUgAAAfsAAAGZCAIAAAAB1Q/UAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAg
AElEQVR4nO3dL5DbSr4v8J9fHSAziY2goIfZLANnWcIS8Kp2YE49krCE3cBccKvOsjNka6fqkdmq
BQnLsPUDr2rCxmzMrqDM3AdZbC5Q0qen/6nVkmxJ/f1Uasppt1rtn+TWz21Zmj09PREAAATgf1me
+/Kvvx+tHwAA0LdZmxz//adr98oFK778/tl7XQAA0NIvlue+/Ovvb/73/7Evf3l5QURZQnEcJ0ny
7tNvH9++4Y/fRyURUZZlSXJ5s+6u2wAA0JhtxK8d7rk0TaMoiqJIekxZRkRZkkRx3LanAADQTtsc
f5FGn69vy/Jy/fWfZ2dn5+n8w+ff+bOHi8ubm1uiopvOms1mraan+tC+SwN8UQAwarZvbl1yfMbY
x3dviejs7Gw+n1ep/Wq5qv5tHrafP7wnouqv1kwgFrq/hkbcW57p9NSro5nSawGApuQc33J+jvYA
EMfx5+ubVy8vc0bEDkQHqcLX3Rf+VyWlsfy/Q8hteR8mk2ubog0AgdDM6mhHdtORgDFGROuv/0zj
KIri+Xz+WDwb9KO45H8l6oijDrJSKqoWSkOYVE1qsKpQ/eX/VduppV3QXih2SSq0vCLH1fGXYzlK
WaINAIGwzeO7iOOYiOL4bLXKIprnRSGl+SWL+N+m1Jy0eqBNVO3jHV9QW9+yiEuvpNFWW9PST3tP
XFaHKRoAcNF2xN/kxWq52ufbPN9Vk/jXn86J/szob74xMuT43VIHXD4ynmr6wnTU6W91p329ADBw
+m9uTV9XVnM74t9llj5sHpJs8VgcHvL9Q74nou39+rebb9v7dXS4rxaszfEbfZ3Y1deP3u3g+08A
GCP9iP/0HC+vpvjFv4yxt2+vSDg/p6r56a8XYoO1Ob60IosqgVX75sH0MvtbEADghGxnZ7qI4/jm
5lYt32w24n+1Ob703amdtmbt4u5THN7Z+snTfOl7Xft3GNoFxXLTYwCYgLbz+FWOv3nY8pLocL9c
yuO7Kce3D/rSaS3qOTbiY8cTb7Tt2Bex95mfTup95o992drVuR8423QSACZAM+I3umRmHMe/X9/y
yRwi+vTPZVHk/L9Xry8fNt9eRlfXdK9twf71Zu2Xn3wEdO+zvXGXHrp8Jav9r6lOyyC4c4xnm1UA
wGC1u3bmx//MFgsienmxYIzFcVz9/Xx9m6ZZVac8/Mju19/Xj//W/w7Lta/NT0EJ5KwV0ymnAAAi
2wBRe12dv7y5KliD0y49RvyWsxATHgFNP8ua6usFgPYwQAAAhKKXe2Dh5lkAAAOEHB8AIBTI8QEA
QoEcHwAgFEPJ8cuy/Pr1q/RL3a7gt6MAADSQHL9k5afPHxfser1fXt+sqyswM8bW6/WX28/bInq4
f/brLZeLv2ufxcmLABCytve5FSubnrI3whj7+PHjO7pZXMa03qzX68vLy2qsv0w2lwm9uWr1uy0A
AKh0lvOaDg/2w0Y13H9Y3mYv30bp29365YeblIguk83FMrrflMnLL69fv5Y7bc7xLb9LUq84pq0p
NmtvUyoBABi4XubxHfHhfvH2c7S7J1rHi0+fLref3m4uXpNpuCdlvJYmbTjt8M2vb6zW1F6HWdum
WIgvCQBgLGyzOu5TOh7+zO6T6Ob9RyJ69bo4e7lZvC3Lr59v1yx9/e3ly5f9daAryPEBYCw6zvEd
b57FGHv78c2H5W25Kd9+yeaX/9jG77593e3ultv1x9s1y/76b/twL6XbTfspdbVpzWrtuAcWAIxL
xzm+afCVbp7166+/vqT15/XyzdWn68vLOI4Xi81vn+8v8u39hrK//vvy8rLpqhuZNbkzuP0Kwzj/
BwDG4jTz+IvFInn55eb2/vXr19W5mIvF4nz15vN6cf723nG4f+roFt6N7q7FP1i0XCkAwPGdZh7/
w4cPUkkURR8+fCjLd9UBwE/tPZ6erDfSqi0k4etfnKsDAKPT2fn41PozQRRFUaS5Ha6Fx92ptDeW
8rjbFAZ6ABgdzEEbYYIeACZmKNfVGQjxtBwM9wAwMRjXAABC0eU8/gkXrPXHH3/00SwAwIiEkuNj
xAcAGNY8/ni/AAAAGD7k+AAAoUCODwAQihBzfPFnvYwxqUQsrB6ICzYqUVdkKdf2QS2Xmho+NUTi
U/yxNj7qgi6bYJIQRj+ImySUc3U4aQvx/2oL+1iRqdzSh3HtUpz9ghmO8QGE0Q/ipmWb1fEefI+/
oCN1c/a0dU0r0pa3uZTQkDHGmoZ38u83DwijH3vctE+FEDfM47cijdch7DF9iwXqswi4I4TRz+Tj
1su1Mweb41uYJvWG0AfTFP8kdT69FiaE0Z3LzOpkDDHHt//tCRM0XbAakdvvH3zt6syPd/emp8OA
hwxhpJ8ZfaOXP/a4DXEe3/538iY8sw8wHNWQPcZRu40h5vj9UQdTy9jqPmdX1RSfNa1IW642O+FB
v5PXpQY8NAijHx63Ni981HHD+fg1p2RZTs6VqqkVXOblebnaQlWivrfHsqtpv34QX6YpDmqhtvGx
xKElhNGPPW6mt9Xk42Yb8ad0Pj6usgAAEGKODwAQprDm8QEAQoYcHwAgFKHM4wMAQCg5PgAAYB4f
ACAUyPEBAEKBHB8AIBRh5fizmfx6q5LZbFb9lz8Wq0lLqY2AhSVcPOz0POCWpUxbsIueDhrC6Adx
kyDHJ/q5vWu33Gw2E/cSsLOHq3qrcLwmgixBGP0gblojO0C1ZDlESw/Emsjx23BMlxyDPIEkyw/C
6Adxk4SV44sHcxrh1gJswU4gjH4mELfx9bglU/JuSvYJOX473U6kknkLThvC6Adxkwwxx+/1Hlj8
KF27taTjOXTLNJFay30LhgBh9BNs3EbZ6ZbUmXoyZPT2muCi24lU8dmgNgTC6Adxkwwxx++b+9ZC
mt+5TuI53vdbVxBGP4jbWPvdknpIrx5oM3r6Oc0n7S5hhs6dNlzSRyjpWdNS2sYDiT/C6Adx0wox
xydlQ/LpPNNTUjWxEEy04RLjpg2mY5DDiT/C6Adx0xrrkQoAAJoKNMcHAAgQcnwAgFD8YnluSvfA
wl0PAQBCyfEx4gMAYB4fACAUyPEBAEKBHB8AIBTI8X+I45g/Zoy5VIjjWKqploTMI6RSubpUgDH3
DiN/NswwYvfTCuVcHYm0nez/dakAEu+QIrailnumOKgFBbufiW1Wx3vwPf6CLdVu42nvBH3wC+nk
329NtdkzQw4mdj8TzOP7Y4yJOVQIu8sRxAL1WcTckT0yCKPJ5Hc/26zO9HJ8aWtVD/g2s8zfOVYA
iUdIMXumahpGxK2C3U81xBy/v3tgsZ+kx9KzptlPtQJ/PMmdoz2PkLq0GVrMPcIoJqr2dHXCYcTu
pwr0XB371qrdlmKF6vFIN//ROIbU8RvyYGPeaM+sXSScMGL344aY4x+f6QgvZkymZce77XvVJqS1
wok5wugHcTMJNMdXiXuAlL9bKqjVgPMLqSXOUuOBxLzNnkl1gZpwGLH7adlG/Cmdj4+rLAAAIMcH
AAgF5vEBAEKBHB8AIBShzOMDAEAoOT4AAGAeHwAgFMjxAQBCgRwfACAUyPGJiGazmVTy9PQ0m8nB
UUvARBtSU031KVOoQ9soLmEU6/BntYXiItMOI3Y/k0BzfO0OITpON6atNqSz2UzdENrCkNnDWI04
XBU6bWFosPtpjewA1RXpyOx4nB/d8fyE3GMVWpLVSO2r0+7Jtbv35MOI3c8k0BxfNRNUJVJyNLpN
e3JqSNsLcKMgjH4QN63x9bgN7ba3HOHFLTrGrTsclug1SrIo7I1Sm2OKuy4vrE1XJx9G7H7cEHP8
/u6BJU7quUzZSxOjLdcOncBGqeUyj48w+hl73EbZ6fbsW0s9jI906w5Hh0kWBbxRHHN8l6+pTJUn
CbsfN8Qc//gsM33j3bSnZQppJ5Oq4WwUhNEP4mYy1n53zjLvOd6te1rakEqfn8T66gQ0NTyNepIa
hdFeqG18qmHE7qeFHP8Hcd5TfeokXRo7bUilx2odbaG28f56PiiNwmgv1DbeR5+HALuf1liPVAAA
0BRyfACAUCDHBwAIxS+W56Z0Dyzc9RAAIJQcHyM+AADm8QEAQoEcHwAgFMjxAQBCgRz/mTiOGWPi
f/njqlyqoC0BkSU+anhrFww2/gijn6ZxaxrM0cUt0Bxf3K68RCqstiWnLgJ2akilZy3hRbQ5hNGP
R9xCeMvbRnzvEyWPv2B71TaWSk7VmWlQQyo9a3pqdHlTrxBGP/a4mRbpqTPDEWiO70068gf+puqD
PaSIvyOEsQ8TiJvtF1jTy/GlrVU9cNlmY9y0oyBtBcTZD8LYuanGcIg5fn/3wOIzdNJji2o2UKwm
zfq17FLg1DnT+CcyTEMj/iqEsanq5YtR4tS3vLogjTZugZ6rY9paUrm92kg3+ZE5RqnRWRABxh9h
9NM0bi71Rx23Ieb4A1F7nB/j9j45MQn1bgTxRxj9aMPVaLinkcct0BxfJe0KTHdulkv6D5waUnoe
N7GCGkx7hMOJP8Loxz1u2khKT6mNjzRuthEf184EAJgS5PgAAKHAPD4AQCiQ4wMAhCKUeXwAAAgl
xwcAAMzjAwCEAjk+AEAokOMDAIQCOT4R0Ww2k0qenp5mMzk4TUvEZsVqarlLy+OiDamlDo+Dfanp
BcrOL4zSsy6FEwsjdj+TQHN87aYVdbIKsUG+RlP59NhDqo1D51thAjzCKD57xJ4OC3Y/rZEdoLoi
HZm98yBTienI714+utxB0rT/jhGYXqDs2oTRsitOPozY/UwCzfFVM0FVImVM2k3rUidYakjbCzDg
fmG0RyaEMGL30xpfj9vQbnvLkVzNmLRtqnU8cnyXjo2X/b3RKHVy2ShT5RhG7/12qrD7cUPM8fu7
B5Y4Q+cyW8cP6ZZN61KnUd8mPIeoqlKwRq+3q4BPiRpGMb015RMIY4C73yg73Z77Md8yGSrVb5pY
2ctHuj+ZOM6K2sulChMLkYtGYax9NpwwYvfjhpjjH59lps9l06p1ngxnTZjKp8f0umbPz1nya3y8
77emEEY/iJvJWPvdOXEX8Ui3TUmEtk21fJI5vvbli3PNUn37VyBq42OPjyO/MIqL+30CGDvsflrI
8X+wzKG7bFptHVObarnfSgdO+/LFlyyRKtQ23nmHh8kvjGpNU+Odd3ggsPtpjfVIBQAATSHHBwAI
BXJ8AIBQ/GJ5bkr3wMJdDwEAQsnxMeIDAGAeHwAgFMjxAQBCgRwfACAUYeX4cRwzxsTyqiSOY14i
VVCXEitblgJ7VMVq2me15aYt2K6ng4Yw+kHctJDj/8B+0g7o2prSYxBV7wR7VOM4NkW7disEAmH0
g7iZ2EZ87xMlj79gf9QPAeDC5ShoOliOLm/qD8LoB3EzCSvHl8buaW/akbJvFGxBRwijn8nHzfYL
rKByfNPnPj57M8ate3I8qo6hQ5C1EEY/iJtqiDl+f/fAIuEoLW3d2lk/8OAR0vgnMn9Jrt2CE4Yw
+kHcVGGdq1PhU/N8g6ln41T/lTa5tIFHuslPwhKrRidLiE8FGH+E0Q/ixg0rxz8Ox60lfd2P3L+R
Xs+CGO/7rSmE0Q/iZjKsefwTEneFkW7LQWF1v3IgIebVA4RdhTD6QdxMbLM6A7wEpjdcZQEAIMR5
fACAMIU4jw8AECbk+AAAoQhlHh8AAIab42+327IsiWixWERRdOruAACM3kDn8TebDRHFcRxFUVEU
LVsDAAAaZo6/2Wx4Ur/dbpfLZZZlp+0SAMAEDC7H32w2URwTUVmW222eZRmGewCATgwrx/++2cRF
sfjb9d1/fKCyTNN0uVyq1WazmVo4nBcymw0rqgAAFdtVFhqdcmPJ6x0b+b7ZxPv94s0ViyjZXVGW
aYd7EgZ3jK0AAO66vK6Otr7jDM/3zSYqisWbN0TR+vo6zbIXL140WntFTP+lA0P1VFUoPebPSktJ
TZnakeqI5eIBiS9e24ipBQCANjrL8T0wxor9njF2KMtkv1++ekNRdPP7b+fm7N5OSvnF//LH6liv
rWlqSipX64jLamefTB0zrR2fYwCgK71cO9PFjrEo36Y3t8ndXfTyZXxzm8fx7vOnLMuWy2XnJ+Cb
hmlTiUs7nXTmOGsEAKDOz9WZPSc1xf8yxqJ8Sze38cXFWbGPb26JaHf9t8NicXFx0Wa41669v6Y6
WZ3aSJXmd/IqAAA424jvkeM/PSc1xf8W+328zePXr2n5orz9TERUlrTfJ0nSMrs3daCPpvg0Tst1
aVfE/4tBHwC60sv5+LUYY3RzS7sdFXl0fUdELI4oz4v9vsO1dDhW1jbVvoJYDaM8APSh4xzf0YFo
l2/Zu3fs61e6X7OIyiR5SJOWk/fiZEijLzzVpVyaEutI3xPwwtrOaFfksiAAQFNdnqvj/pngPE3z
Dx9evH9P1zcsjh6i5O7FMtrT1Wrlvjpy/g7W9LWtOIXi13ijlvlo3rTPAACdOFkKud1u2XodrddE
dBtRmWZvr678TspsCXk0AATilNfHZ4zdPzywXR5F6cXF6uzszGNd7WHEB4BAYLADAAhFL7+5HeDN
s3DXQwCAUHJ8jPgAAMO6Pn5/vwAAAADk+AAAoUCOD5MVx/Go2x8IhNHPMOMWVo6vjRFjrCpnjInl
vFBaqqrGC7WLx3EsVVPbnzzta68NiBhYe1O1a1e3HSmbz7Eblnb63qwIox+1b6a1a5fqNW6mFZm6
0WHcQjlXpyKGu1Gk1NG82pz2RqQKRxgdhkP72msDIpaIR82mYeR1tEdxv25oV+qyG7SBMPox9c39
Ddtf3Gob6TVuvVxX5/gLticdkD0OCS4ZRDhMO2jTdtQN4R1Vx7f9oCCMfrrqWx9xO23mh3l8mJoj
v6O0B/sJmGQYY0F/q3D5ENBVN5rGrZd7YI0xxyfhI5L286lYzb649tmgpnQk6ufi6oEaEHH37TZc
lm3q2A3pfXX8rYkw+rHMsaj5+3HiZp8m6jVuQ8zx7X9Pggns1dTjbXUkD3O41752HkltbuIS5040
7QZ7ru/uiRBGPx5vvZNsX5dudBW3Ieb49r+9Yj1/gxSU4bz24fTEw3A6P5yeuBhOb4fTExpajj8B
YrIzqC19ZNrX7jFrqSaP7ac+RzTtjjD6GXLcTius8/E5dUpUOzSbpvVJOR9fao0MMzzhHABMr93l
GxF7ay5LiVuk9s3ftEH3p9pDGP0gbianvD7+MeEqC0E55qerCX+SQxj9DDlugeb4MHnHeddNaZzS
Qhj9DDZumMeHadLOqnVreuOUCmH0M9i4IccHAAhFKPP4AABwmhz/119/zfeHx/t1WZZRFBFRWZZZ
ml7//vunT5/y3e5wOJRlmaZpGsdnaXr75cvxOwkAMDEnm8d/vF8T0Wp1QUSMsbIsy7J8zPN8t9vv
99VwXxRFwdiuKPy6AQAAotPk+H/5y6uHh/uPHz++vLy8evs2z/OyLM/Ozs7PVw8P92VZVtWyxaLI
8zRJHv/7v4/fSQCAiTlNjr8/7LMsu725eXh8fPv2bVWYzOf7Iq+S/SiKLpbLNEmTJCn9OgEAAM+d
JsdfXVzk2201sn/8+HG9vieiLEuJ6LDfb7bbNI73RGVJEZVlWT4+Pj7r9GwmNRjIGUcAAG10dg8s
S16vNrLIsny7JaKyLH/77bc3b97EZxkRlWxPCaWL5cP6rvpGl4jSNFXbxBAPANBUl9fO1NbXHgnm
83n1xWw1hxPHZ1V5FEVlSYs0fSBijPHTeBw7IOb+1SFhNps9PT3xcn6cUEsAACavl/vc1jo7O/vw
4QNjLM+L+x/naM6JiKJ5NfqvFos9UTXz496sOHxXY734gIQDgFTS0csCABi0Xu5z6+I8S7Msy7J0
tVptH+7/fCKab/L8Mc+TeXJzc7P+9iXV/Vh59pxlRfYBHcM9AISj4xxfGnz5eFo1xf9+/765u7vb
brdEERFFEVGaLdKUiLZF8bC+I6KiyK+vb16+vCx0147QjtT2oV9cFrM6ABCgzuY0TIcHbflfLi6I
6DHP5/N5FEXVD2u/bzaHwyFJ031RVKfxpFlGREWeF89/hKWdipEK1Qkc7YKY1QGAcPRyPn6tszR9
zPPz81V8lqWL5WJ1sSuKw+GQpBlRlCYJn74v8vw8y5q2b0/2HT8KAABMzGnm8bPFgoiKfLs6z/76
8vLy8uJhu03SNI0ozbLVxUUcx8l8zna7JM0odRrxq4y+Ujt371gTAGBKupzHd/9MMJ/PX7169e3b
t2/fvmVZtt1u0jSNooToUFW4unpze/slSZJUl+CbhmmxvHos1eT/xUAPAAE6TZJ7t15vvn8viv39
wz3b7eKzs0WWEdFux/b7gqqT8eM4zRbEWJal//jHP47fSQCAicH18QEAQoGJbACAUPTym9sBfjjA
XQ8BAELJ8THiAwCc7B5Y3S4IAAC1kOMDAIQCOT4AQCjCyvFj5TKcTLhMWxzH0n+1FXgj/LG2EXFd
THcxuMlTI2CKvz1W0lK8grZc3SKmwrGoDY49ttp2KIAwYvfTCuVcHa593KuB3t6OevAYyPY+GlME
LGOW9r8VU4XJB9keHNNgZBJOGLH7mfRyXZ3jL9ielL9X1BKVSx2w6Px9Im2RsbwVm+r7dQUSxtB2
P8zjw1HFglP3ZcS04whiWwsh6vI+tydc0J1p9o1/6JPeSy5zOC51gHTzm+qsqDaMpplWUznfIpPc
LrUzD6Y6gYcRux8NM8e3/22JPee4COZ2mqoC4p5P8S2ircw3lrTJmm7K0TGFUSxx3/HCCSN2P5Mh
5vj2vz3BeN05UzbUpkH3pGmYGZYHNYxSSdPXGEgYsftpDTHHP7Jqw4jU/QNpfht819fGp1HQQg6y
fQRBGE2w+4mGmOMPHP8obXn7SXvGAA/1R6DOjWrD0jRW7tnTNMJun2LmEEYJdj+tYV0fH9fOBADo
T1i/uQUACBnm8QEAQoEcHwAgFKHM4wMAQCg5PgAAYB4fACAUyPEBAEKBHB8AIBRh5fiz2UwqEV/+
bDaT/qutwBvhj+2NBBVhkRhtHgRtIX9KjZUpgNKm1LbPy9XNZCocIPcwNg04TTqMLXe/qcYtuBz/
6Tm/FshhU81mM/UAE47q/cNVodAWkiFWtQHUNmUpHyP3MDYKuGiSYWy5+004bmFloJaMm+fvT8Lh
WluiPtDWqV1jUFzy96Y5vnZZbbnLxh0FS4j8ghlIGJvufrXBHG/cgsvxAQCCNfSDc7dM8/guiXzT
B1JrITPNkNrzJkshKZtS3Hxquekz2bi2jj2M9oxVrCm1Kf53kmH02P1ccnzxvyOK2xBz/F7vgfX0
nOMitfNxw5yzO7lqhlSKc1eznHwLmtof8jDUSMsw2mtOOIzecaue5Ux1xhi3QR+cO9coYbTMu2mP
0u7TqYGofe1dzeNbsjOPykPjGMb28/gTC2Mnu5/pqfHGbVg5/knMnn8vrz34O2ZSSPM5067fx7om
HPmWYWwUlimFscPdr3ZcHlfchnhw7k+jxEc7/SduXUsdUnavoOJM1q9MpBK1sksAHbeaqbK9fDi8
w2gvFNufZBg73P0cX/JY4hZWjq+Nr1pomZ4jYZ7OUoeeT+cN7f1wBE8KtdxU2VIoLqItcdzE9vLh
8A6jvVB8Vlsy9jB2uPuZ2teWDD9ugzs4AwBAT8LK8QEAQoYcHwAgFMjxAQBCcZocf3VxsciyXUn7
Ik/SLEvmURTFcTyfz7PsLI7TKIrW63VZsrKk7Tb/97+/Hb+TAAATc5ocP0kzIjqLaHV+vkgTXh5F
0dlZlqbp+fn5q1evypKiiLIs9esGAACIbCO+903GaxdcZgkRZdl5FEVlWfLyLMuSJImi6PHx8fHx
MU1TxsrD4eDXDQAAEJ0mx4+i+OrqiuhQlj8G9Ciii4uLxWKR5/lmc88Yy/O8KIooinZ57tcNAAAQ
/WJ5rr8c//LycrVaMVaUJatG/MViuVgsdrtdnuf7/Z5oxytn5+fS4qYf1HWi9ho7pv+KP7iVWsMJ
UQAwBLYR/8u//u4+6Fvyem0jRVEsFqvHx12SUBzH/7xbX19fJ1G0vFglSconcsqyjKJIXbzXMdQy
uAMAjFeXOb62vvZIwBgry3K1Wq1Wi+2WDgd6vF+XZVlE0WOeX15evn//Ps8fHx42wiR/PfWiGWL2
TcJQbr9oRu1angwX0Hgy3Omm6SoAAPrQyzx+rSLf5tvNfr9fLpcvXrz4/v2+Kq++xd1ut2dnZ5eX
rxaLZRRpU3w98eIYfJwVL405U253ieEYAMLRy7k6tYr9odgf7u7u5vP5+fk5HfZlWfKTdpIk3W63
RVFcXl7GcRpFmrMzZ89Z1mXP4rXPii3zCySZ1iIl+9JxxbJqAIAj6zjHNw3E0q2sGGPV2Ti3t7dF
USxWqyRJ4jiuKl9eXuTbzXb7QESr1SLLztQVaS93534MsFfTXmCPr6L2GAAAMEwdn6tjymqrpvjf
//f/31cZfVHk9+u75XKZpul6fb8/7BdZRkTbvIj3hzjeZlnmuGrtpepr+9lHJm6a5QcAOK3OztVp
ZL/fJ0lSTeTkRRHtaT6nd+/epml6OBzu7r4SEWMs327SNE3Txr+5tQ/3GI4BIEynmcff5jkRVd/J
JkmaJFE1dRPH8ffv38uS9vt9WZZ5URRFcX9/79KmOFdTO3fvWFNdSp2yb3QPBACAE+oyx3ef90/S
bFvsXyzOkyTKsqy6hhoR3d3d7fdFWZbVf4no69evcSyfrONyTxntLWnEG9yY+tboKXWNjRoEADim
zubxm34gyJI5Y8XFxcvFYsEY2+/3eZ7v9+JVdmiT77NkXhT7Ri0DAIDWac7H3xf54XCIIrq/3zDG
iKg6e4foEEUURdHhcMgfH4mxfH/Y4ro6AABdwHeYAAChOM25Osdf4x9//NFHswAAIxJKjo8RHwDg
NPP4w1kjAEA4kOMDAIQCOT4AQCjCyvH5xdq46tzQShzH0n+1FaRGqgrqsqYFxbEkwyQAAA15SURB
VHJpLWLLUrUxcnk5piD33bcRQRj9IG5aoZyrw3WyOfvYRezHjNFxeTm8UH0AFYTRD+Jmcprr6gxn
jZwpf1c/Fvg1pW0whD0MAIYD8/gwFDj+dQJh9BNI3Dq+Pn5LR1ijfRa+ysHFDa+WkG6KUFuNV9Y2
GMgeZiF+tyF+sqZJfI1xNAijnzDjNsQc3/63Jfac4yLqccLUgnTwaN/haZNiWEUPoWsKYfQTYNyG
mOPb//bkmNsYCb4E0egEwugnqLgNMcc/Mn5g57QncU74sA8AgQjufHzLPIxUYjo935IRmJoyPSuV
B3g+Pjn8DCJwCKMfxE3LNuJP6Xx8XGUBACCsHB8AIGSYxwcACAVyfACAUIQyjw8AAKHk+AAAgHl8
AIBQIMcHAAgFcnwAgFCElePPZjOpRHz5s9lM+q+2gtRIVUFd1rSgFHDTWjxe3dCIgeKvSFuoXXCS
MfGAMPpB3LSCy/GfnmvfiHoU8TabzTps7bSqN4kUJW2haUH+7JTeb00hjH4QN5NJvZhalo3H03Ax
Hagt8VjQscFOX/cJ1EZJrSMVqg8ChDD6QdxMgsvxYVwm9n47FYTRz/TiNrXXY2eax1fzbssD7Ty+
tlptO9okYho7mXeSRcJEqhgiMk+8ThjC6AdxMxlijt/rPbCennNcRB3lTS3wvcQ0URiI6uVzlkLt
suo7M8x4Iox+EDeTKaST7uxHdc6U+GszBalx01LaBrW9mkaOL7HPmdoXmeqMqgeE0Q/ixg0xxz8y
fgzn1IP5ZI7wJ+HxfgMVwugHcROF9bIdt71p1o+ez+65tG/J5dU62o8a4yV+mrYXapfVBr/7Xg4e
wugHcdMKK8fXbjO1kE/ES4XacpemLGsXy6WPGqa1jIX2hTi+OlPwA4Qw+kHctMLK8QEAQhZWjg8A
EDLk+AAAofjF8tyU7oGFux4CAISS42PEBwDAPD4AQCiQ4wMAhAI5PgBAKMLK8eM4lsoZY/xxHMfS
f7UVpEaqCuqypgXFcmktYstStTFyeTmmIPfdtxFBGP0gblqhnKvDdbI5+9hF7MeM0XF5ObxQfQAV
hNEP4mZim9U58nB/kjVypvxd/Vjg15S2QXEPm/yuBgAnh3l8GIoQMqwjQBj9BBI326zOJHN8+yx8
lYOLG14tId0UobYar6xt0LKHBbLzid9tiJ+sCZ94mkAY/YQZtyHm+L3eA4s957iIepwwtSAdPJp2
L47jQIb7ihTD6rX7hS5kCKOfAOM2xBzf/rcnx9zGpgQ/qLFeFOwL7xbC6CeouA0rxz8JfmDntCdx
9n1ICGq3A4CTGFaOP2qO3wHwp9RC7XcMIyUdIy2vRTphafITqY0gjH4QNxPbL7COfz5+f3CVBQCA
sH5zCwAQMszjAwCEAjk+AEAoQpnHBwCAVjn+p0+fiKgsWVlSWZaHw4HKkoh2rKTDnogOJZVUVg6H
Q1EUXfUbAACaanvtzG06j2hORJvbL5qnI0ovVtXDx9tvnn0EAIAutDofvyxZNdxTRMurN0RUVuVs
T0Tl/sf/ftZu11MAAGin1bk6jJVERBHxv5HwbJRE6iKdm81mJ28BAGAUjveb21JJ8vlQa/kuYTbz
/KZBHMdPez6SekSp+qPtYctCAAALecS35PXqAeBwOBARlT9y+/kmJ6pmeX7IY1ua//T05D2g20nN
9rQWd+ratT1sWdhb9wFgIjQ5vja11x8JyvLHaF9SVhyuv8hf3mZZmlxeuPSDD2TVf8UsuPorPksN
PxY45sXqs2KvTIm5tue1tNUwagNAr2yzOrV2rIzYnuKEl6xWF4tFtt3my+Xy5ua6UWviSF09FpPZ
9lmtvQXTf9VeNaoDADAcrUb8SnVmTpXrLxbZviiWy2yz2Sj1ak7WGeZA6dKr2jrSVL76mUM6kLiv
GgDAnX7EN41Q1Rn6/G/1MyvR7e2taU3tT87s+7Sc/k7aMY3d2k8G+LgAAD3Rj/imgUa6I9Xf/uv/
0r6szsLczMssS6X6jpP4jtoPf/YWMLwCwLS1mtUpqZz/+UsrSi4v/3ymZ5b81/FUFnsG3Xd+7dEl
AICW2o34ZdlmcOen4liGOfFUGfcz0LWV7S24tN+oDyJ1lsy9hx6vBQBASzPiu18Wv6z7MtZeWRyn
TOdTio8bndHoXtnSvkeJyyLePXRpFgDARB7xG/3O9scvsIiIqLh/0NbhV1IDAIDTajVx/H09f30V
E1VTO0IOL+Xz5Y9LLCAtBQA4IXxVCAAQCtu1M73hBrkAAAM03Bx/u91Wk0OLxSKKjnHhZQCAaRto
jl9dpCGO4yiKcK9EAIBODDHH32w2PKnfbrfL5TLLstN2CQBgAgaX4282myiOiagsy+02z7IMwz0A
QCeGleN/32ziolj87fruPz5QWaZpulwu1WraS54N54XgYgkAMEwdXC250ujmWVrfN5t4v1+8uWIR
JbsryjLtcE+4uiQAgJfORnxqdPMsxffNJiqKxZs3RNH6+jrNshcvXnj0wXRLWO2trOw3sfK+JZZY
brphob0RUwsAAG10OeI3xRgr9nvG2KEsk/1++eoNRdHN77+dm7N7O8slM8X7VdHzEVxb0+V2V6Qb
0KX7dtX2s/Y2tvgcAwBdOdmIv2MsyrfpzW1ydxe9fBnf3OZxvPv8Kcuy5XLZ+Qn4lqu2aUtc2umk
M8dZIwAAdX6uzuw5Xl7N7fC/jLEo39LNbXxxcVbs45tbItpd/+2wWFxcXLQZ7rVr76+pTlanNlKl
+Z28CgAAruMR/+k5Xi7dPKvY7+NtHr9+TcsX5e1nIqKypP0+SZKW2b2pA300xadxWq5LuyL+Xwz6
ANCVXs7Hr8UYo5tb2u2oyKPrOyJicUR5XuzlG+e20eFYWdtU+wpiNYzyANCH04z4B6JdvmXv3rGv
X+l+zSIqk+QhTVpO3ouTIY2+8FSXcmlKrCN9T8ALazujXZHLggAATXX5za37T23P0zT/8OHF+/d0
fcPi6CFK7l4soz1drZrdPsXxO1jT17biFIpf441a5qN50z4DAHTiZCnkdrtl63W0XhPRbURlmr29
uvI7KbMl5NEAEIhTDnaMsfuHB7bLoyi9uFidnZ2dpBsY8QEgEBjsAABCccrf3Kq+/OvvjW6t7u6P
P/7oo1kAgBEJJcfHiA8AcJqzM01wg1wAgP4gxwcACAVyfJisOI5H3f5AIIx+hhm3EHN8MVKMsT5W
F8cxY6z6e7SVDo39JYvB0S4lPusRPd6+dtnaBqVuqO8uXt731kQY/Zj6po2M/dnO49a0Gx3GLZRz
dTgpRkd4x55qpadlf8mm9EQ6Rmp3a5fo2ZetbVDbDe1K1da6hTD6MfXNvpbjxM2vG13FbVgj/pGH
e7JmK3y3Jt2R1hRlXqd6EMLgrlW7Qzt+JrVssj76NjQIox9T4ty0z33E7bRjAubxiX5uA04ctasS
Sx2JeEDmywJ3nGmQY4bdfdjtEMLoJxb0twqXDwFddaNp3MLK8ZvCeN2SOh1pD6m4+x5hRDOtSNsN
6X11zH0DYeyqb/b5maPFzaMbXcVtWCN+NY9v/3vC7tUeSzGlI1GnI8UYauPTbcRqP425d+OEmxJh
9GPvm32Rrjrgl8X3F7dhjfjSrbK0f0+oNuhiCobhXmVPbY6z0iOssW8I44gMLW5hzeOrh1zvbWBa
EMN9paudu9tNpibIA4cw+hly3E4L5+NrpslMs6XaBSWmEd9l2Ymxv+RGb4Cm0RMb187MtmnQ/alO
IIx+HN/m3k3Z6w82bsMa8XHtTOjEMfOpgeRufUAY/Qw5bsMa8fuDET80x3nXTWmc0kIY/Qw2bmHN
40M4vE+TcDe9cUqFMPoZbNyQ4wMAhGJYI/7Jz7gHAJiwYY34AADQH8zjAwCEAjk+AEAokOPDZM1m
s1G3PxAIo59hxi3EHF+MVE8vfzabPT09VX/V8j7WOED2OJtCwZcSn/XYZLx97bK1DUrdUN9dvLzv
DYow+kHctILL8asYcUfLL2az2VRzGS17nE2hEJfidTw2mfh+U5etbVDbjafneGGvmxVh9IO4Gfv2
1HOGMiiWQ6J61OV5OumOtC7tqDWDyvFF4gs3fQByr+a+Omnx2pV6dOOY2xRh9IO4ccHl+Fqmoy4v
t9SRVJX53zDHd4vjTIMcM+weeVZ7CKMfxC2slNMyeaceiu3H59qjruPxfNrU6UgpeWm0iPtKTWuR
nhJXVNsNqcIxP7ohjH4QN9UQc3z73xOaCSwV6OcWOn7qNzTaj01SlEyLdNUB01azf1xTu/H0XCfd
c4QwencbcZMEl3JqX69Hjl+7FuT4IvWFO4aiZZLl8pTLKux1jrZZEUY/iBs3rBy/b+oR1TsNt6T5
puE+KF19vul2kz0ZPiMPFsLoB3EzGdZ9bo9A2oRPP79iVQtdFnQnfq70WHx0WoarTVPSEZcvy0s6
7Bv1nOAjjH4QN2P9yQ89EKBjfsaa8Oc5hNHPkOMW1qwOBML0hVjnpjROqRBGP0OOG0Z8mKYjvOsm
Nk5pIYx+Bhu3CcYaAAC0kOMDAIQCIz4AQCgw4gMAhAIjPgBAKDDiAwCEAiM+AEAoMOIDAIQCIz4A
QCgw4gMAhAIjPgBAKDDiAwCEAiM+AEAo/gcNyAVsoXKe9gAAAABJRU5ErkJggg==
--========GMX315721311581083611666
Content-Type: image/png; charset="utf-8"; name="ksensorsfinal7.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ksensorsfinal7.png"
Content-Description: Attachment: ksensorsfinal7.png

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

--========GMX315721311581083611666
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--========GMX315721311581083611666--
