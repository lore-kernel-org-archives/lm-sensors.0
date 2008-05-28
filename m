From: Santi Saez <santi@hostalia.com>
Date: Wed, 28 May 2008 08:52:35 +0000
Subject: [lm-sensors] LM93,
Message-Id: <F65D5AB4-8165-4D76-8E5A-F2F4CE1696E3@hostalia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Dear Srs,

I want to monitor some temperatures in a server with a Supermicro =20
X6DH8-XG2 motherboard with 2 Xeon processors, running Linux 2.6.25.4 =20
and lm-sensors v3.0.2, in a Debian Etch box.

LM93 and PC87427 Super I/O sensor chips are detected, according to =20
the wiki only LM93 is fully supported by lm-sensors, in PC87427 fan =20
monitoring only is available, this is an example of the command output:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
=3D=3D=3D
# sensors
lm93-i2c-0-2e
Adapter: SMBus I801 adapter at 1100
in1:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
in2:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
in3:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
in4:         +1.21 V  (min =3D  +1.08 V, max =3D  +1.32 V)
in5:         +1.49 V  (min =3D  +1.35 V, max =3D  +1.66 V)
in6:         +1.50 V  (min =3D  +1.35 V, max =3D  +1.66 V)
in7:         +1.35 V  (min =3D  +1.02 V, max =3D  +1.54 V)
in8:         +1.36 V  (min =3D  +1.02 V, max =3D  +1.54 V)
in9:         +3.35 V  (min =3D  +2.97 V, max =3D  +3.64 V)
in10:        +5.02 V  (min =3D  +4.47 V, max =3D  +5.49 V)
in11:        +0.00 V  (min =3D  +2.25 V, max =3D  +2.76 V)
in12:        +1.79 V  (min =3D  +1.77 V, max =3D  +2.17 V)
in13:        +1.19 V  (min =3D  +0.89 V, max =3D  +1.09 V)
in14:        +0.97 V  (min =3D  +0.89 V, max =3D  +1.09 V)
in15:        +0.30 V  (min =3D  +0.07 V, max =3D  +0.54 V)
in16:        +3.41 V  (min =3D  +2.97 V, max =3D  +3.63 V)
fan1:          0 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
temp1:       +32.0=B0C  (low  =3D -128.0=B0C, high =3D -128.0=B0C)
temp2:       +32.0=B0C  (low  =3D -128.0=B0C, high =3D -128.0=B0C)
temp3:       +27.0=B0C  (low  =3D -128.0=B0C, high =3D +50.0=B0C)
cpu0_vid:   +1.088 V
cpu1_vid:   +1.088 V
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
=3D=3D=3D

What's the meaning of temp1, temp2 and temp3 params? maybe physical =20
processors (temp1, temp2) and mother board (temp3)? There's no info =20
about lm93 chip in "/etc/sensors3.conf" file..

Is there anyway to get processor temperatures in this motherboard =20
using ACPI? There's no data inside "/proc/acpi/thermal_zone/".. =20
running "acpi" I get this error:

# modprobe thermal
# acpi --thermal
No support for device type: thermal

Regards!

--
Santi Saez


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
