From: MrNice <wxcvbn2006@iol.ie>
Date: Thu, 13 Sep 2012 08:19:39 +0000
Subject: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <5051971B.7030608@iol.ie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I try to get the measurements from my hardware motherboard. I installed=20
lm_sensors-3.3.2 and the driver groeck-w83627ehf-d0f3584

As, when I run sensors, I get 0 RPM  (min =3D    0 RPM)

+++++++++++++++++++++++++
~$ sensors
nct6776-isa-0290
Adapter: ISA adapter
Vcore:        +0.90 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:          +1.85 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:         +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:          +0.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:          +1.72 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +0.00 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
Fan_01:         0 RPM  (min =3D    0 RPM)  ALARM
fan2:           0 RPM  (min =3D    0 RPM)  ALARM
fan3:           0 RPM  (min =3D    0 RPM)  ALARM
fan4:           0 RPM  (min =3D  500 RPM)  ALARM
SYSTIN:       +27.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM se=
nsor =3D=20
thermistor
CPUTIN:       +24.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
AUXTIN:      +127.5=B0C  (high =3D +114.0=B0C, hyst =3D +114.0=B0C)  ALARM =
sensor=20
=3D thermistor
cpu0_vid:    +0.000 V
intrusion0:  ALARM
intrusion1:  OK

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:      117.23 W  (crit =3D 124.95 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +5.6=B0C  (high =3D +70.0=B0C)
                        (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
++++++++++++++++++++++++++++


Following the advice
http://lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors
I added the divisor in the sensors3.conf:

+++++++++++++++++++++++++
chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"

     label in0 "Vcore"
     label in2 "AVCC"
     label in3 "+3.3V"
     label in7 "3VSB"
     label in8 "Vbat"

     set in2_min  3.3 * 0.90
     set in2_max  3.3 * 1.10
     set in3_min  3.3 * 0.90
     set in3_max  3.3 * 1.10
     set in7_min  3.3 * 0.90
     set in7_max  3.3 * 1.10
     set in8_min  3.0 * 0.90
     set in8_max  3.0 * 1.10

# For parser test
     label fan1 "Fan_01"
     ignore fan5
     set fan4_min 500
     set fan4_div 8     # Parser error

#    label temp1 "w83627 TEMPERATURE 01" # OK parser

chip "k10temp-*"

#    label temp1 "k10 TEMPERATURE 01" # OK parser

chip "fam15h_power-*"

#    label power1 "fam15h POWER 01" # OK parser
++++++++++++++++++++++++

When I run sensors -s with the line
set fan4_div 8
I get the error

++++++++++++++++++++++++
~$ sudo sensors -s
Error: File /etc/sensors3.conf, line 41: Unknown feature name
nct6776-isa-0290: No such subfeature known
++++++++++++++++++++++++

You can see in the sensors3.conf, other lines are OK with the parser.
I tried with different divisors and different fan numbers.
Could you tell me whether it's my mistake or a bug?

Configuration:
ASRock 970 Extreme4 UEFI v2.00
AMD FX-8120
Kernel 3.2.0-30-generic
Ubuntu 12.04 64-bit
lm_sensors-3.3.2 (manual install)
driver groeck-w83627ehf-d0f3584 (manual install)


BTW, could you give me a link where I could get the definition/info=20
regarding the labels SYSTIN, CPUTIN, etc...
You can see I have AUXTIN: +127.5=B0C. I don't know what is this value but =

looks for me very suspicious.

Many thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
