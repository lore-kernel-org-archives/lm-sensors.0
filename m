From: Ian Pilcher <arequipeno@gmail.com>
Date: Thu, 11 Oct 2012 05:56:38 +0000
Subject: Re: [lm-sensors] Temperature sensors changed by BIOS update
Message-Id: <50765F96.20906@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <k554s3$g79$1@ger.gmane.org>
In-Reply-To: <k554s3$g79$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 10/10/2012 10:27 PM, Guenter Roeck wrote:
> Do you use the new nct6775 driver ? Can you provide the complete output o=
f the
> sensors command ?

I'm using the w83627ehf driver in Fedora 17 (3.5.6-1.fc17.x86_64).
There does not appear to be any nct6775 module, so I assume that it's
either not in 3.5.6 or not built as part of Fedora's kernel.

# modinfo w83627ehf
filename:
/lib/modules/3.5.6-1.fc17.x86_64/kernel/drivers/hwmon/w83627ehf.ko
license:        GPL
description:    W83627EHF driver
author:         Jean Delvare <khali@linux-fr.org>
depends:        hwmon-vid
intree:         Y
vermagic:       3.5.6-1.fc17.x86_64 SMP mod_unload
parm:           force_id:Override the detected device ID (ushort)
parm:           fan_debounce:Enable debouncing for fan RPM signal (ushort)

# modinfo nct6775
ERROR: Module nct6775 not found.

sensors -c /dev/null says:

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +42.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
Core 0:         +36.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
Core 1:         +42.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
Core 2:         +35.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
Core 3:         +30.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)

nct6775-isa-0290
Adapter: ISA adapter
in0:            +1.22 V  (min =3D  +0.20 V, max =3D  +1.60 V)
in1:            +0.76 V  (min =3D  +0.67 V, max =3D  +0.82 V)
in2:            +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in3:            +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:            +1.28 V  (min =3D  +1.18 V, max =3D  +1.33 V)
in5:            +1.48 V  (min =3D  +1.40 V, max =3D  +1.60 V)
in6:            +1.05 V  (min =3D  +0.60 V, max =3D  +1.60 V)
in7:            +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in8:            +3.26 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:          1506 RPM  (min =3D  251 RPM, div =3D 32)
fan2:           629 RPM  (min =3D  251 RPM, div =3D 32)
fan3:          1506 RPM  (min =3D  251 RPM, div =3D 32)
fan4:             0 RPM  (div =3D 128)
SYSTIN:         +29.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D CPU
diode
CPUTIN:         +29.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D CPU
diode
AUXTIN:        -128.0=B0C    sensor =3D CPU diode
PECI Agent 0:   +42.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
PCH_CHIP_TEMP:  +46.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
PECI Agent 1:    +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
cpu0_vid:      +0.000 V
intrusion0:    OK

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ian Pilcher                                         arequipeno@gmail.com
"Sometimes there's nothing left to do but crash and burn, or die trying"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
