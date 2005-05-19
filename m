From: Luke.Munholand@USherbrooke.ca (Luke Munholand)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: issue with IT87 on Asus
Message-Id: <1108697448.42156168bbec2@www.usherbrooke.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

First off, I'd like to say thanks to you for writing such a great program. =

Works great on my i810 chipset on the other computer.  This computer is a
different story though....

I'm hoping for a couple hints that will help me get my darned fans to turn =
off
(turn slower)!  I have used the windows program "speedfan" which detects and
controls my fan1 (CPU) properly.  From Speed Fan:  ITE 8712F super IO.  ISA=
 bus
$0290 linked ISA bus @ $0D00  ... IT8712F/IT8705F at $D00

I have an Asus A7N8x-VM/400 motherboard that lm_sensors "sensors-detect"
correctly detects has a IT8712F chip on the ISA bus.

link to motherboard:
http://www.asus.com/prog/spec.asp?m=A7N8X-VM/400&langs=01


SUMMARY OF PROBLEM
1. I patched 2.9.0.1 and compiled i2c for my 2.4.29 kernel (stock slackware
10.1)
2. I tried to compile lm_sensors-2.9.0 but got errors (even after doing ldc=
onfig
-v) *weird*
3. I downloaded the most recent "daily" cvs snapshot which compiled and it
compiled and installed properly.
4. "sensors-detect" correctly identified the IT87 chip.
5.  lm_sensors2/prog/pwm/pwmconfig cant seem to stop the fan1?  it says:

------------------------------------------------------------
Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control it8712-isa-0d00/pwm1 ...
  it8712-isa-0d00/fan1 ... speed was 4166 now 4166
    no correlation

No correlations were detected.
There is either no fan connected to the output of it8712-isa-0d00/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)
-----------------------------------------------------

ARRRGGG
so I find in /proc/sys/dev/sensors/it8712-isa-0d00#  The "control" files pw=
m1
and  echo 0> pwm1

Still no joy...the fan refuses to stop.


Any guesses?


"sensors" gives in part (after i monkeyed with the /etc/sensors.conf file .=
..the
CPU and Motherboard chipset temps seemed inverted.)
-----------------------------------------------------------
it8712-isa-0d00
Adapter: ISA adapter
VCore 1:   +1.63 V  (min =3D  +1.42 V, max =3D  +1.57 V)   ALARM
VCore 2:   +1.57 V  (min =3D  +2.40 V, max =3D  +2.61 V)   ALARM
+3.3V:     +6.62 V  (min =3D  +3.14 V, max =3D  +3.46 V)   ALARM
+5V:       +4.94 V  (min =3D  +4.74 V, max =3D  +5.24 V)
+12V:     +11.84 V  (min =3D +11.40 V, max =3D +12.60 V)
-12V:      -7.88 V  (min =3D -12.63 V, max =3D -11.41 V)   ALARM
-5V:       -7.32 V  (min =3D  -5.24 V, max =3D  -4.76 V)   ALARM
Stdby:     +5.06 V  (min =3D  +4.74 V, max =3D  +5.24 V)
VBat:      +4.08 V
fan1:     4166 RPM  (min =3D    0 RPM, div =3D 2)
fan2:        0 RPM  (min =3D    0 RPM, div =3D 128)
fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Temp:    +43?C  (low  =3D   +15?C, high =3D   +40?C)   sensor =3D diode
M/B Temp:    +37?C  (low  =3D   +15?C, high =3D   +45?C)   sensor =3D therm=
istor
Temp3:        -1?C  (low  =3D   +15?C, high =3D   +45?C)   sensor =3D disab=
led
vid:       +1.65 V

---------------------------------------------------------


also you may want to know what modules are running (I also checked the kern=
el
config file and all i2c stuff is built as modules).


lsmod gives:
--------------------------------------------------------
Module                  Size  Used by    Not tainted
i2c-dev                 3424   0
i2c-isa                  784   0  (unused)
i2c-nforce2             3400   0
it87                   10164   1
eeprom                  3564   0
i2c-proc                6148   1  [it87 eeprom]
i2c-core               14852   0  [i2c-dev i2c-isa i2c-nforce2 it87 eeprom
i2c-proc]
snd-pcm-oss            36704   0  (unused)
snd-mixer-oss          12152   0  [snd-pcm-oss]
usb-ohci               19368   0  (unused)
ehci-hcd               17516   0  (unused)
usbcore                58860   1  [usb-ohci ehci-hcd]
forcedeth               9868   1
snd-intel8x0           18080   0
snd-ac97-codec         52472   0  [snd-intel8x0]
snd-pcm                54504   0  [snd-pcm-oss snd-intel8x0 snd-ac97-codec]
snd-timer              13412   0  [snd-pcm]
snd                    31268   0  [snd-pcm-oss snd-mixer-oss snd-intel8x0
snd-ac97-codec snd-pcm snd-timer]
soundcore               3396   4  [snd]
snd-page-alloc          4712   0  [snd-mixer-oss snd-intel8x0 snd-pcm snd-t=
imer
snd]
ide-scsi                9392   0
agpgart                45092   0  (unused)
--------------------------------------------------------



At this point, all I can say is I'll try a 2.6 kernel?  Somehow I doubt that
will fix the problem though. I could try to fix it myself but have 0 experi=
ence
with hardware programming (though I am familiar with C )

Any words of wisdom or tips on how I can get the CPU fan to slow down in li=
nux
..again it is possible because it does work with the Windoze prog Speed an.

Thanks a bunch!

Luke




PS The pertinant part of  /etc/sensors.conf follows:
------------------------------------------------------------
chip "it87-*" "it8712-*"

# The values below have been tested on Asus CUSI, CUM motherboards.

# Voltage monitors as advised in the It8705 data sheet

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    # vid is not monitored by IT8705F
    # comment out if you have IT8712
   # ignore  vid

# Incubus Saturnus reports that the IT87 chip on Asus A7V8X-X seems
# to report the VCORE voltage approximately 0.05V higher than the board's
# BIOS does. Although it doesn't make much sense physically, uncommenting
# the next line should bring the readings in line with the BIOS' ones in
# this case.
# compute in0 -0.05+@ , @+0.05

# If 3.3V reads 2X too high (Soyo Dragon and Asus A7V8X-X, for example),
# comment out following line.
    compute in2   2*@ , @/2
#
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
# For this family of chips the negative voltage equation is different from
# the lm78.  The chip uses two external resistor for scaling but one is
# tied to a positive reference voltage.  See ITE8705/12 datasheet (SIS950
# data sheet is wrong)
# Vs =3D (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
# Vref =3D 4.096 volts, Vin is voltage measured, Vs is actual voltage.

# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V Vre=
f.
# Formula:
#    actual V =3D (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
#    For -12V input use Rin/Rf =3D 6.68
#    For -5V input use Rin/Rf =3D 3.33
# Then you can convert the forumula to a standard form like:
    compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
    compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
#
# this much simpler version is reported to work for a
# Elite Group K7S5A board
#
#   compute in5 -(36/10)*@, -@/(36/10)
#   compute in6 -(56/10)*@, -@/(56/10)
#
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set in0_min 1.5 * 0.95
    set in0_max 1.5 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    #the chip does not support in8 min/max

# Temperature
#
# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type.
# Adujst and uncomment the appropriate lines below.
# The old method (modprobe it87 temp_type=3D0xXX) is no longer supported.
#
# 2 =3D thermistor; 3 =3D thermal diode; 0 =3D unused
#   set sensor1 3
#   set sensor2 3
#   set sensor3 3
# If a given sensor isn't used, you will probably want to ignore it
# (see ignore statement right below).

#    label temp1       "M/B Temp"
    set   temp1_over  40
    set   temp1_low   15
#    label temp2       "CPU Temp"
    set   temp2_over  45
    set   temp2_low   15
#   ignore temp3
    label temp3       "Temp3"
    set   temp3_over  45
    set   temp3_low   15

# The A7V8X-X has temperatures inverted, and needs a conversion for
# CPU temp. Thanks to Preben Randhol for the formula.
   label temp1       "CPU Temp"
   label temp2       "M/B Temp"
   compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893

# The A7V600 also has temperatures inverted, and needs a different
# conversion for CPU temp. Thanks to Dariusz Jaszkowski for the formula.
#   label temp1       "CPU Temp"
#   label temp2       "M/B Temp"
#   compute temp1     (@+128)/3, (3*@-128)

# Fans
    set fan1_min 0
    set fan2_min 0
#   ignore fan3
    set fan3_min 0

# The following is for the Inside Technologies 786LCD which uses either a
# IT8705F or a SIS950 for monitoring with the SIS630.
# You will need to load the it87 module as follows to select the correct
# temperature sensor type.
# modprobe it87 temp_type=3D0x31
# The sensors-detect program reports lm78 and a sis5595 and lists the it87 =
as
# a misdetect.  Don't do the modprobe for the lm78 or sis5595 as suggested.
#
# delete or comment out above it87 section and uncomment the following.
#chip "it87-*"
#    label in0 "VCore 1"
#    label in1 "VCore 2"
#    label in2 "+3.3V"
#    label in3 "+5V"
#    label in4 "+12V"
#    label in5 "3.3 Stdby"
#    label in6 "-12V"
#    label in7 "Stdby"
#    label in8 "VBat"
    # in0 will depend on your processor VID value, set to voltage specified=
 in
    # bios setup screen
#    set in0_min 1.7 * 0.95
#    set in0_max 1.7 * 1.05
#    set in1_min 2.4
#    set in1_max 2.6
#    set in2_min 3.3 * 0.95
#    set in2_max 3.3 * 1.05
#    set in3_min 5.0 * 0.95
#    set in3_max 5.0 * 1.05
    # +- 12V are very poor tolerance on this board. Verified with voltmeter
#    set in4_min 12 * 0.90
#    set in4_max 12 * 1.10
#    set in5_min 3.3 * 0.95
#    set in5_max 3.3 * 1.05
#    set in6_max -12 * 0.90
#    set in6_min -12 * 1.10
#    set in7_min 5 * 0.95
#    set in7_max 5 * 1.05
    # vid not monitored by IT8705F
#    ignore  vid

#    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
#    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
#    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
#    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    # Temperature
#    label temp1       "CPU Temp"
#    ignore temp2
#    ignore temp3
    # Fans
#    set fan1_min 3000
#    ignore fan2
#    ignore fan3


chip "fscpos-*"
# Fujitsu-Siemens Poseidon chip

# Temperature





