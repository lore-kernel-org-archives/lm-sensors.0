From: e_r_i_c@gmx.net (Eric Schumann)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: W83697HF works fine for me with modifications to conf file
Message-Id: <20040204005233.736cd618.e_r_i_c@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hi friends,
I got a new AMD tyan board and kernel 2.4.24 custom on debian, it reads
the same as the bios after modifing the sensors.conf file. I hope you
find the information usefull, even as I started with an older
package.=20

Oh don't worry about the fans as they turn less than 2000Umin
and are not reported turning by the bios screen either ;-)

greets & thanks eric

you may find the relevant parts of the conf file beyond the two outputs
-------------- next part --------------
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.56 V  (min =3D  +1.47 V, max =3D  +1.82 V)       ALARM
VAgp:      +1.52 V  (min =3D  +1.42 V, max =3D  +1.56 V)       ALARM
+5V:       +4.99 V  (min =3D  +4.72 V, max =3D  +5.24 V)
+12V:     +11.67 V  (min =3D +10.79 V, max =3D +13.19 V)
+3.3V:     +3.20 V  (min =3D  +3.13 V, max =3D  +3.45 V)       ALARM
Vdimm:     +2.54 V  (min =3D  +2.36 V, max =3D  +2.62 V)       ALARM
VBat:      +3.15 V  (min =3D  +2.84 V, max =3D  +3.29 V)
V5SB:      +4.97 V  (min =3D  +4.72 V, max =3D  +5.24 V)
fan1:        0 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)
temp1:       +29=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D thermistor                                                             =
                   =20
temp2:     +32.0=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D thermistor                                                             =
                   =20
alarms:
beep_enable:
Sound alarm disabled
	  =20
me@new-sid-box:~$ sensors
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.58 V  (min =3D  +1.47 V, max =3D  +1.82 V)
VAgp:      +1.52 V  (min =3D  +1.42 V, max =3D  +1.56 V)
+5V:       +4.99 V  (min =3D  +4.72 V, max =3D  +5.24 V)
+12V:     +11.67 V  (min =3D +10.79 V, max =3D +13.19 V)
+3.3V:     +3.18 V  (min =3D  +3.13 V, max =3D  +3.45 V)
Vdimm:     +2.54 V  (min =3D  +2.36 V, max =3D  +2.62 V)
VBat:      +3.16 V  (min =3D  +2.84 V, max =3D  +3.29 V)
V5SB:      +4.97 V  (min =3D  +4.72 V, max =3D  +5.24 V)
fan1:        0 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)
temp1:       +28=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D thermistor
temp2:     +31.5=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D thermistor                                                             =
                   =20
alarms:
beep_enable:
Sound alarm disabled
sensors version 2.7.0
---snip sensors.conf
chip "w83697hf-*"

# Same as above for w83781d except that in5 and in6 are computed differentl=
y.
# Rather than an internal inverting op amp, the 82d/83s use standard positi=
ve
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

# no in1 on this chip.
#tries to implement Tyan Trinity S2495 KT400 special wires
    label in0 "VCore"
    label in2 "VAgp"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "+3.3V"
    label in6 "Vdimm"
    label in7 "VBat"
    label in8 "V5SB"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
#    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
#    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in8 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# 697HF does not have VID inputs so you MUST set your core
# voltage limits below. Currently set for 1.8V core.
#               vvv

    set in0_min 1.55 * 0.95
    set in0_max 1.75 * 1.05
    set in2_min 1.5 * 0.95
    set in2_max 1.5 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05
    set in6_min 2.5 * 0.95
    set in6_max 2.5 * 1.05
    set in7_min 3.0 * 0.95
    set in7_max 3.0 * 1.10
    set in8_min 5 * 0.95
    set in8_max 5 * 1.05

# set up sensor types (thermistor is default)
# 1 =3D PII/Celeron Diode; 2 =3D 3904 transistor;
# 3435 =3D thermistor with Beta =3D 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47
--snip versions.h
#define LM_DATE "20020322"
#define LM_VERSION "2.6.3"
