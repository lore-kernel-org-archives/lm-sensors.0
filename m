From: ianp <braveheart_leo@yahoo.com>
Date: Thu, 20 Feb 2014 02:59:18 +0000
Subject: [lm-sensors] Need help setting up sensors on Gigabye GA-945GCM-S2L (IT8718F)
Message-Id: <1392865158.7385.YahooMailNeo@web160501.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I wish to share some more configurations as I set them up. Now I'm trying t=
o configure my sensors on a Gigabyte GA-945GCM-S2L, running Linux 3.2.


$ dmesg | grep it87
it87: Found IT8718F chip at 0x290, revision 4
it87: Beeping is supported


Here's the default and unscaled sensors output:

$ sensors -u

it8718-isa-0290
Adapter: ISA adapter
in0:
=A0 in0_input: 1.184
=A0 in0_min: 0.848
=A0 in0_max: 1.360
=A0 in0_alarm: 0.000
=A0 in0_beep: 0.000
in1:
=A0 in1_input: 1.840
=A0 in1_min: 1.712
=A0 in1_max: 1.888
=A0 in1_alarm: 1.000
=A0 in1_beep: 0.000
in2:
=A0 in2_input: 3.392
=A0 in2_min: 3.136
=A0 in2_max: 3.472
=A0 in2_alarm: 0.000
=A0 in2_beep: 0.000
in3:
=A0 in3_input: 4.080
=A0 in3_min: 0.000
=A0 in3_max: 4.080
=A0 in3_alarm: 1.000
=A0 in3_beep: 0.000
in4:
=A0 in4_input: 3.120
=A0 in4_min: 2.896
=A0 in4_max: 3.200
=A0 in4_alarm: 0.000
=A0 in4_beep: 0.000
in5:
=A0 in5_input: 4.080
=A0 in5_min: 0.000
=A0 in5_max: 4.080
=A0 in5_alarm: 1.000
=A0 in5_beep: 0.000
in6:
=A0 in6_input: 4.080
=A0 in6_min: 0.000
=A0 in6_max: 4.080
=A0 in6_alarm: 1.000
=A0 in6_beep: 0.000
in7:
=A0 in7_input: 4.080
=A0 in7_min: 0.000
=A0 in7_max: 4.080
=A0 in7_alarm: 1.000
=A0 in7_beep: 0.000
Vbat:
=A0 in8_input: 3.056
fan1:
=A0 fan1_input: 1762.000
=A0 fan1_min: 900.000
=A0 fan1_alarm: 0.000
=A0 fan1_beep: 1.000
fan2:
=A0 fan2_input: 2089.000
=A0 fan2_min: 0.000
=A0 fan2_alarm: 0.000
=A0 fan2_beep: 1.000
fan3:
=A0 fan3_input: 0.000
=A0 fan3_min: 0.000
=A0 fan3_alarm: 0.000
=A0 fan3_beep: 1.000
temp1:
=A0 temp1_input: -55.000
=A0 temp1_max: 55.000
=A0 temp1_min: 20.000
=A0 temp1_alarm: 0.000
=A0 temp1_type: 4.000
=A0 temp1_beep: 1.000
temp2:
=A0 temp2_input: -2.000
=A0 temp2_max: 55.000
=A0 temp2_min: 20.000
=A0 temp2_alarm: 0.000
=A0 temp2_type: 4.000
=A0 temp2_beep: 1.000
temp3:
=A0 temp3_input: 42.000
=A0 temp3_max: 60.000
=A0 temp3_min: 127.000
=A0 temp3_alarm: 0.000
=A0 temp3_type: 3.000
=A0 temp3_beep: 1.000
cpu0_vid:
=A0 cpu0_vid: 3.500
intrusion0:
=A0 intrusion0_alarm: 1.000

From the above, in0 is Vcore, in1 is Vram (DDR18V in the bios), and in2 is =
+3.3V. I'm assuming that in3 and in4 corresponds to +5V and +12V, but I wil=
l get there shortly. The configuration is now:

=A0=A0 label=A0 in0=A0 "Vcore"
=A0=A0 label=A0 in1=A0 "Vram"=A0=A0=A0 # "DDR18V" in BIOS
=A0=A0 label=A0 in2=A0 "+3.3V"
=A0=A0 label=A0 in4=A0 "+12V"


For +12V scaling, and seeing that in4 is the only unscaled input sensor tha=
t is not at 4.080V, which is the maximum range for this Super-I/O chip, I d=
ecided to go ahead with the computation even with just two sample voltages =
that I have personally observed in the BIOS:

+12V BIOS samples: 12.302, 12.365

12.365 - 12.302 =3D 0.063

12.302 / (63/16) =3D 3.12431746

which is very close to in4 (3.120). At one time it read:

in4:
=A0 in4_input: 3.140
=A0 in4_min: 2.896
=A0 in4_max: 3.200
=A0 in4_alarm: 0.000
=A0 in4_beep: 0.000

12.365 / (63/16) =3D 3.14031746

and still as close as it gets to in4 (3.140). So my compute statement for +=
12V scaling is:

=A0=A0 compute=A0 in4=A0 @*(63/16), @/(63/16)

Here's the sensors output, using my configuration thus far:

$ sensors

it8718-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.18 V=A0 (min =3D=A0 +0.85 V, max =3D=A0 +1.3=
6 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.84 V=A0 (min =3D=A0 +1.71 V, max =3D=A0 +1=
.89 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.39 V=A0 (min =3D=A0 +3.14 V, max =3D=A0 +3.4=
7 V)
in3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)=A0 ALARM
+12V:=A0=A0=A0=A0=A0=A0=A0 +12.29 V=A0 (min =3D +11.40 V, max =3D +12.60 V)
in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)=A0 ALARM
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)=A0 ALARM
in7:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)=A0 ALARM
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.06 V=A0=20
CPU Fan:=A0=A0=A0=A0 1721 RPM=A0 (min =3D=A0 900 RPM)
CHA Fan:=A0=A0=A0=A0 2096 RPM=A0 (min =3D=A0=A0=A0 0 RPM)
temp1:=A0=A0=A0=A0=A0=A0=A0 -55.0=B0C=A0 (low=A0 =3D +20.0=B0C, high =3D +5=
5.0=B0C)=A0 sensor =3D thermistor
temp2:=A0=A0=A0=A0=A0=A0=A0=A0 -2.0=B0C=A0 (low=A0 =3D +20.0=B0C, high =3D =
+55.0=B0C)=A0 sensor =3D thermistor
temp3:=A0=A0=A0=A0=A0=A0=A0 +41.0=B0C=A0 (low=A0 =3D +127.0=B0C, high =3D +=
60.0=B0C)=A0 sensor =3D thermal diode
cpu0_vid:=A0=A0=A0 +3.500 V
intrusion0:=A0 ALARM


I'm now faced with the problem of determining +5V scaling, which is not eve=
n present in the BIOS monitoring section. Even if it were present, how coul=
d I determine which unscaled sensor input to match it up if in3, in5, in6, =
and in7 are all 4.080V?

Regarding temperatures, temp1 and temp2 don't look right. How can this inva=
lid reading be rectified if=A0 possible?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
