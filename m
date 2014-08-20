From: jingai <jingai@floatingpenguins.com>
Date: Wed, 20 Aug 2014 21:01:26 +0000
Subject: [lm-sensors] Testing NCT6792D with nct6775 driver
Message-Id: <5151B7B2-5478-4AB1-882B-1481092A1A78@floatingpenguins.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter (and anyone else interested),

I've got an MSI Z97M "gaming" motherboard with an NCT6792D Super IO chip.  =
I built your (Guenter's) driver from git and it is recognized and provides,=
 at a glance, reasonably sane readings for most things.

For the voltages, I'm not sure how to properly map them, aside from making =
educated guesses.  Any insight there would be helpful.

The fans all look right (I knew what they should be before-hand, running at=
 full speed).

SYSIN I assume is what the motherboard BIOS reports as the system temp.  No=
t sure where the sensor is, but 31C is reasonable.

CPUTIN reads 127.5C, which is obviously wrong.  I assume the scaling is wro=
ng, or maybe it's not connected, but the BIOS does report a temp for the CP=
U.  It seems to be about 10 degrees C high in the BIOS though, for what tha=
t's worth.

I don't really know what the AUX temps are.  0 could be something interesti=
ng it seems, but 1-3 are obviously either wrong or not connected up?

But more than asking for help, I'm offering to help test the driver with th=
is chip, in case you don't have one sitting in front of you.  Let me know w=
hat information you might need/want.

Here's the output from sensors currently:

nct6792-isa-0a00
Adapter: ISA adapter
in0:                    +0.90 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in2:                    +3.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in3:                    +3.25 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in4:                    +1.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:                    +0.83 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:                    +0.78 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in7:                    +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in8:                    +3.30 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in9:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in10:                   +0.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in11:                   +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
in12:                   +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in13:                   +0.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in14:                   +1.83 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
fan1:                  1299 RPM  (min =3D    0 RPM)
fan2:                  2115 RPM  (min =3D    0 RPM)
fan3:                  1508 RPM  (min =3D    0 RPM)
fan4:                  1495 RPM  (min =3D    0 RPM)
fan5:                     0 RPM  (min =3D    0 RPM)
SYSTIN:                 +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)=
  ALARM  sensor =3D CPU diode
CPUTIN:                +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)=
  ALARM  sensor =3D CPU diode
AUXTIN0:                +38.0=B0C    sensor =3D thermistor
AUXTIN1:               +127.0=B0C    sensor =3D thermistor
AUXTIN2:               -128.0=B0C    sensor =3D thermistor
AUXTIN3:                -60.0=B0C    sensor =3D thermal diode
PECI Agent 0:           +32.5=B0C =20
PCH_CHIP_CPU_MAX_TEMP:   +0.0=B0C =20
PCH_CHIP_TEMP:           +0.0=B0C =20
PCH_CPU_TEMP:            +0.0=B0C =20
intrusion0:            ALARM
intrusion1:            ALARM
beep_enable:           disabled
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
