From: Jasmine <jasmine.aura@yahoo.com>
Date: Sat, 20 Nov 2010 05:35:37 +0000
Subject: [lm-sensors] Foxconn 600A01-6LRS & VT1211,
Message-Id: <910719.63566.qm@web63608.mail.re1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

An old system I had which I wanted to resurrect. I remember back in the day=
s=20
(2003-2004), linux support for the vt1211 was a bit tough (both in terms of=
=20
driver & formulas for lm-sensors). Come to think of it, it still is cumbers=
ome,=20
as neither "SpeedFan" or "Everest" (and others I tried) in windows can refl=
ect=20
sensible sensor information.

M/B: Foxconn 600A01-6LRS
CPU: Athlon XP 2800+ Barton (FSB 333Mhz, Clock 2.075Ghz)

# lshw
[..snip..]
description: Motherboard
product: KT600-8237

# lspci -n
[..snip..]
00:11.0 0601: 1106:3227

according to http://www.kernel.org/doc/Documentation/i2c/busses/i2c-viapro
1106:3227 is VT8237R

# dmesg | grep vt1211
[   18.413205] vt1211: Found VT1211 chip at 0x6000, revision 2


# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: VIA Technologies, Inc. KT600-8237
[..snip..]
Found `VIA VT1211 Super IO Sensors'                         Success!
    (address 0x6000, driver `vt1211')
[..snip..]
Using driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies VT8237 =
South=20
Bridge


$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:      -273.2=B0C  (crit =3D +60.0=B0C)                 =20

vt1211-isa-6000
Adapter: ISA adapter
in2:         +1.69 V  (min =3D  +1.60 V, max =3D  +1.70 V)  =20
in3:         +1.94 V  (min =3D  +1.92 V, max =3D  +2.25 V)  =20
in4:         +2.22 V  (min =3D  +1.89 V, max =3D  +2.32 V)  =20
+3.3V:       +3.17 V  (min =3D  +3.13 V, max =3D  +3.46 V)  =20
fan1:       3971 RPM  (min =3D 3504 RPM, div =3D 2)
fan2:       3600 RPM  (min =3D 3006 RPM, div =3D 2)
temp1:       +40.0=B0C  (high =3D +255.0=B0C, hyst =3D  +0.0=B0C) =20
SIO Temp:    +51.0=B0C  (high =3D +65.0=B0C, hyst =3D +60.0=B0C) =20
temp3:        +0.7=B0C  (high =3D  +0.5=B0C, hyst =3D  +0.5=B0C) =20
temp4:        +0.9=B0C  (high =3D  +0.5=B0C, hyst =3D  +0.6=B0C) =20
cpu0_vid:   +1.850 V

------

in2 is Core Voltage (no calc needed, so looks good)
in3, in4 I suppose are +5V and +12V, though way off
fan1 is CPU Fan
fan2 is System Fan
temp3 seems to be CPU Temp
temp4 would be M/B Temp


base temperature values, idle (@room temp 25.2C, case temp 28.2C):

$ grep "" /sys/devices/platform/vt1211.24576/temp*_input
/sys/devices/platform/vt1211.24576/temp1_input:40000
/sys/devices/platform/vt1211.24576/temp2_input:51000
/sys/devices/platform/vt1211.24576/temp3_input:733
/sys/devices/platform/vt1211.24576/temp4_input:859

# burnK7
(from CPUBurn - ran for a few minutes until values stabilize)

$ grep "" /sys/devices/platform/vt1211.24576/temp*_input
/sys/devices/platform/vt1211.24576/temp1_input:40000
/sys/devices/platform/vt1211.24576/temp2_input:51000
/sys/devices/platform/vt1211.24576/temp3_input:576
/sys/devices/platform/vt1211.24576/temp4_input:828


After a bit of research and testing, I made my config file:
/etc/sensors.d/foxconn_600A01-6LRS
and ran `sensors -s`
now the equivalent output of `sensors` for the two runs above is:

IDLE (room temp 25.2C, case temp 28.2C):
$ sensors
acpitz-virtual-0
Adapter: Virtual device

vt1211-isa-6000
Adapter: ISA adapter
VCore:       +1.69 V  (min =3D  +1.60 V, max =3D  +1.70 V)  =20
+5V:         +4.76 V  (min =3D  +4.61 V, max =3D  +5.41 V)  =20
+12V:       +12.67 V  (min =3D +10.77 V, max =3D +13.21 V)  =20
+3.3V:       +3.17 V  (min =3D  +3.13 V, max =3D  +3.46 V)  =20
CPU Fan:    3996 RPM  (min =3D 3504 RPM, div =3D 2)
SYS Fan:    3581 RPM  (min =3D 3006 RPM, div =3D 2)
SIO Temp:    +50.0=B0C  (high =3D +65.0=B0C, hyst =3D +60.0=B0C) =20
CPU Temp:    +43.5=B0C  (high =3D +64.8=B0C, hyst =3D +60.2=B0C) =20
SYS Temp:    +36.4=B0C  (high =3D +60.2=B0C, hyst =3D +55.2=B0C) =20
cpu0_vid:   +1.850 V

Full load w/ burnK7 for several minutes till peak temp is reached:
$ sensors
acpitz-virtual-0
Adapter: Virtual device

vt1211-isa-6000
Adapter: ISA adapter
VCore:       +1.69 V  (min =3D  +1.60 V, max =3D  +1.70 V)  =20
+5V:         +4.71 V  (min =3D  +4.61 V, max =3D  +5.41 V)  =20
+12V:       +12.61 V  (min =3D +10.77 V, max =3D +13.21 V)  =20
+3.3V:       +3.15 V  (min =3D  +3.13 V, max =3D  +3.46 V)  =20
CPU Fan:    4096 RPM  (min =3D 3504 RPM, div =3D 2)
SYS Fan:    3561 RPM  (min =3D 3006 RPM, div =3D 2)
SIO Temp:    +52.0=B0C  (high =3D +65.0=B0C, hyst =3D +60.0=B0C) =20
CPU Temp:    +54.5=B0C  (high =3D +64.8=B0C, hyst =3D +60.2=B0C) =20
SYS Temp:    +38.7=B0C  (high =3D +60.2=B0C, hyst =3D +55.2=B0C) =20
cpu0_vid:   +1.850 V


And here's my config, heavily commented as to give best picture possible, a=
nd=20
hopefully to be corrected wherever I'm wrong :)



####### Begin /etc/sensors.d/foxconn_600A01-6LRS ######

chip "acpitz-virtual-0"
    ignore temp1    # returns bogus value -273200 (of course, no sensor pre=
sent)

chip "vt1211-*"
    ignore temp1    # seems to be grounded (always 40000)

    label in2 "VCore"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "+3.3V"

    label temp2    "SIO Temp"    # (SuperI/O Chip; VT1211)
    label temp3 "CPU Temp"
    label temp4 "SYS Temp"
=20
    label in2 "VCore"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "+3.3V"

    label fan1 "CPU Fan"
    label fan2 "SYS Fan"

# All voltage calculations have the form
#    compute inX  @ * (1 + R1 / R2), @ / (1 + R1 / R2)
#
# The following are the resistor values as recommended by VIA
#       Voltage         R1      R2
#       -------         ----    ----
#       VCore           -       -    (no scaling)
#        3.3            6.8k    10k    (R42 & R50, respectively)
#        5.0            14k     10k    (R504/R0603 & R50, respectively)
#       12.0            47k     10k    (R43 & R51, respectively)
#
# The VT1211 internal 3.3V (in5) is scaled by the driver and doesn't
# need to be adjusted here. VCore (in2) doesn't need scaling at all.

    compute in3  @ * (1 +  14 / 10),  @ / (1 +  14 / 10)
    compute in4  @ * (1 +  47 / 10),  @ / (1 +  47 / 10)

# `cat /sys/devices/platform/vt1211.24576/cpu0_vid` gives 1850 (~ 1.850V) w=
hich=20
is wrong
# Athlon 2800+ Barton Core (333Mhz FSB) VCore is 1.65V. Adjust for your CPU=
, if=20
needed.

    set in2_min 1.65 * 0.97
    set in2_max 1.65 * 1.03

# For the 5V input (in3), at least, you may want to widen the acceptable ra=
ge a=20
bit
# (by increasing the multiplier of in3_max, and decreasing the multiplier o=
f=20
in3_min)
# this is because the manufacturer's own schematic for this motherboard cle=
arly=20
shows
# +/-1% for R504 (14K_NC); the resistor on 5V_SYS that connects (along with=
=20
3D3V_SYS)
# to UIC4 (in lm-sensors/kernel-2.6 terms - UCH4)
# For the schematic, google "600a01-c-hw-sch-final.pdf" (page 30 of 37)
# If you happen to have windows installed, download the "SuperUtility" soft=
ware=20
for
# this board from foxconn site, run the bundled "SuperStep" utility and loo=
k at=20
how
# wide of min/max ranges they have set as default. For example: the 5V inpu=
t has=20
its
# alarm limits set as 4V for min, 6V for max! (a little ridiculous)

    set in3_min 5.0 * 0.92
    set in3_max 5.0 * 1.08
    set in4_min 12.0 * 0.90
    set in4_max 12.0 * 1.10
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05

# The VT1211 internal temperature (temp2) is scaled by the driver
# and doesn't need to be adjusted here.

# The thermistor calculations are of the form
#    compute tempX  1 / (1 / 298.15 - (` Vmax / @ - 1)) / B) - 273.15, \
#                   Vmax / (1 + (^ (B / 298.15 - B / (273.15 + @))))
#
# B is the thermistor beta value, Vmax is the reference voltage, '^' is the
# exp() operator and '`' is the ln() operator.
# Given B =3D 3435 and Vmax =3D 2.2V and assuming that the thermistor forms=
 a
# resistor divider with a resistor equal to the thermistor's nominal value =
at
# 25 degrees C, the following compute lines can be used:
# For more info, see: http://www.kernel.org/doc/Documentation/hwmon/vt1211

# Please note that results *will be noticably different* from what you migh=
t see=20
in BIOS,
# and even what you see in "SuperStep" (from "SuperUtility") if you happen =
to=20
run windows,
# even when comparing idle temps, but that doesn't mean what you get here i=
s=20
wrong! Why?
# 1. Page 30 of the schematic (mentioned above) clearly states:
#     "MONITOR CPU TEMP BY RT1. UIC1:CPU TEMP, RT1 Placed in CPU cavity."
#    That certainly means a thermistor measuring "surface temp", NOT "core =

temp".
# 2. BIOS alarm setting for CPU temp offers 4 options; 60C, 70C, 80C, and=20
disabled.
#    Considering that Athlon XP CPUs "Internal Fry Temp" is 85C, which=20
corresponds to a=20

#    "Surface Fry Temp" of 75C, the BIOS cannot possibly be reflecting surf=
ace=20
temps when
#     alarm max setting is @ 80C (actual shutdown occurs at or around 82-84=
C).
# Therefore, the BIOS (and "SuperStep" utility) adds to the thermistor-repo=
rted=20
temps.
# To confirm, conduct a simple "Cold Power-up Test":
# 1. Let machine cool down to room temperatue (preferably overnight), switc=
h on,=20
go straight
#    to the BIOS -> "PC Health" to check the temps. At the instant you powe=
r-on,=20
system and
#    CPU temps should both equal Room temp. Any significant difference is a=
=20
calibration
#    error (or intentional difference/offset) in the readouts.
# 2. Note how long it takes for temp to rise and stabilize at max Idle Temp=
. It=20
should take
#    anywhere from 10-15 minutes to level off, indicating the test itself i=
s OK.
# In my test, *cold boot* (overnight) and straight to BIOS, CPU/SYS temps w=
ere=20
32C/32C,
# while the room and case temps both measured exactly at 24.2C (two differe=
nt=20
thermostats).
# Calibration difference =3D 32 - 24 =3D 8C , give or take 1C. Therefore, o=
ffset is=20
7C to 9C.
# If you compare your CPU or SYS idle temp from `sensors` output (per the=20
calculation below)
# with its counterpart in the BIOS, you'll find same difference range of 7C=
 to=20
9C.
# For example, with room temp @ 24.2C, and case temp @ 28.2C, I get:
# `sensors` reports: CPU 43.5C & SYS 36.4C, occasional slight shift to 44.1=
C &=20
37.0C
# BIOS temp reports: CPU 51C & SYS 43C (both BIOS & SuperStep reported temp=
s are=20
integers)
# SuperStep reports: CPU 51C & SYS 43C, occasional slight shift to 51C-52C =
& 44C

    compute temp3  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
    compute temp4  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                   2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))

    set temp2_max    65    # SIO (internal temp) ALRM
    set temp2_max_hyst    60    # SIO (internal temp) ALRM clear

    set temp3_max    65    # CPU (surface temp) ALRM
    set temp3_max_hyst    60    # CPU (surface temp) ALRM clear

    set temp4_max    60    # SYS (surface temp) ALRM
    set temp4_max_hyst    55    # SYS (surface temp) ARLM clear

    set fan1_min 3500        # CPU FAN
    set fan2_min 3000        # SYS FAN

####### End /etc/sensors.d/foxconn_600A01-6LRS ######



(I have the motherboard schematic. Was a bit hard to find - had to  registe=
r to=20
chinese search engine; baidu, to be able to download it. Can  upload it=20
somewhere else upon request)

Please let me know if you think it looks okay, and whether it's worth posti=
ng in=20
the "motherboard specific configuration" section of the wiki.

Thanks,
Jasmine


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
