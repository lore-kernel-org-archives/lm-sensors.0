From: Arne Riecken <arne.riecken@googlemail.com>
Date: Tue, 11 May 2010 08:55:27 +0000
Subject: [lm-sensors] after some days,
Message-Id: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

after some days some min or max values for sensors get zero and
therefore an alaram is triggered. sonsors -s cures that but only if
the values are defined in the sensors3.conf. If default values are
used, there is no way out, You have to manually set them.

chip "w83627ehf-*" "w83627dhg-*"

Linux 2.6.26-2-xen-amd64

OS Debian 5.0 "Lenny"

For example today VBAT max was suddenly 0, I had to reread it with
sensors -s as You see below the correct value again.

How to fix that?

# sensors
w83627dhg-isa-0a10
Adapter: ISA adapter
VCore:       +0.91 V  (min =3D  +0.60 V, max =3D  +1.49 V)
in1:        +12.20 V  (min =3D +10.82 V, max =3D +13.20 V)
AVCC:        +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)
3VCC:        +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in4:         +1.55 V  (min =3D  +1.35 V, max =3D  +1.65 V)
in6:         +4.74 V  (min =3D  +4.25 V, max =3D  +5.25 V)
VSB:         +3.26 V  (min =3D  +2.98 V, max =3D  +3.47 V)
VBAT:        +3.12 V  (min =3D  +2.80 V, max =3D  +3.47 V)
CPU Fan:    2636 RPM  (min =3D 1205 RPM, div =3D 8)
Aux Fan:    12735 RPM  (min =3D 8035 RPM, div =3D 1)
Sys Temp:    +31.0=B0C  (high =3D +60.0=B0C, hyst =3D +50.0=B0C)  sensor =
=3D thermistor
CPU Temp:    +38.5=B0C  (high =3D +95.0=B0C, hyst =3D +90.0=B0C)  sensor =
=3D diode
AUX Temp:    +38.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
cpu0_vid:   +1.300 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
