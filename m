From: jingai <jingai@floatingpenguins.com>
Date: Thu, 21 Aug 2014 01:47:08 +0000
Subject: Re: [lm-sensors] Testing NCT6792D with nct6775 driver
Message-Id: <A8F22933-B26C-4310-A223-A2D3EF34F5FF@floatingpenguins.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5151B7B2-5478-4AB1-882B-1481092A1A78@floatingpenguins.com>
In-Reply-To: <5151B7B2-5478-4AB1-882B-1481092A1A78@floatingpenguins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Aug 20, 2014, at 5:01 PM, jingai <jingai@floatingpenguins.com> wrote:

> Guenter (and anyone else interested),
>=20
> I've got an MSI Z97M "gaming" motherboard with an NCT6792D Super IO chip.=
  I built your (Guenter's) driver from git and it is recognized and provide=
s, at a glance, reasonably sane readings for most things.
>=20
> For the voltages, I'm not sure how to properly map them, aside from makin=
g educated guesses.  Any insight there would be helpful.
>=20
> The fans all look right (I knew what they should be before-hand, running =
at full speed).
>=20
> SYSIN I assume is what the motherboard BIOS reports as the system temp.  =
Not sure where the sensor is, but 31C is reasonable.
>=20
> CPUTIN reads 127.5C, which is obviously wrong.  I assume the scaling is w=
rong, or maybe it's not connected, but the BIOS does report a temp for the =
CPU.  It seems to be about 10 degrees C high in the BIOS though, for what t=
hat's worth.
>=20
> I don't really know what the AUX temps are.  0 could be something interes=
ting it seems, but 1-3 are obviously either wrong or not connected up?
>=20
> But more than asking for help, I'm offering to help test the driver with =
this chip, in case you don't have one sitting in front of you.  Let me know=
 what information you might need/want.
>=20
> Here's the output from sensors currently:
>=20
> nct6792-isa-0a00
> Adapter: ISA adapter
> in0:                    +0.90 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in2:                    +3.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in3:                    +3.25 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in4:                    +1.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in5:                    +0.83 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in6:                    +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in7:                    +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in8:                    +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in9:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in10:                   +0.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in11:                   +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
> in12:                   +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in13:                   +0.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in14:                   +1.83 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> fan1:                  1299 RPM  (min =3D    0 RPM)
> fan2:                  2115 RPM  (min =3D    0 RPM)
> fan3:                  1508 RPM  (min =3D    0 RPM)
> fan4:                  1495 RPM  (min =3D    0 RPM)
> fan5:                     0 RPM  (min =3D    0 RPM)
> SYSTIN:                 +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0=
C)  ALARM  sensor =3D CPU diode
> CPUTIN:                +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0=
C)  ALARM  sensor =3D CPU diode
> AUXTIN0:                +38.0=B0C    sensor =3D thermistor
> AUXTIN1:               +127.0=B0C    sensor =3D thermistor
> AUXTIN2:               -128.0=B0C    sensor =3D thermistor
> AUXTIN3:                -60.0=B0C    sensor =3D thermal diode
> PECI Agent 0:           +32.5=B0C =20
> PCH_CHIP_CPU_MAX_TEMP:   +0.0=B0C =20
> PCH_CHIP_TEMP:           +0.0=B0C =20
> PCH_CPU_TEMP:            +0.0=B0C =20
> intrusion0:            ALARM
> intrusion1:            ALARM
> beep_enable:           disabled

This is what I have so far.  Vcore doesn't match reality though and I'm not=
 sure why, since it should be in range of the ADC (so scaling shouldn't be =
required), if I'm understanding things correctly.  sensors says 0.90V, BIOS=
 reports 1.05V, and i7z says 1.15V.  Which is correct?

Also, BIOS reports DRAM voltage, but I'm not seeing any value here that cou=
ld be that, without scaling.  Am I missing something?

Config:

chip "nct6792-isa-0a00"
        label in0 "Vcore"
        label in1 "+5V"
                compute in1 @ * (40 / 8), @ / (40 / 8)
                set in1_min 5 * 0.95
                set in1_max 5 * 1.05
        label in2 "AVCC"
                set in2_min 3.3 * 0.95
                set in2_max 3.3 * 1.05
        label in3 "+3.3V"
                set in3_min 3.3 * 0.95
                set in3_max 3.3 * 1.05
        label in4 "+12V"
                compute in4 @ * (96 / 8), @ / (96 / 8)
                set in4_min 12 * 0.95
                set in4_max 12 * 1.05
#       ignore in5                      # DRAM?
#       ignore in6                      # not sure
        label in7 "3VSB"
                set in7_min 3.3 * 0.95
                set in7_max 3.3 * 1.05
        label in8 "Vbat"
                set in8_min 3.3 * 0.95
                set in8_max 3.3 * 1.05
#       ignore in9                      # not sure
#       ignore in10                     # GPU Voltage?
#       ignore in11                     # not sure
#       ignore in12                     # not sure
#       ignore in13                     # not sure
#       ignore in14                     # not sure

        label fan1 "RSys Fan"
                set fan1_min 1000
        label fan2 "CPU Fan"
                set fan2_min 1000
        label fan3 "FSys Fan1"
                set fan3_min 1000
        label fan4 "FSys Fan2"
                set fan4_min 1000
        ignore fan5

        label temp1 "SYS Temp"          # SYSTIN, reads around 30C, not sur=
e if accurate
                set temp1_max 40
                set temp1_max_hyst 35
        ignore temp2                    # CPUTIN, reads 127.5C always.. dun=
no
        ignore temp3                    # AUXTIN0
        ignore temp4                    # AUXTIN1
        ignore temp5                    # AUXTIN2
        ignore temp6                    # AUXTIN3
        label temp7 "CPU Temp"          # PECI Agent 0, CPU temp
        ignore temp8                    # PCH_CHIP_CPU_MAX_TEMP
        ignore temp9                    # PCH_CHIP_TEMP
        ignore temp10                   # PCH_CPU_TEMP
        ignore intrusion0
        ignore intrusion1
        ignore beep_enable


And the output from sensors:

nct6792-isa-0a00
Adapter: ISA adapter
Vcore:        +0.89 V  (min =3D  +0.00 V, max =3D  +1.74 V)
+5V:          +5.08 V  (min =3D  +4.76 V, max =3D  +5.24 V)
AVCC:         +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+3.3V:        +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+12V:        +12.00 V  (min =3D +11.42 V, max =3D +12.58 V)
in5:          +0.83 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:          +0.85 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:         +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
Vbat:         +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in9:          +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in10:         +0.22 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in11:         +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
in12:         +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in13:         +0.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in14:         +1.82 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
RSys Fan:    1299 RPM  (min =3D 1000 RPM)
CPU Fan:     2093 RPM  (min =3D 1000 RPM)
FSys Fan1:   1501 RPM  (min =3D 1000 RPM)
FSys Fan2:   1488 RPM  (min =3D 1000 RPM)
SYS Temp:     +29.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=B0C)  sensor =
=3D CPU diode
CPU Temp:     +32.0=B0C
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
